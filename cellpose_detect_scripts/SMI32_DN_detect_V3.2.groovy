//**细胞检测控制边界大小
 //* 优化的 Cellpose Detection 脚本 - 专用于2型FCD异型神经元检测
 //* @author Olivier Burri (原始模板)
 //* 优化参数用于提高异型神经元检出率
 //*/
import qupath.lib.images.servers.TransformedServerBuilder
import qupath.lib.images.servers.PixelType
import qupath.lib.images.ImageData
import qupath.lib.images.ImageData.ImageType
import qupath.ext.biop.cellpose.Cellpose2D

// 获取当前图像
def imageData = getCurrentImageData()
def server    = imageData.getServer()
def stains    = imageData.getColorDeconvolutionStains()

// 构建新的 server：去卷积取 DAB，然后转换为 8-bit
def deconvServer = new TransformedServerBuilder(server)
        .deconvolveStains(stains, 2)          // 取 DAB
//        .convertToType(PixelType.UINT8)       // 改成 8-bit
        .build()

// 用新 server 构造 ImageData，类型标为 FLUORESCENCE
def deconvImageData = new ImageData<>(
        deconvServer,
        imageData.getHierarchy(),            // 保留原注释/检测；不需要时传 null
        ImageType.FLUORESCENCE
)

// 模型路径 - 保留你的自定义模型，如果检出率仍不理想，可尝试切换到 'cyto3' 或 'cyto2_omni'
def pathModel = 'D:/graduate_project/chenchunping_2024_tt/classifier/SMI32_DN_new/models/SMI32_DN'
// def pathModel = 'cyto3'  // 备选：通用模型，对病理组织表现更好
// def pathModel = 'cyto2_omni'  // 备选：Omnipose模型，专门处理不规则形态

def cellpose = Cellpose2D.builder( pathModel )
        .pixelSize( 0.5 )                      // Resolution for detection in um
        .channels(0)                           // Select detection channel(s)
//        .tempDirectory( new File( '/tmp' ) )         // Temporary directory to export images to
        
        // 关键优化：预处理步骤
        .normalizePercentilesGlobal( 1.0, 99.0, 4.0 )  // 全局归一化处理异质性染色
//        .preprocess( ImageOps.Filters.median( 1 ) )     // 可选：中值滤波减少噪声
        
        // 关键优化：检测敏感性参数
        .cellprobThreshold( -2.0 )            // 降低敏感性缩小边界：从-4改为-2
        .flowThreshold( 0.4 )                 // 降低流阈值获得更精确边界
        .diameter( 20 )                       // 进一步减小直径
        
        // 关键优化：瓦片设置
        .tileSize( 1024 )                     // 标准瓦片大小，适合GPU处理
        
        // 关键优化：边缘控制参数
        .cellExpansion( 0.0 )                 // 不扩展细胞边界，严格按检测结果
        .cellConstrainScale( 1.2 )            // 增加约束避免过度扩展
        .simplify( 1.0 )                      // 适度简化边缘，避免过于精细
        
        // GPU优化选项
        .useGPU(true)                         // 使用GPU
//        .useCellposeSAM()                     // 禁用SAM避免内存不足
//        .useOmnipose()                        // 如果形态极不规则，可启用Omnipose
        
        // 输出和测量设置
        .measureShape()                       // Add shape measurements
        .measureIntensity()                   // Add cell measurements (in all compartments)
        .simplify( 0 )                        // 获取最精确的mask
//        .classify( "Dysplastic Neurons" )     // 可选：为检测到的对象分类
//        .createAnnotations()                  // Make annotations instead of detections
//        .useGPU(false)                        // Force using CPU if needed
        .build()

// 执行检测
def pathObjects = getSelectedObjects() // 仅处理选中的注释区域，测试时使用
// def pathObjects = getAnnotationObjects() // 处理所有注释，批量处理时使用

if (pathObjects.isEmpty()) {
    Dialogs.showErrorMessage( "Cellpose", "请选择一个父对象!" )
    return
}

println "开始Cellpose检测，使用优化参数..."
println "模型: ${pathModel}"
println "cellprobThreshold: -4.0 (提高敏感性)"
println "flowThreshold: 0.6 (接受不规则形态)"
println "diameter: 35 (适应异型神经元大小)"

cellpose.detectObjects( deconvImageData, pathObjects )

// 后处理建议：可以在这里添加过滤条件移除过小或形态异常的对象
// 例如：移除面积小于50像素²的检测结果
// def detections = getDetectionObjects()
// def filteredDetections = detections.findAll { it.getROI().getArea() > 50 }
// clearDetections()
// addObjects(filteredDetections)

println 'Cellpose异型神经元检测完成'
println "检测到 ${getDetectionObjects().size()} 个对象"

// 额外建议：如果检出率仍不理想，尝试以下步骤：
// 1. 将 cellprobThreshold 进一步降低到 -5.0 或 -6.0
// 2. 将 flowThreshold 提高到 0.8
// 3. 切换到 cyto3 模型：def pathModel = 'cyto3'
// 4. 如果神经元形态极不规则，使用 Omnipose：.useOmnipose() 和模型 'cyto2_omni'
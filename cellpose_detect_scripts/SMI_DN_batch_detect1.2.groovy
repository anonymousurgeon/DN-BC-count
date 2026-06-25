/**
 * 分批处理的 Cellpose Detection 脚本 - 专用于2型FCD异型神经元检测
 * @author Olivier Burri (原始模板)
 * 优化参数用于提高异型神经元检出率，添加分批处理避免内存不足
 */
import qupath.lib.images.servers.TransformedServerBuilder
import qupath.lib.images.servers.PixelType
import qupath.lib.images.ImageData
import qupath.lib.images.ImageData.ImageType
import qupath.ext.biop.cellpose.Cellpose2D
import qupath.lib.gui.dialogs.Dialogs

// 配置参数
def BATCH_SIZE = 3          // 每批处理的annotation数量，可根据需要调整

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

// 获取选中的对象并检查
def pathObjects = getSelectedObjects() // 仅处理选中的注释区域，测试时使用
// def pathObjects = getAnnotationObjects() // 处理所有注释，批量处理时使用

if (pathObjects.isEmpty()) {
    Dialogs.showErrorMessage( "Cellpose", "请选择一个或多个父对象!" )
    return
}

// 将对象分批
def batches = []
for (int i = 0; i < pathObjects.size(); i += BATCH_SIZE) {
    def endIndex = Math.min(i + BATCH_SIZE, pathObjects.size())
    batches.add(pathObjects[i..<endIndex])
}

println "开始分批Cellpose检测..."
println "总对象数: ${pathObjects.size()}"
println "批次大小: ${BATCH_SIZE}"
println "总批次数: ${batches.size()}"
println "模型: ${pathModel}"

def cellpose = Cellpose2D.builder( pathModel )
        .pixelSize( 0.5 )                      // Resolution for detection in um
        .channels(0)                           // Select detection channel(s)
//        .tempDirectory( new File( '/tmp' ) )         // Temporary directory to export images to
        
        // 关键优化：预处理步骤
        .normalizePercentilesGlobal( 1.0, 99.0, 4.0 )  // 全局归一化处理异质性染色
//        .preprocess( ImageOps.Filters.median( 1 ) )     // 可选：中值滤波减少噪声
        
        // 关键优化：检测敏感性参数
        .cellprobThreshold( -6.0 )            // 提高敏感性：从-2改为-4，检测弱染色细胞
        .flowThreshold( 0.8 )                 // 接受不规则形态：从0.4改为0.6
        .diameter( 35 )                       // 异型神经元通常较大：从默认25改为35
        
        // 关键优化：瓦片和重叠设置
        .tileSize( 1024 )                     // 标准瓦片大小，适合GPU处理
        
        // 关键优化：大小和形态约束
        .cellConstrainScale( 1.2 )            // 约束细胞扩展，提高准确性
        .cellExpansion( 0.0 )
        // 高级选项
        .useCellposeSAM()                     // 使用 Cellpose SAM 提高性能
//        .useOmnipose()                        // 如果形态极不规则，可启用Omnipose
        
        // 输出和测量设置
        .measureShape()                       // Add shape measurements
        .measureIntensity()                   // Add cell measurements (in all compartments)
        .simplify( 1 )                        // 获取最精确的mask
//        .classify( "Dysplastic Neurons" )     // 可选：为检测到的对象分类
//        .createAnnotations()                  // Make annotations instead of detections
//        .useGPU(false)                        // Force using CPU if needed
        .build()

// 分批处理
batches.eachWithIndex { batch, batchIndex ->
    println "处理批次 ${batchIndex + 1}/${batches.size()} (${batch.size()}个对象)..."
    
    // 执行检测
    cellpose.detectObjects( deconvImageData, batch )
    
    println "批次 ${batchIndex + 1} 完成"
}

println 'Cellpose异型神经元检测完成'
println "检测到 ${getDetectionObjects().size()} 个对象"

// 后处理建议：可以在这里添加过滤条件移除过小或形态异常的对象
// 例如：移除面积小于50像素²的检测结果
// def detections = getDetectionObjects()
// def filteredDetections = detections.findAll { it.getROI().getArea() > 50 }
// clearDetections()
// addObjects(filteredDetections)

// 额外建议：如果检出率仍不理想，尝试以下步骤：
// 1. 将 cellprobThreshold 进一步降低到 -5.0 或 -6.0
// 2. 将 flowThreshold 提高到 0.8
// 3. 切换到 cyto3 模型：def pathModel = 'cyto3'
// 4. 如果神经元形态极不规则，使用 Omnipose：.useOmnipose() 和模型 'cyto2_omni'
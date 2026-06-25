import qupath.ext.biop.cellpose.Cellpose2D
import qupath.lib.images.servers.TransformedServerBuilder
import qupath.lib.images.ImageData
import qupath.lib.images.ImageData.ImageType

// ===== 构建 DAB 去卷积图像 =====
def imageData = getCurrentImageData()
def server = imageData.getServer()
def stains = imageData.getColorDeconvolutionStains()

if (stains == null) {
    setImageType('BRIGHTFIELD_H_DAB')
    setColorDeconvolutionStains('{"Name" : "H-DAB default", "Stain 1" : "Hematoxylin", "Values 1" : "0.65111 0.70119 0.29049", "Stain 2" : "DAB", "Values 2" : "0.26917 0.56824 0.77759", "Background" : " 255 255 255"}')
    stains = imageData.getColorDeconvolutionStains()
}

def deconvServer = new TransformedServerBuilder(server)
        .deconvolveStains(stains, 2)   // 取 DAB 分量
        .build()

def deconvImageData = new ImageData<>(
        deconvServer,
        imageData.getHierarchy(),
        ImageType.FLUORESCENCE
)

// ===== 构建 Cellpose 检测器 =====
def pathModel = 'cpsam'

def cellpose = Cellpose2D.builder( pathModel )
        .pixelSize( 0.5 )
        .channels( 0 )                              // 单通道 DAB 图像取第0通道
        .normalizePercentilesGlobal( 1.0, 99.0, 4.0 ) // 归一化，解决片子间染色差异
        .tileSize( 1024 )
        .cellprobThreshold( -4.0 )
        .flowThreshold( 0.8 )
        .diameter( 35 )
        .cellConstrainScale( 1.2 )
        .cellExpansion( -1 )
        .useCellposeSAM()
        .useGPU( true )
        .measureShape()
        .measureIntensity()
        .simplify( 1 )
        .build()

// ===== 执行检测 =====
def pathObjects = getSelectedObjects()
if (pathObjects.isEmpty()) {
    Dialogs.showErrorMessage( "Cellpose", "请选择一个父对象!" )
    return
}

println "开始 Cellpose 检测..."
println "模型: ${pathModel}"

cellpose.detectObjects( deconvImageData, pathObjects )

println "检测完成，共检测到 ${getDetectionObjects().size()} 个对象"
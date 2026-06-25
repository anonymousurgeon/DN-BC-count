// QuPath 0.6.0 - 对选中Annotation区域做颜色去卷积，导出DAB通道灰度TIF到指定路径
import qupath.lib.regions.RegionRequest
import qupath.lib.color.ColorTransformer
import qupath.lib.color.ColorTransformer.ColorTransformMethod
import java.awt.image.BufferedImage
import javax.imageio.ImageIO

def imageData = getCurrentImageData()
def server = imageData.getServer()
def stains = imageData.getColorDeconvolutionStains()

// 检查是否已设置染色矢量（H-DAB）
if (stains == null) {
    print "当前图像未设置染色矢量！请先在 Image > Type 中设为 Brightfield (H-DAB)，并设置/估计染色矢量。"
    return
}

def annotations = getSelectedObjects().findAll { it.isAnnotation() }
if (annotations.isEmpty()) {
    print "请先选中一个Annotation！"
    return
}
if (annotations.size() > 1) {
    print "检测到多个选中的Annotation，仅处理第一个。"
}

def annotation = annotations[0]
def roi = annotation.getROI()
if (roi == null) {
    print "选中的对象没有ROI！"
    return
}

double downsample = 1.0   // 1.0 = 原始分辨率
double maxOD = 1.0        // OD饱和值，用于映射到0-255灰度，可根据效果调整(0.5~2.0)

def request = RegionRequest.createInstance(server.getPath(), downsample, roi)
BufferedImage img = server.readBufferedImage(request)

int w = img.getWidth()
int h = img.getHeight()
int[] rgb = img.getRGB(0, 0, w, h, null, 0, w)

// Stain_2 对应第二个染色矢量（H-DAB方案中通常就是DAB）
float[] dabOD = ColorTransformer.getTransformedPixels(rgb, ColorTransformMethod.Stain_2, null, stains)

// 将OD值映射到0-255灰度
BufferedImage dabImg = new BufferedImage(w, h, BufferedImage.TYPE_BYTE_GRAY)
byte[] pixels = new byte[w * h]
for (int p = 0; p < dabOD.length; p++) {
    double val = dabOD[p] / maxOD * 255.0
    if (val < 0) val = 0
    if (val > 255) val = 255
    pixels[p] = (byte) Math.round(val)
}
dabImg.getRaster().setDataElements(0, 0, w, h, pixels)

// 指定输出路径
def path = "Y:/BOSD/Projects/FCD2_mri_histopath/Patient_projects/cuijiahao_888100/fiber_analysis/test.tif"
def outFile = new File(path)
def parentDir = outFile.getParentFile()
if (parentDir != null && !parentDir.exists()) {
    parentDir.mkdirs()
}

ImageIO.write(dabImg, "TIF", outFile)
print "已导出: ${path}"
//
//  UIImage+Extension.m
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UIImage+PageControlExtension.h"


static UIImage *_img = nil;

@implementation UIImage (PageControlExtension)

#pragma mark -- 读取图片
+(UIImage *)pc_imageNamed:(NSString *)IMGName InBundleNamed:(NSString *)BundleName
{
    
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: BundleName ofType:@"bundle"];
    NSString *imgPath= [bundlePath stringByAppendingPathComponent:IMGName];
    return [UIImage imageWithContentsOfFile:imgPath];
    
}

+ (UIImage *)pc_imageWithName:(NSString *)imageName withRenderingMode:(UIImageRenderingMode)imageRenderingMode {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:imageRenderingMode];
    return image;
}
#pragma mark -- resize
+ (UIImage *)pc_resizedImage:(NSString *)name
{
    return [self pc_resizedImage:name left:0.5 top:0.5];
}

+ (UIImage *)pc_resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

- (UIImage*)pc_scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    _img = self;
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
//UIImage自定长宽缩放
+(UIImage *)pc_reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

//UIImage等比例缩放
+(UIImage *)pc_scaleImage:(UIImage *)image toScale:(CGFloat)scale
{
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale, image.size.height * scale));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}


#pragma mark-- 裁剪圆形图片
+ (UIImage *)pc_roundBezierImage:(UIImage *)image
{
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    //画圆：正切于上下文
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //设为裁剪区域
    [path addClip];
    //画图片
    [image drawAtPoint:CGPointZero];
    //生成一个新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  图片剪切为圆形
 *  @return 剪切后的圆形图片
 */
- (UIImage *)pc_roundImage{
    
    //获取size
    CGSize size = [self pc_sizeFromImage:self];
    
    CGRect rect = (CGRect){CGPointZero,size};
    
    //新建一个图片图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //绘制圆形路径
    CGContextAddEllipseInRect(ctx, rect);
    
    //剪裁上下文
    CGContextClip(ctx);
    
    //绘制图片
    [self drawInRect:rect];
    
    //取出图片
    UIImage *roundImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return roundImage;
}

/**
 *  将image转换为圆型带边框的图片（最好写一个UIImage的类扩展）
 *
 *  @param name        图片的名字
 *  @param borderWidth 外层边框的宽度
 *  @param borderColor 外层边框的颜色
 *
 *  @return 返回已经处理好的圆形图片
 */
+ (UIImage *)pc_roundImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    return [self pc_roundImageWithImage:oldImage borderWidth:borderWidth borderColor:borderColor];
}
+ (UIImage *)pc_roundImageWithImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat diameter = imageW > imageH ? imageH : imageW;
    CGFloat bigRadius = diameter * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**我创建了一个分类用于创建相应的遮罩图片*/

/**提供一个在一个指定的size中绘制图片的便捷方法*/
+ (UIImage *)pc_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)pc_rectangleImageWithName:(NSString *)name borderWith:(CGFloat)borderWith borderColor:(UIColor *)borderColor {
    UIImage *image = [UIImage imageNamed:name];
    return [self pc_rectangleImageWithImage:image size:CGSizeMake(image.size.width + 2 * borderWith, image.size.height + 2 * borderWith) borderWith:borderWith borderColor:borderColor];
}
+ (UIImage *)pc_rectangleImageWithImage:(UIImage *)oldImage size:(CGSize)size borderWith:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [path addClip];
    [path stroke];
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [clipPath addClip];
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, size.width - 2 * borderWidth, size.height - 2 * borderWidth)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage *)pc_rectangleRoundCornerImageWithOldImage:(UIImage *)oldImage cornerRadiu:(CGFloat)cornerRadiu corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CGSize size = CGSizeMake(oldImage.size.width - 2 * borderWidth, oldImage.size.height - 2 * borderWidth);
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, oldImage.size.width, oldImage.size.height) cornerRadius:cornerRadiu];
    [clipPath addClip];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width , size.height) cornerRadius:cornerRadiu];
    [borderColor set];
    path.lineWidth = borderWidth;
    [path stroke];
    
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

#pragma mark -- color -> image
//UIColor 转UIImage
+ (UIImage*)pc_imageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 2, 2);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/**
 *  返回指定颜色生成的图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return img
 */
+ (UIImage *)pc_imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
/**
 *  获取指定尺寸（50*50）的图片
 *
 *  @param color 图片颜色
 *  @param name  文本,居中显示
 *
 *  @return img
 */
+ (UIImage *)pc_imageWithBGColor:(UIColor *)color text:(NSString *)name textColor:(UIColor *)textColor
{
    CGRect rect = CGRectMake(0, 0, 50, 50);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    [name drawAtPoint:CGPointMake(10, 15) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15] , NSForegroundColorAttributeName : textColor}];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
/**
 *  获取指定尺寸（size）的图片
 *
 *  @param color 图片颜色
 *  @param name  文本,居中显示
 *
 *  @return img
 */
+ (UIImage *)pc_imageWithBGColor:(UIColor *)color text:(NSString *)name textColor:(UIColor *)textColor andImageSize:(CGSize)imageSize
{
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    NSDictionary *dict=@{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGRect nameRect = [name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    CGSize nameSize = CGSizeMake(ceil(CGRectGetWidth(nameRect)), ceil(CGRectGetHeight(nameRect)));
    CGFloat originX = (imageSize.width - nameSize.width)/2.0;
    CGFloat originY = (imageSize.height - nameSize.height)/2.0;
    CGPoint origin = CGPointMake(originX, originY);
    [name drawAtPoint:origin withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15] , NSForegroundColorAttributeName : textColor}];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
/**
 *  获取指定尺寸（size）的图片
 *
 *  @param color 图片颜色
 *  @param name  文本,居中显示
 *  @param textfont  文本,字体大小
 *  @param imageSize 图片尺寸
 *  @return img
 */
+ (UIImage *)pc_imageWithBGColor:(UIColor *)color text:(NSString *)name textFont:(UIFont *)textfont textColor:(UIColor *)textColor andImageSize:(CGSize)imageSize
{
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    NSDictionary *dict=@{NSFontAttributeName : textfont};
    CGRect nameRect = [name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    CGSize nameSize = CGSizeMake(ceil(CGRectGetWidth(nameRect)), ceil(CGRectGetHeight(nameRect)));
    CGFloat originX = (imageSize.width - nameSize.width)/2.0;
    CGFloat originY = (imageSize.height - nameSize.height)/2.0;
    CGPoint origin = CGPointMake(originX, originY);
    [name drawAtPoint:origin withAttributes:@{NSFontAttributeName : textfont , NSForegroundColorAttributeName : textColor}];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
- (UIImage *)pc_imageWithColorFitToScale:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//圆形的[用颜色生成]
+ (UIImage *)pc_imageRoundWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    CGContextAddPath(context, path.CGPath);
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//圆形带边框[用颜色生成]
+ (UIImage *)pc_imageRoundWithDiameter:(CGFloat)diameter fillColor:(UIColor *)fillColor borderWith:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{

    // 计算外圆的直径(边框是在图片外额外添加的区域)
    CGFloat borderDia = diameter + 2 * borderWidth;
    // 开启图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(borderDia, borderDia));
    // 画一个包含边框的圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, borderDia, borderDia)];
    // 设置颜色
    [borderColor set];
    [path stroke];
    
    // 设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, borderDia, borderDia)];
    // 裁剪图片
    [clipPath addClip];
//    borderWidth
    UIBezierPath *centerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth/2.0,borderWidth/2.0, diameter + borderWidth, diameter + borderWidth)];
    // 设置颜色
    [fillColor set];
    [centerPath fill];
    // 从上下文中获取图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return resultImage;
}

@end

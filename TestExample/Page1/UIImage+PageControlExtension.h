//
//  UIImage+Extension.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
/*
 *  水印方向
 */
typedef enum {
    
    //左上
    PCImageWaterDirectTopLeft=0,
    
    //右上
    PCImageWaterDirectTopRight,
    
    //左下
    PCImageWaterDirectBottomLeft,
    
    //右下
    PCImageWaterDirectBottomRight,
    
    //正中
    PCImageWaterDirectCenter
    
}PCImageWaterDirect;


@interface UIImage (PCExtension)

#pragma mark -- 读取图片
+(UIImage *)pc_imageNamed:(NSString *)IMGName InBundleNamed:(NSString *)BundleName;
+ (UIImage *)pc_imageWithName:(NSString *)imageName withRenderingMode:(UIImageRenderingMode)imageRenderingMode;

#pragma mark -- resize
-(UIImage*)pc_scaleToSize:(CGSize)size;
//聊天的文字气泡拉伸
+ (UIImage *)pc_resizedImage:(NSString *)name;
//调整图片大小
+ (UIImage *)pc_resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

//UIImage自定长宽缩放
+(UIImage *)pc_reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

//UIImage等比例缩放
+(UIImage *)pc_scaleImage:(UIImage *)image toScale:(CGFloat)scale;

#pragma mark restore image to befor
-(UIImage *)pc_restoreMyimage;

#pragma mark-- 裁剪圆形图片
/* 裁剪圆形图片 例如：头像 */
+ (UIImage *)pc_roundBezierImage:(UIImage *)image;
/**
 *  图片剪切为圆形
 *
 *  @return 剪切后的圆形图片
 */
- (UIImage *)pc_roundImage;
/**
 *  将image转换为圆型带边框的图片（最好写一个UIImage的类扩展）
 *
 *  @param name        图片的名字
 *  @param borderWidth 外层边框的宽度
 *  @param borderColor 外层边框的颜色
 *
 *  @return 返回已经处理好的圆形图片
 */
+ (UIImage *)pc_roundImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIImage *)pc_roundImageWithImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)pc_rectangleImageWithName:(NSString *)name borderWith:(CGFloat)borderWith borderColor:(UIColor *)borderColor;
+ (UIImage *)pc_rectangleImageWithImage:(UIImage *)oldImage size:(CGSize)size borderWith:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIImage *)pc_rectangleRoundCornerImageWithOldImage:(UIImage *)oldImage cornerRadiu:(CGFloat)cornerRadiu corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
- (CGSize)pc_sizeFromImage:(UIImage *)image;

#pragma mark -- color -> image
+ (UIImage*)pc_imageWithColor: (UIColor*) color;
- (UIImage *)pc_imageWithColorFitToScale:(UIColor *)color;
/**
 *  返回指定颜色生成的图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 */
+ (UIImage *)pc_imageWithColor:(UIColor *)color andSize:(CGSize)size;
/**
 *  获取指定尺寸（50*50）的图片
 *
 *  @param color 图片颜色
 *  @param name  文本,居中显示
 *
 *  @return img
 */
+ (UIImage *)pc_imageWithBGColor:(UIColor *)color text:(NSString *)name textColor:(UIColor *)textColor;
/**
 *  获取指定尺寸（size）的图片
 *
 *  @param color 图片颜色
 *  @param name  文本,居中显示
 *
 *  @return img
 */
+ (UIImage *)pc_imageWithBGColor:(UIColor *)color text:(NSString *)name textColor:(UIColor *)textColor andImageSize:(CGSize)imageSize;
/**
 *  获取指定尺寸（size）的图片
 *
 *  @param color 图片颜色
 *  @param name  文本,居中显示
 *  @param textfont  文本,字体大小
 *  @param imageSize 图片尺寸
 *  @return img
 */
+ (UIImage *)pc_imageWithBGColor:(UIColor *)color text:(NSString *)name textFont:(UIFont *)textfont textColor:(UIColor *)textColor andImageSize:(CGSize)imageSize;
//圆形的[用颜色生成]
+ (UIImage *)pc_imageRoundWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius;
//圆形带边框[用颜色生成]
+ (UIImage *)pc_imageRoundWithDiameter:(CGFloat)diameter fillColor:(UIColor *)fillColor borderWith:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end

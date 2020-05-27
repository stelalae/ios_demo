//
//  UIImage+Extension.m
//  doctor_app
//
//  Created by leiyinchun on 2019/5/23.
//  Copyright © 2019年 leiyinchun. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "UIImage+Extension.h"
#import "SVGKImage.h"

@implementation UIImage (Extension)

+(UIImage *)srentchImageWithIcon:(NSString *)icon{
  return [self srentchImageWithIcon:icon width:0.5 heigh:0.5];
}

+(UIImage *)srentchImageWithIcon:(NSString *)icon width:(float)with heigh:(float)heigh{
  UIImage *image=[UIImage imageNamed: icon];
  image=[image stretchableImageWithLeftCapWidth:image.size.width*with topCapHeight:image.size.height*heigh];
  return image;
}

/**
 通过IconFont的形式创建图片
 @param iconFontName iconFont的name
 @param fontSize 字体的大小
 @param text 文案
 @param color 颜色
 @return 创建的图片
 */
+ (UIImage *)svgImageNamed:(CGFloat)fontSize text:(NSString *)text color:(UIColor *)color
{
  CGFloat size = fontSize;
  CGFloat scale = [UIScreen mainScreen].scale;
  CGFloat realSize = size * scale;
  UIFont *font = FONTICON(realSize);
  UIGraphicsBeginImageContext(CGSizeMake(realSize, realSize));
  [text drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
  
  UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
  UIGraphicsEndImageContext();
  
  return image;
}

+(UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
  // 创建一个bitmap的context
  // 并把它设置成为当前正在使用的context
  UIGraphicsBeginImageContext(size);
  
  // 绘制改变大小的图片
  [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
  
  // 从当前context中创建一个改变大小后的图片
  UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  
  // 使当前的context出堆栈
  UIGraphicsEndImageContext();
  
  // 返回新的改变大小后的图片
  return scaledImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
  CGFloat imageW = 100;
  CGFloat imageH = 100;
  // 1.开启基于位图的图形上下文
  UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
  
  // 2.画一个color颜色的矩形框
  [color set];
  UIRectFill(CGRectMake(0, 0, imageW, imageH));
  
  // 3.拿到图片
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  
  // 4.关闭上下文
  UIGraphicsEndImageContext();
  
  return image;
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
  CGRect rect = (CGRect){0.f, 0.f, self.size};
  
  UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
  CGContextAddPath(UIGraphicsGetCurrentContext(),
                   [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
  CGContextClip(UIGraphicsGetCurrentContext());
  
  [self drawInRect:rect];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  
  return image;
}

+(UIImage *)getImageFromURL:(NSString *)fileURL
{
  NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString: fileURL]];
  UIImage *result = [UIImage imageWithData:data];
  
  return result;
}

- (UIImage *)normalizedImage {
  if (self.imageOrientation == UIImageOrientationUp) return self;
  
  UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
  [self drawInRect:(CGRect){0, 0, self.size}];
  UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return normalizedImage;
}

- (UIImage *)fixOrientation {
  
  // No-op if the orientation is already correct
  if (self.imageOrientation == UIImageOrientationUp) return self;
  
  // We need to calculate the proper transformation to make the image upright.
  // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
  CGAffineTransform transform = CGAffineTransformIdentity;
  
  switch (self.imageOrientation) {
    case UIImageOrientationDown:
    case UIImageOrientationDownMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
      transform = CGAffineTransformRotate(transform, M_PI);
      break;
      
    case UIImageOrientationLeft:
    case UIImageOrientationLeftMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.width, 0);
      transform = CGAffineTransformRotate(transform, M_PI_2);
      break;
      
    case UIImageOrientationRight:
    case UIImageOrientationRightMirrored:
      transform = CGAffineTransformTranslate(transform, 0, self.size.height);
      transform = CGAffineTransformRotate(transform, -M_PI_2);
      break;
    case UIImageOrientationUp:
    case UIImageOrientationUpMirrored:
      break;
  }
  
  switch (self.imageOrientation) {
    case UIImageOrientationUpMirrored:
    case UIImageOrientationDownMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.width, 0);
      transform = CGAffineTransformScale(transform, -1, 1);
      break;
      
    case UIImageOrientationLeftMirrored:
    case UIImageOrientationRightMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.height, 0);
      transform = CGAffineTransformScale(transform, -1, 1);
      break;
    case UIImageOrientationUp:
    case UIImageOrientationDown:
    case UIImageOrientationLeft:
    case UIImageOrientationRight:
      break;
  }
  
  // Now we draw the underlying CGImage into a new context, applying the transform
  // calculated above.
  CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                           CGImageGetBitsPerComponent(self.CGImage), 0,
                                           CGImageGetColorSpace(self.CGImage),
                                           CGImageGetBitmapInfo(self.CGImage));
  CGContextConcatCTM(ctx, transform);
  switch (self.imageOrientation) {
    case UIImageOrientationLeft:
    case UIImageOrientationLeftMirrored:
    case UIImageOrientationRight:
    case UIImageOrientationRightMirrored:
      // Grr...
      CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
      break;
      
    default:
      CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
      break;
  }
  
  // And now we just create a new UIImage from the drawing context
  CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
  UIImage *img = [UIImage imageWithCGImage:cgimg];
  CGContextRelease(ctx);
  CGImageRelease(cgimg);
  return img;
}

@end

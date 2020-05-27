//
//  UIImage+Extension.h
//  doctor_app
//
//  Created by leiyinchun on 2019/5/23.
//  Copyright © 2019年 leiyinchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

//拉伸图片
+(UIImage *)srentchImageWithIcon:(NSString *)icon;
+(UIImage *)srentchImageWithIcon:(NSString *)icon width:(float) with heigh:(float)heigh;

+ (UIImage *)svgImageNamed:(CGFloat)fontSize text:(NSString *)text color:(UIColor *)color;


//缩放图片
+(UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

//自制一个颜色图片
+(UIImage *)imageWithColor:(UIColor *)color;

//自设图片圆角
-(UIImage *)imageWithCornerRadius:(CGFloat)radius;

//加载网络图片
+(UIImage *)getImageFromURL:(NSString *)fileURL;

//摆正图片
-(UIImage *)normalizedImage;
-(UIImage *)fixOrientation;
@end

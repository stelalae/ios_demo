//
//  UIImage+WLCompress.h
//  doctor_app
//
//  Created by leiyinchun on 2019/7/16.
//  Copyright © 2019 leiyinchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WLCompress)
/*
 *  压缩图片方法(先压缩质量再压缩尺寸)
 */
-(NSData *)compressWithLengthLimit:(NSUInteger)maxLength;
/*
 *  压缩图片方法(压缩质量)
 */
-(NSData *)compressQualityWithLengthLimit:(NSInteger)maxLength;
/*
 *  压缩图片方法(压缩质量二分法)
 */
-(NSData *)compressMidQualityWithLengthLimit:(NSInteger)maxLength;
/*
 *  压缩图片方法(压缩尺寸)
 */
-(NSData *)compressBySizeWithLengthLimit:(NSUInteger)maxLength;

@end

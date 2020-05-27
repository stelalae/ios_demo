//
//  UILabel+Extension.h
//  doctor_app
//
//  Created by LeiYinchun on 2019/6/4.
//  Copyright © 2019 leiyinchun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)

// 初始化方法(详情)
+ (UILabel *)labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(nullable UIColor *)backgroundColor textAlignment:(NSTextAlignment)textAlignment contentText:(NSString *)contentText numberofline:(NSInteger)numberofline;

// 初始化方法(简化)
+ (UILabel *)labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor contentText:(nullable NSString *)contentText;

// 获取文字高度
-(CGFloat )labelHeight;

// 获取文字宽度
-(CGFloat )labelWidth;

// 设置行距
- (void)setLineSpace:(CGFloat)lineSpace;

// 设置富文本行距
- (void)setAttributedLineSpace:(CGFloat)lineSpace;

/**
 添加html文本，并设置行距
 - parameter htmlStr: html 文本
 - parameter lineSpace: 行距
 */
- (void)setHtmlTextAndLineSpace:(NSString*)htmlStr fontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END

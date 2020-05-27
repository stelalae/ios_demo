//
//  UIView+Extension.h
//  doctor_app
//
//  Created by leiyinchun on 2019/5/23.
//  Copyright © 2019年 leiyinchun. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE  // 动态刷新

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

// 注意: 加上IBInspectable就可以可视化显示相关的属性
// 可视化设置边框宽度
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
// 可视化设置边框颜色
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
// 可视化设置圆角
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

// 切圆及边框
- (void)setRadius:(float)radius borderColor:(UIColor* )color borderWidth:(CGFloat)width;

// 初始化方法
+(UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;
@end

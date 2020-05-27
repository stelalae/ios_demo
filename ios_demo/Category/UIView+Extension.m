//
//  UIView+Extension.m
//  doctor_app
//
//  Created by leiyinchun on 2019/5/23.
//  Copyright © 2019年 leiyinchun. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
  CGRect frame = self.frame;
  frame.origin.x = x;
  self.frame = frame;
}

- (CGFloat)x
{
  return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
  CGRect frame = self.frame;
  frame.origin.y = y;
  self.frame = frame;
}

- (CGFloat)y
{
  return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
  CGPoint center = self.center;
  center.x = centerX;
  self.center = center;
}

- (CGFloat)centerX
{
  return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
  CGPoint center = self.center;
  center.y = centerY;
  self.center = center;
}

- (CGFloat)centerY
{
  return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
  CGRect frame = self.frame;
  frame.size.width = width;
  self.frame = frame;
}

- (CGFloat)width
{
  return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}

- (CGFloat)height
{
  return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
  CGRect frame = self.frame;
  frame.size = size;
  self.frame = frame;
}

- (CGSize)size
{
  return self.frame.size;
}

- (void)setRadius:(float)radius borderColor:(UIColor* )color borderWidth:(CGFloat)width
{
  self.layer.cornerRadius = radius;
  self.layer.masksToBounds = YES;
  if (color) {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
  }
}

+(UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color
{
  UIView * view = [[UIView alloc] initWithFrame:frame];
  view.backgroundColor = color;
  return view;
}

#pragma mark - 边框宽度
- (void)setBorderWidth:(CGFloat)borderWidth
{
  if (borderWidth < 0)
    return;
  self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth
{
  return self.layer.borderWidth;
}


#pragma mark - 边框颜色
- (void)setBorderColor:(UIColor *)borderColor
{
  self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor
{
  return [UIColor colorWithCGColor:self.layer.borderColor];
}


#pragma mark - 圆角
- (void)setCornerRadius:(CGFloat)cornerRadius
{
  self.layer.cornerRadius = cornerRadius;
  self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)cornerRadius
{
  return self.layer.cornerRadius;
}


@end

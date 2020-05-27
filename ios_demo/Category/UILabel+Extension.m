//
//  UILabel+Extension.m
//  doctor_app
//
//  Created by LeiYinchun on 2019/6/4.
//  Copyright © 2019 leiyinchun. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (UILabel *)add:(UILabel *)label TapGesture:(nullable id)target action:(nullable SEL)action
{
  UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(action)];
  [label addGestureRecognizer:labelTapGestureRecognizer];
  label.userInteractionEnabled = YES;
  return label;
}


+ (UILabel *)labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(nullable UIColor *)backgroundColor textAlignment:(NSTextAlignment)textAlignment contentText:(NSString *)contentText numberofline:(NSInteger)numberofline
{
  UILabel * label = [UILabel new];
  if(!CGRectIsNull(frame)) {
    label.frame = frame;
  }
  if (font) {
    label.font = font;
  }
  if (textColor) {
    label.textColor = textColor;
  }
  if (backgroundColor) {
    label.backgroundColor = backgroundColor;
  }
  if (numberofline) {
    label.numberOfLines = numberofline;
  } else {
    label.numberOfLines = 1;
  }
  if (textAlignment) {
    label.textAlignment = textAlignment;
  } else {
    label.textAlignment = NSTextAlignmentLeft;
  }
  label.text = contentText;
  return label;
}

+ (UILabel *)labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor contentText:(nullable NSString *)contentText
{
  UILabel * label = [UILabel new];
  if(!CGRectIsNull(frame)) {
    label.frame = frame;
  }
  if (font) {
    label.font = font;
  }
  if (textColor) {
    label.textColor = textColor;
  }
  if (contentText) {
    label.text = contentText;
  }
  return label;
}

-(CGFloat)labelHeight{  
  return  [NSString sizeWith:CGSizeMake(self.width, MAXFLOAT) font:self.font text:self.text].height;
}

-(CGFloat)labelWidth{
  return  [NSString sizeWith:CGSizeMake(MAXFLOAT, self.height) font:self.font text:self.text].width;
}

/**
 设置行距
 - parameter lineSpace: 行距
 */
- (void)setLineSpace:(CGFloat)lineSpace{
  NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
  NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.lineSpacing = lineSpace;
  [attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, self.text.length)];
  self.attributedText = attributedString;
}

/**
 设置富文本行距
 - parameter lineSpace: 行距
 */
- (void)setAttributedLineSpace:(CGFloat)lineSpace{
  NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
  NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.lineSpacing = lineSpace;
  [attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, self.text.length)];
  self.attributedText = attributedString;
}

/**
 添加html文本，并设置行距
 - parameter htmlStr:   html 文本
 - parameter lineSpace: 行距
 */
- (void)setHtmlTextAndLineSpace:(NSString*)htmlStr fontSize:(CGFloat)fontSize{
  NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} documentAttributes:nil error:nil];
  self.attributedText = attributedString;
}


@end

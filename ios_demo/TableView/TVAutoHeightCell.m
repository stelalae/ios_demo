//
//  TVAutoHeightCell.m
//  ios_demo
//
//  Created by leiyinchun on 2020/5/26.
//  Copyright © 2020 leiyinchun. All rights reserved.
//

#import "TVAutoHeightCell.h"


@interface TVAutoHeightCell ()

@property (nonatomic) UIImageView *img;
@property (nonatomic) UILabel *title;
@property (nonatomic) UILabel *detail;
@property (nonatomic) UILabel *time;
@property (nonatomic) UIImageView *imgArrow;

@end

@implementation TVAutoHeightCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.contentView.backgroundColor = ColorWhite;
    [self makeUI];
  }
  return self;
}

- (void)makeUI {
  WS(self);
  _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_news"]];
  [self.contentView addSubview:_img];
  [_img makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakself.contentView.top).offset(19);
    make.left.equalTo(weakself.contentView.left).offset(12);
    make.width.height.equalTo(@36);
  }];
  
  _time = [UILabel labelWithFrame:CGRectZero font:FONT(11) textColor:HEXCOLOR(0xA8A8A8) backgroundColor:nil textAlignment:NSTextAlignmentRight contentText:@"" numberofline:1];
  [self.contentView addSubview:_time];
  [_time makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakself.contentView.top).offset(19);
    make.right.equalTo(weakself.contentView.mas_right).offset(-12.5);
    make.width.equalTo(@100);
  }];
  
  _title = [UILabel labelWithFrame:CGRectZero font:FONTBOLD(15) textColor:ColorGrayBlack backgroundColor:nil textAlignment:NSTextAlignmentLeft contentText:@"" numberofline:1];
  [self.contentView addSubview:_title];
  [_title makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakself.contentView.top).offset(19);
    make.left.equalTo(weakself.contentView.left).offset(60);
    make.right.equalTo(weakself.contentView.right).offset(-10-12.5-100);
  }];
  _title.font = FONT(13);
  
  _detail = [UILabel labelWithFrame:CGRectZero font:FONT(13) textColor:HEXCOLOR(0x9294A5) backgroundColor:nil textAlignment:NSTextAlignmentLeft contentText:@"" numberofline:1];
  _detail.numberOfLines = 0;
  
  [self.contentView addSubview:_detail];
  [_detail makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakself.title.left);
    make.top.equalTo(weakself.title.bottom).offset(9);
    make.right.equalTo(weakself.contentView.right).offset(-30);
    make.bottom.equalTo(weakself.contentView.bottom).offset(-20);
  }];

  _imgArrow = [[UIImageView alloc] initWithImage:[UIImage svgImageNamed:10 text:@"\U0000e62e" color:ColorAssistGray]];
  [self.contentView addSubview:_imgArrow];
  [_imgArrow makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakself.time.bottom).offset(15.5);
    make.right.equalTo(weakself.contentView.right).offset(-12.5);
    make.width.height.equalTo(@10);
  }];
}

- (void)setModel:(SystemMessage *)msg {
  if(msg == nil) {
    return;
  }
  _imgArrow.hidden = msg.url ? NO : YES;
  _title.text = msg.title;
  _detail.text = msg.chatContent;
  
  //设置行间距
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.lineSpacing = 5;
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_detail.text];
  [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_detail.text length])];
  _detail.attributedText = attributedString;

  _time.text = [NSString distanceTimeWithBeforeTime:msg.createTime];
}

@end

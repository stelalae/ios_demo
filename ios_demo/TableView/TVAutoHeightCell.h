//
//  TVAutoHeightCell.h
//  ios_demo
//
//  Created by leiyinchun on 2020/5/26.
//  Copyright © 2020 leiyinchun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define Identifier_SystemMsgCell @"Identifier_SystemMsgCell"

@interface TVAutoHeightCell : UITableViewCell

- (void)setModel:(SystemMessage *)msg;

@end

NS_ASSUME_NONNULL_END

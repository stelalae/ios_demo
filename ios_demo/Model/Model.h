//
//  Model.h
//  ios_demo
//
//  Created by leiyinchun on 2020/5/26.
//  Copyright © 2020 leiyinchun. All rights reserved.
//

#ifndef Model_h
#define Model_h

#define StringOpt @property(nonatomic,copy) NSString *
#define IntOpt @property(nonatomic,assign) NSInteger
#define LongOpt @property(nonatomic,assign) NSUInteger
#define FloatOpt @property(nonatomic,assign) CGFloat
#define BoolOpt @property(nonatomic,assign) BOOL

@interface TableCellModel : NSObject

FloatOpt _height; // 缓存高度

@end


//详细用户资料
@interface SystemMessage : TableCellModel

StringOpt chatContent;  // 消息内容
IntOpt createTime;  // 创建时间
StringOpt img;  // 图片
IntOpt msgType;  // 消息类型
IntOpt sysId;  // 系统消息ID
StringOpt title;  // 标题
StringOpt url;  // 跳转地址
StringOpt userNo;  // 用户编码
IntOpt whetherRead;  // 是否阅读0标识没有阅读1标识阅读

@end


#endif /* Model_h */

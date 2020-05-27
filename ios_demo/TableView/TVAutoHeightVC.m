//
//  TVAutoHeightVC.m
//  ios_demo
//
//  Created by leiyinchun on 2020/5/26.
//  Copyright © 2020 leiyinchun. All rights reserved.
//

#import "TVAutoHeightVC.h"
#import "TVAutoHeightCell.h"

@interface TVAutoHeightVC () <UITableViewDelegate, UITableViewDataSource>

@property UITableView* tv;
@property NSMutableArray* arrMsg;

@end

@implementation TVAutoHeightVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _arrMsg = [[NSMutableArray alloc] init];
  for (int i=0; i<30; i++) {
    SystemMessage *msg = [[SystemMessage alloc] init];
    msg.createTime = 1590023642000;
    msg.img = @"https://cdn.jsdelivr.net/gh/stelalae/oss@master/files/2020/05/27/wqVqXO.png";
    
    int len = (arc4random() % 11) + 10;
    NSMutableString *str = [[NSMutableString alloc] initWithString:@""];
    for (int j=0; j<len; j++) {
      [str appendString:[NSString stringWithFormat:@"测试x%d", j]];
    }
    msg.chatContent = str;
    msg.title = @"标题";
    msg._height = 0;
    
    [_arrMsg addObject:msg];
  }
  [self createTable];
}

-(void)createTable
{
  self.tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainw, mainh - NavigationStatusHeight) style:UITableViewStylePlain];
  self.tv.showsVerticalScrollIndicator = NO;
  self.tv.delegate = self;
  self.tv.dataSource = self;
  self.tv.backgroundColor = ColorBg;
  self.tv.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.tv registerClass:[TVAutoHeightCell class] forCellReuseIdentifier:Identifier_SystemMsgCell];
  
  // 高度自适应的关键
  self.tv.estimatedRowHeight = 200;
  self.tv.rowHeight = UITableViewAutomaticDimension;
  
  [self.view addSubview:self.tv];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _arrMsg.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//  SystemMessage *msg = _arrMsg[indexPath.row];
//  if (msg._height<1) {
//    return UITableViewAutomaticDimension;
//  }
//  return msg._height;
//}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
  NSLog(@"willDisplayingCell---%ld, height:%f", (long)indexPath.row, cell.height);
}

- (void)tableView:(UITableView*)tableView didEndDisplayingCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
  NSLog(@"didEndDisplayingCell---%ld, height:%f", (long)indexPath.row, cell.height);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  SystemMessage *msg = _arrMsg[indexPath.row];
  
  TVAutoHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_SystemMsgCell];
  if (cell == nil) {
     cell  = [[TVAutoHeightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier_SystemMsgCell];
  }
  [cell setModel:msg];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.accessoryType = UITableViewCellAccessoryNone;
//  CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//  msg._height = size.height + 1.0f;
//  NSLog(@"height %f", msg._height);
  return cell;
}

@end

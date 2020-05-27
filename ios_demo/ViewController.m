//
//  ViewController.m
//  ios_demo
//
//  Created by leiyinchun on 2020/5/11.
//  Copyright © 2020 leiyinchun. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "TVAutoHeightVC.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  self.view.backgroundColor = [UIColor yellowColor];
  
  UIButton *btnWebCacheFile = [[UIButton alloc] initWithFrame:CGRectMake(80, 100, 200, 40)];
  [btnWebCacheFile setTitle:@"网页离线缓存" forState:UIControlStateNormal];
  [btnWebCacheFile setBackgroundColor:[UIColor redColor]];
  [btnWebCacheFile addTarget:self action:@selector(btnWebCacheFile) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btnWebCacheFile];
  
  UIButton *btnTVAutoHeight = [[UIButton alloc] initWithFrame:CGRectMake(80, 150, 200, 40)];
  [btnTVAutoHeight setTitle:@"TableViewCell动态高度" forState:UIControlStateNormal];
  [btnTVAutoHeight setBackgroundColor:[UIColor redColor]];
  [btnTVAutoHeight addTarget:self action:@selector(btnTVAutoHeight) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btnTVAutoHeight];
}

- (void)btnWebCacheFile {
  WebViewController *vc = [[WebViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnTVAutoHeight {
  TVAutoHeightVC *vc = [[TVAutoHeightVC alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}


@end

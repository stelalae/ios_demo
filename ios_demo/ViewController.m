//
//  ViewController.m
//  ios_demo
//
//  Created by leiyinchun on 2020/5/11.
//  Copyright © 2020 lyc. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  self.view.backgroundColor = [UIColor yellowColor];
  
  UIButton *btnWebCacheFile = [[UIButton alloc] initWithFrame:CGRectMake(80, 200, 150, 40)];
  [btnWebCacheFile setTitle:@"WebCacheFile" forState:UIControlStateNormal];
  [btnWebCacheFile setBackgroundColor:[UIColor redColor]];
  [btnWebCacheFile addTarget:self action:@selector(btnWebCacheFile) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btnWebCacheFile];
}


- (void)btnWebCacheFile {
  WebViewController *vc = [[WebViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
  
}


@end

//
//  ViewController.m
//  ios_demo
//
//  Created by leiyinchun on 2020/5/11.
//  Copyright © 2020 lyc. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "ViewController.h"

#define mainw [UIScreen mainScreen].bounds.size.width
#define mainh [UIScreen mainScreen].bounds.size.height

@interface ViewController () <WKNavigationDelegate, WKUIDelegate>


@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  [WebCacheFile initRegister:@[@"http", @"https"]];
  
  [WebCacheFile setInterceptResourceTypes:@[@"js", @"css", @"png", @"jpg", @"gif"]];
  
  _urlStr = @"https://www.163.com";
  [self addWKWebView];
}

- (void)dealloc {
  [WebCacheFile unregister];
}

- (void)addWKWebView
{
  WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
  config.selectionGranularity = WKSelectionGranularityDynamic;
  
  config.preferences = [[WKPreferences alloc] init];
  config.preferences.minimumFontSize = 10;
  config.preferences.javaScriptEnabled = YES;
  config.processPool = [[WKProcessPool alloc] init];
  config.userContentController = [[WKUserContentController alloc] init];
  
  WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, mainw, mainh) configuration:config];
  wkWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  wkWebView.UIDelegate = self;
  wkWebView.navigationDelegate = self;
  
  NSURL *url = [NSURL URLWithString:_urlStr];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20];
  
  [wkWebView loadRequest:request];
  [self.view addSubview:wkWebView];
  _wkWebView = wkWebView;
  
  __weak __typeof(&*self) weakself = self;
  dispatch_async(dispatch_get_main_queue(), ^{
    [weakself.wkWebView evaluateJavaScript:@"window.appVersion='8.8.8'" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
      NSLog(@"evaluateJavaScript error: %@", error.description);
    }];
  });
}


@end

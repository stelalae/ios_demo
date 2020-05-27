//
//  AppDelegate.m
//  ios_demo
//
//  Created by leiyinchun on 2020/5/11.
//  Copyright © 2020 leiyinchun. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.window setBackgroundColor:[UIColor whiteColor]];
  [self.window makeKeyAndVisible];
  
  ViewController *vc = [[ViewController alloc] init];
  RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:vc];
  [self.window setRootViewController:nav];
  return YES;
}


@end

//
//  Macro.h
//  ios_demo
//
//  Created by leiyinchun on 2020/5/26.
//  Copyright © 2020 leiyinchun. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#pragma mark - 基础

#define WSO(Object) __weak __typeof(&*self) weak##Object = Object
#define WS(self)  WSO(self)

#define sVi self.view
#define wsVi weakself.view

#pragma mark - 尺寸

#define mainw [UIScreen mainScreen].bounds.size.width
#define mainh [UIScreen mainScreen].bounds.size.height

//状态栏高度
#define StatusHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define StatusHeightCustom ([[UIApplication sharedApplication] statusBarFrame].size.height - 3)

//导航栏高度
#define NavigationHeight (self.navigationController.navigationBar.frame.size.height)

//导航栏+状态栏
#define NavigationStatusHeight (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)

//iPhone x 的tabbar高度和底栏高度(通过状态栏高度来判断)
#define TabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49) //tabbar高度
#define TabbarBottomHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 34 : 0) //底栏高度

#pragma mark - 颜色

#define HEXCOLORAlpha(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]

#define HEXCOLOR(rgbValue) HEXCOLORAlpha(rgbValue, 1.0)

#define ColorWhite [UIColor whiteColor]
#define ColorRed [UIColor redColor]
#define ColorBlack [UIColor blackColor]

#define ColorBg HEXCOLOR(0xfbfbfb)
#define ColorGrayBlack HEXCOLOR(0x333333)
#define ColorAssistGray HEXCOLOR(0x9294a5)
#define ColorCyan HEXCOLOR(0x00bbd6)
#define ColorTheme ColorCyan


#pragma mark - 字体

#define FONT(size) [UIFont systemFontOfSize:size]
#define FONTBOLD(size) [UIFont boldSystemFontOfSize:size]
#define FONTICON(sizeA) [UIFont fontWithName:@"iconFont" size:sizeA]

#endif /* Macro_h */

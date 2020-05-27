//
//  NSString+Extension.m
//  IntercontinentalHealth
//
//  Created by zsj on 2018/5/11.
//  Copyright © 2018年 ITpower. All rights reserved.
//

#import "NSString+Extension.h"
#import <CoreText/CoreText.h>
#import <sys/utsname.h>

@implementation NSString (Extension)

+(NSArray *)getLinesArrayOfStringInLabel:(NSString *)text font:(UIFont *)font rect:(CGRect)rect{
  CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
  NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
  [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
  CFRelease(myFont);
  CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
  CGMutablePathRef path = CGPathCreateMutable();
  CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
  CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
  NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
  NSMutableArray *linesArray = [[NSMutableArray alloc]init];
  for (id line in lines) {
    CTLineRef lineRef = (__bridge  CTLineRef )line;
    CFRange lineRange = CTLineGetStringRange(lineRef);
    NSRange range = NSMakeRange(lineRange.location, lineRange.length);
    NSString *lineString = [text substringWithRange:range];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
    //NSLog(@"''''''''''''''''''%@",lineString);
    [linesArray addObject:lineString];
  }
  
  CGPathRelease(path);
  CFRelease( frame );
  CFRelease(frameSetter);
  return (NSArray *)linesArray;
}

+ (NSString *)dynamicImgUrl:(NSString *)url {
  if(url == nil) {
    return url;
  }
  if(![url hasPrefix:@"http"]) { // 是否以http开头
    NSString *urlNew = [NSString stringWithFormat:@"https:%@", url];
    return urlNew;
  }
  return url;
}

- (BOOL)match:(NSString *)pattern
{
  // 1.创建正则表达式
  NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
  // 2.测试字符串
  NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
  
  return results.count > 0;
}

- (BOOL)isQQ
{
  // 1.不能以0开头
  // 2.全部是数字
  // 3.5-11位
  return [self match:@"^[1-9]\\d{4,10}$"];
}

- (BOOL)isPhoneNumber{
  // 1.全部是数字
  // 2.11位
  // 3.以13\15\18\17开头
  return [self match:@"^1[3578]\\d{9}$"];
}

- (BOOL)isIPAddress{
  // 1-3个数字: 0-255
  // 1-3个数字.1-3个数字.1-3个数字.1-3个数字
  return [self match:@"^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$"];
}

- (BOOL)isIdcard{
  return [self match:@"[1-9]\\d{5}[1-2]\\d{3}((0[1-9])|(1[0-2]))((0[1-9])|([1-2][0-9])|(3[0-1]))[0-9]{3}[0-9xX]$"];
}

-(BOOL)isChinese{
  return [self match:@"(^[\u4e00-\u9fa5]+$)"];
}

- (BOOL)isEnglishChinese{
  return [self match:@"[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*"];
}

-(BOOL)iSNumber{
  return [self match:@"[0-9]+$"];
}

-(BOOL)iSNumber_English{
  return [self match:@"[a-zA-Z0-9]+$"];
}

-(BOOL)isNull{
  if (self == nil || self == NULL) {
    return YES;
  }
  if ([self isKindOfClass:[NSNull class]]) {
    return YES;
  }
  if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
    return YES;
  }
  return NO;
}

-(BOOL)isPriceNumberTwo{
  return [self match:@"^[0-9]+([.]{1}[0-9]+){0,1}$"];
}

-(BOOL)isEmal{
  return [self match:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

-(BOOL)isNotEmoji{
  return ![self stringContainsEmoji:self];
}

- (BOOL)stringContainsEmoji:(NSString *)string
{
  __block BOOL returnValue = NO;
  [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                            const unichar hs = [substring characterAtIndex:0];
                            // surrogate pair
                            if (0xd800 <= hs && hs <= 0xdbff)
                            {
                              if (substring.length > 1)
                              {
                                const unichar ls = [substring characterAtIndex:1];
                                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                if (0x1d000 <= uc && uc <= 0x1f918)
                                {
                                  returnValue = YES;
                                }
                              }
                            }
                            else if (substring.length > 1)
                            {
                              const unichar ls = [substring characterAtIndex:1];
                              if (ls == 0x20e3 || ls == 0xFE0F || ls == 0xd83c)
                              {
                                returnValue = YES;
                              }
                            }
                            else
                            {
                              // non surrogate
                              if (0x2100 <= hs && hs <= 0x27ff)
                              {
                                returnValue = YES;
                              }
                              else if (0x2B05 <= hs && hs <= 0x2b07)
                              {
                                returnValue = YES;
                              }
                              else if (0x2934 <= hs && hs <= 0x2935)
                              {
                                returnValue = YES;
                              }
                              else if (0x3297 <= hs && hs <= 0x3299)
                              {
                                returnValue = YES;
                              }
                              else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
                              {
                                returnValue = YES;
                              }
                            }
                          }];
  return returnValue;
}

- (BOOL)isHaveCharacters{
  //    NSString * nameCharacters =@"[ \\~\\!\\/\\@\\#\\$\\%\\^\\&#\\$\\%\\^\\&amp;\\*\\(\\)\\-\\_\\=\\+\\\\\\|\\[\\{\\}\\]\\;\\:\\\'\\\"\\,\\&#\\$\\%\\^\\&amp;\\*\\(\\)\\-\\_\\=\\+\\\\\\|\\[\\{\\}\\]\\;\\:\\\'\\\"\\,\\&lt;\\.\\&#\\$\\%\\^\\&amp;\\*\\(\\)\\-\\_\\=\\+\\\\\\|\\[\\{\\}\\]\\;\\:\\\'\\\"\\,\\&lt;\\.\\&gt;\\/\\?]";
  
  //    NSPredicate * isSpecialCharacter = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",nameCharacters];
  
  NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
  NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
  if (![emailTest evaluateWithObject:self]) {
    return YES;
  }
  
  return NO;
}

- (BOOL)isHaveNum{
  BOOL res = YES;
  NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
  int i = 0;
  while (i < self.length) {
    NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
    NSRange range = [string rangeOfCharacterFromSet:tmpSet];
    if (range.length == 0) {
      res = NO;
    }else{
      res = YES;
      break;
    }
    i++;
  }
  return res;
}


+(CGSize)sizeWith:(CGSize)size font:(UIFont *)font text:(NSString *)text{
  return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

+ (NSString *)uuid
{
  CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
  CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
  NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
  CFRelease(uuid_ref);
  CFRelease(uuid_string_ref);
//  return [uuid lowercaseString];
  
  // 去除“-”
  NSMutableString *ret = [NSMutableString stringWithString:[uuid lowercaseString]];
  NSRange range = [ret rangeOfString:@"-"];
  while (range.location != NSNotFound) {
    [ret deleteCharactersInRange:range];
    range = [ret rangeOfString:@"-"];
  }
  return ret;
}

+ (NSDictionary *)getUrlParameterWithUrl:(NSURL *)url {
  NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
  //传入url创建url组件类
  NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
  //回调遍历所有参数，添加入字典
  [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [parm setObject:obj.value forKey:obj.name];
  }];
  return parm;
}


+(NSString *)getCurrentTime{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
  return [formatter stringFromDate:[NSDate date]];
}


+ (NSString *)conversionDateTime:(NSTimeInterval)interval Format:(NSString *)format
{
  NSDate *date= [NSDate dateWithTimeIntervalSince1970:interval];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:format];
  return [formatter stringFromDate: date];
}

+(NSString *)getDateTimeByFormat:(NSString *)format{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:format];
  return [formatter stringFromDate:[NSDate date]];
}

// 时间戳转换为时间
+(NSString *)conversionTime:(NSString *)str
{
  // iOS 生成的时间戳是10位
  NSTimeInterval interval;
  if (str.length>10) {
    interval =[str doubleValue] / 1000.0;
  }else{
    interval = [str doubleValue];
  }
  NSDate *date= [NSDate dateWithTimeIntervalSince1970:interval];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  return [formatter stringFromDate: date];
}

+ (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
  beTime = beTime / 1000;
  NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
  double distanceTime = now - beTime;
  NSString * distanceStr;
  
  NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
  NSDateFormatter * df = [[NSDateFormatter alloc]init];
  [df setDateFormat:@"HH:mm"];
  NSString * timeStr = [df stringFromDate:beDate];
  
  [df setDateFormat:@"dd"];
  NSString * nowDay = [df stringFromDate:[NSDate date]];
  NSString * lastDay = [df stringFromDate:beDate];
  
  if(distanceTime < 24*60*60 && [nowDay integerValue] == [lastDay integerValue]) { // 时间小于一天
    distanceStr = [NSString stringWithFormat:@"%@", timeStr];
  } else if(distanceTime < 24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]) {
    if ([nowDay integerValue] - [lastDay integerValue] ==1
        || ([lastDay integerValue] - [nowDay integerValue] > 10
            && [nowDay integerValue] == 1)
        ) {
      distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
    }
    else {
      [df setDateFormat:@"MM-dd HH:mm"];
      distanceStr = [df stringFromDate:beDate];
    }
  } else if(distanceTime < 24*60*60*2){
    [df setDateFormat:@"MM-dd HH:mm"];
    distanceStr = [df stringFromDate:beDate];
  } else {
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    distanceStr = [df stringFromDate:beDate];
  }
  return distanceStr;
}


/**
 获取手机手机代码
 
 @return 手机代码
 */
+ (NSString *)getIphoneCode
{
  
  //需要导入头文件：#import <sys/utsname.h>
  
  struct utsname systemInfo;
  
  uname(&systemInfo);
  
  NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
  return platform;
}

/**
 获取手机型号
 
 @return 型号
 */
+ (NSString *)getIphoneType
{
  
  //需要导入头文件：#import <sys/utsname.h>
  
  struct utsname systemInfo;
  
  uname(&systemInfo);
  
  NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
  
  if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
  
  if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
  
  if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
  
  if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
  
  if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
  
  if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
  
  if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
  
  if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
  
  if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
  
  if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
  
  if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
  
  if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
  
  if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
  
  if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
  
  if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
  
  if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
  
  if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
  
  if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
  
  if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
  
  if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone 7";
  
  if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
  
  if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone 7 Plus";
  
  if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
  
  if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
  
  if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
  
  if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
  
  if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
  
  if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
  
  if([platform isEqualToString:@"iPhone11,8"]) return@"iPhone XR";
  
  if([platform isEqualToString:@"iPhone11,2"]) return@"iPhone XS";
  
  if([platform isEqualToString:@"iPhone11,6"]) return@"iPhone XS Max";
  
  if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
  
  if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
  
  if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
  
  if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
  
  if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
  
  if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
  
  if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
  
  if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
  
  if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
  
  if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
  
  if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
  
  if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
  
  if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
  
  if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
  
  if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
  
  if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
  
  if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
  
  if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
  
  if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
  
  if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
  
  if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
  
  if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
  
  if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
  
  if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
  
  if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
  
  if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
  
  if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
  
  if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
  
  if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
  
  if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
  
  if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
  
  if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
  
  if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
  
  if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
  
  if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
  
  if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
  
  if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
  
  if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
  
  return platform;
  
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
  NSError *parseError = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
  return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
  if (jsonString == nil) {
    return nil;
  }
  
  NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSError *err;
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
  
  if(err) {
    NSLog(@"json解析失败：%@",err);
    return nil;
  }
  return dic;
}

//根据id变量类型转化为对应string以供存储
+ (NSString *)setIDVariableToString:(id)varialeValue
{
  //NSString类型
  if ([varialeValue isKindOfClass:[NSString class]]) {
    return varialeValue?[NSString stringWithFormat:@"%@:NSString",varialeValue]:@"";
  }
  //BOOL类型
  else if ([[NSString stringWithFormat:@"%@",[varialeValue class]] isEqualToString:@"__NSCFBoolean"]) {
    return varialeValue?[NSString stringWithFormat:@"%@:NSNumberBOOL",varialeValue]:@"";
  }
  //NSSNumber类型
  else if ([varialeValue isKindOfClass:[NSNumber class]]) {
    
    NSString *memberValueType = @":NSNumber";
    
    if (strcmp([varialeValue objCType], @encode(char)) == 0 ||
        strcmp([varialeValue objCType], @encode(unsigned char)) == 0) {
      memberValueType = @":NSNumberChar";
    } else if (strcmp([varialeValue objCType], @encode(short)) == 0 ||
               strcmp([varialeValue objCType], @encode(unsigned short)) == 0) {
      memberValueType = @":NSNumberShort";
    } else if (strcmp([varialeValue objCType], @encode(int)) == 0 ||
               strcmp([varialeValue objCType], @encode(unsigned int)) == 0) {
      memberValueType = @":NSNumberInt";
    } else if (strcmp([varialeValue objCType], @encode(long)) == 0 ||
               strcmp([varialeValue objCType], @encode(unsigned long)) == 0) {
      memberValueType = @":NSNumberLong";
    } else if (strcmp([varialeValue objCType], @encode(long long)) == 0 ||
               strcmp([varialeValue objCType], @encode(unsigned long long)) == 0) {
      memberValueType = @":NSNumberLongLong";
    } else if (strcmp([varialeValue objCType], @encode(float)) == 0) {
      memberValueType = @":NSNumberFloat";
    } else if (strcmp([varialeValue objCType], @encode(double)) == 0) {
      memberValueType = @":NSNumberDouble";
    } else if (strcmp([varialeValue objCType], @encode(NSInteger)) == 0) {
      memberValueType = @":NSNumberNSInteger";
    } else if (strcmp([varialeValue objCType], @encode(NSUInteger)) == 0) {
      memberValueType = @":NSNumberNSUInteger";
    }
    
    return varialeValue?[NSString stringWithFormat:@"%@%@",varialeValue,memberValueType]:@"";
  }
  //UIView类型
  else if ([[varialeValue class] isSubclassOfClass:[UIView class]] || [[varialeValue class] isKindOfClass:[UIView class]]) {
    return varialeValue?[NSString stringWithFormat:@"%@:UIView",varialeValue]:@"";
  }
  
  return varialeValue?[NSString stringWithFormat:@"%@:id",varialeValue]:@"";
}

//根据存储的信息转为对应的变量类型
+ (id)getIDVariableValueTypesWithString:(NSString *)string
{
  NSString *idValueType = [[string componentsSeparatedByString:@":"] lastObject];
  NSString *idValue = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@":%@",idValueType] withString:@""];
  
  if ([idValueType isEqualToString:@"NSNumber"]) {
    return [NSNumber numberWithInteger:[idValue integerValue]];
  } else if ([idValueType isEqualToString:@"NSNumberChar"]) {
    return [NSNumber numberWithChar:[idValue intValue]];
  } else if ([idValueType isEqualToString:@"NSNumberFloat"]) {
    return [NSNumber numberWithFloat:[idValue floatValue]];
  } else if ([idValueType isEqualToString:@"NSNumberDouble"]) {
    return [NSNumber numberWithDouble:[idValue doubleValue]];
  } else if ([idValueType isEqualToString:@"NSNumberShort"]) {
    return [NSNumber numberWithShort:[idValue intValue]];
  } else if ([idValueType isEqualToString:@"NSNumberInt"]) {
    return [NSNumber numberWithInt:[idValue doubleValue]];
  } else if ([idValueType isEqualToString:@"NSNumberLong"]) {
    return [NSNumber numberWithLong:[idValue floatValue]];
  } else if ([idValueType isEqualToString:@"NSNumberLongLong"]) {
    return [NSNumber numberWithLongLong:[idValue longLongValue]];
  } else if ([idValueType isEqualToString:@"NSNumberNSInteger"]) {
    return [NSNumber numberWithInteger:[idValue integerValue]];
  } else if ([idValueType isEqualToString:@"NSNumberNSUInteger"]) {
    return [NSNumber numberWithUnsignedInteger:[idValue integerValue]];
  } else if ([idValueType isEqualToString:@"NSNumberBOOL"]) {
    return [NSNumber numberWithBool:[idValue boolValue]];
  } else if ([idValueType isEqualToString:@"UIView"]) {
    return NSClassFromString(idValue);
  } else if ([idValueType isEqualToString:@"NSString"]) {
    return idValue;
  }
  return @"";
}



// 根据身份证号获取年龄
+ (NSString *)getIdentityCardAge:(NSString *)numberStr{
  NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
  [formatterTow setDateFormat:@"yyyy-MM-dd"];
  NSDate *bsyDate = [formatterTow dateFromString:[NSString birthdayStrFromIdentityCard:numberStr]];
  NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
  int age = trunc(dateDiff/(60*60*24))/365;
  
  return [NSString stringWithFormat:@"%d",-age];
}

// 根据身份证获取生日
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr{
  NSMutableString *result = [NSMutableString stringWithCapacity:0];
  NSString *year = nil;
  NSString *month = nil;
  BOOL isAllNumber = YES;
  NSString *day = nil;
  if([numberStr length]<14)
    return result;
  
  if ([numberStr length]==18) {
    //**从第6位开始 截取8个数
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(6, 8)];
    //**检测前12位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
      if(!(*p>='0'&&*p<='9'))
        isAllNumber = NO;
      p++;
    }
    if(!isAllNumber)
      return result;
    year = [NSString stringWithFormat:@"19%@",[numberStr substringWithRange:NSMakeRange(8, 2)]];
    //    NSLog(@"year ==%@",year);
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    //    NSLog(@"month ==%@",month);
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    //    NSLog(@"day==%@",day);
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    //    NSLog(@"result===%@",result);
    return result;
  }else{
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 11)];
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
      if(!(*p>='0'&&*p<='9'))
        isAllNumber = NO;
      p++;
    }
    if(!isAllNumber)
      return result;
    
    year = [numberStr substringWithRange:NSMakeRange(6, 2)];
    month = [numberStr substringWithRange:NSMakeRange(8, 2)];
    day = [numberStr substringWithRange:NSMakeRange(10,2)];
    NSString* resultAll = [NSString stringWithFormat:@"19%@-%@-%@",year,month,day];
    return resultAll;
  }
  
}


// 从身份证上获取性别
+ (NSString *)getIdentityCardSex:(NSString *)numberStr{
  NSString *sex = @"";
  //获取18位 二代身份证  性别
  if (numberStr.length==18)
  {
    int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
    if(sexInt%2!=0)
    {
      NSLog(@"1");
      sex = @"男";
    }
    else
    {
      NSLog(@"2");
      sex = @"女";
    }
  }
  //  获取15位 一代身份证  性别
  if (numberStr.length==15)
  {
    int sexInt=[[numberStr substringWithRange:NSMakeRange(14,1)] intValue];
    if(sexInt%2!=0)
    {
      NSLog(@"1");
      sex = @"男";
    }else{
      NSLog(@"2");
      sex = @"女";
    }
  }
  return sex;
}


// 获取证件类型数组
+ (NSArray *)getCredNameArray{
  return @[@"身份证",@"军官证",@"其他",@"解放军文职干部证",@"警官证",@"解放军士兵证",@"户口薄",@"港澳回乡证通行证",@"台湾通行证",@"外国护照",@"中国护照",@"武警文职干部证",@"武警士兵证",@"全国组织机构代码",@"出生证",@"未知证件"];
}

// 获取证件类型id数组
+ (NSArray *)getCredIDArray{
  return @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"99"];
}

// 传入证件类型id返回证件名称
+ (NSString *)getCredNameStr:(NSString *)credType{
  if (credType.length<1) {
    return nil;
  }
  NSArray *IDCardArray = [[NSArray alloc]initWithArray:[NSString getCredIDArray]];
  NSArray *IDNameArray = [[NSArray alloc]initWithArray:[NSString getCredNameArray]];
  NSInteger typeInd = [IDCardArray indexOfObject:credType];
  return IDNameArray[typeInd];
}

// 传入证件名称返回证件类型id
+ (NSString *)getCredIDNum:(NSString *)credNameStr{
  if (credNameStr.length<1) {
    return nil;
  }
  NSArray *IDCardArray = [[NSArray alloc]initWithArray:[NSString getCredIDArray]];
  NSArray *IDNameArray = [[NSArray alloc]initWithArray:[NSString getCredNameArray]];
  NSInteger typeInd = [IDNameArray indexOfObject:credNameStr];
  return IDCardArray[typeInd];
}




// 获取职业类型数组
+ (NSArray *)getProfessionalIDArray{
  return @[@"11",@"13",@"17",@"21",@"24",@"27",@"31",@"37",@"51",@"54",@"70",@"80",@"90"];
}

// 获取职业类型数组
+ (NSArray *)getProfessionalNameArray{
  return @[@"国家公务员",@"专业技术人员",@"职员",@"企业管理人员",@"工人",@"农民",@"学生",@"现役军人",@"自由职业",@"个体经营者",@"无业人员",@"退(离)休人员",@"其他"];
}

// 传入职业类型id返回职业名称
+ (NSString *)getProfessionalNameStr:(NSString *)ProfessionalType{
  if (ProfessionalType.length<1) {
    return nil;
  }
  NSArray *zyNameArray = [[NSArray alloc]initWithArray:[NSString getProfessionalNameArray]];
  NSArray *zyIDArray = [[NSArray alloc]initWithArray:[NSString getProfessionalIDArray]];
  NSInteger typeInd = [zyIDArray indexOfObject:ProfessionalType];
  return zyNameArray[typeInd];
}

// 传入职业名称返回职业类型id
+ (NSString *)getProfessionalredIDNum:(NSString *)ProfessionalStr{
  if (ProfessionalStr.length<1) {
    return nil;
  }
  NSArray *zyNameArray = [[NSArray alloc]initWithArray:[NSString getProfessionalNameArray]];
  NSArray *zyIDArray = [[NSArray alloc]initWithArray:[NSString getProfessionalIDArray]];
  NSInteger typeInd = [zyNameArray indexOfObject:ProfessionalStr];
  return zyIDArray[typeInd];
}

// 获取民族名称数组
+ (NSArray *)getNationalNameArray{
  return @[@"汉族",@"蒙古族",@"回族",@"藏族",@"维吾尔族",@"苗族",@"彝族",@"壮族",@"布依族",@"朝鲜族",@"满族",@"侗族",@"瑶族",@"白族",@"土家族",@"哈尼族",@"哈萨克族",@"傣族",@"黎族",@"傈僳族",@"佤族",@"畲族",@"高山族",@"拉祜族",@"水族",@"东乡族",@"纳西族",@"景颇族",@"柯尔克孜族",@"土族",@"达斡尔族",@"仫佬族",@"羌族",@"布朗族",@"撒拉族",@"毛南族",@"仡佬族",@"锡伯族",@"阿昌族",@"普米族",@"塔吉克族",@"怒族",@"乌孜别克族",@"俄罗斯族",@"鄂温克族",@"德昂族",@"保安族",@"裕固族",@"京族",@"塔塔尔族",@"独龙族",@"鄂伦春族",@"赫哲族",@"门巴族",@"珞巴族",@"基诺族",@"其他",@"外国血统"];
}
// 获取民族id数组
+ (NSArray *)getNationalIDArray{
  return @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58"];
}
// 传入民族id返回民族名称
+ (NSString *)getNationalNameStr:(NSString *)NationalType{
  if (NationalType.length<1) {
    return nil;
  }
  NSArray *nationNameArray = [[NSArray alloc]initWithArray:[NSString getNationalNameArray]];
  NSArray *nationIDArray = [[NSArray alloc]initWithArray:[NSString getNationalIDArray]];
  NSInteger typeInd = [nationIDArray indexOfObject:NationalType];
  return nationNameArray[typeInd];
}
// 传入民族名称返回民族id
+ (NSString *)getNationalIDNum:(NSString *)NationalNameStr{
  if (NationalNameStr.length<1) {
    return nil;
  }
  NSArray *nationNameArray = [[NSArray alloc]initWithArray:[NSString getNationalNameArray]];
  NSArray *nationIDArray = [[NSArray alloc]initWithArray:[NSString getNationalIDArray]];
  NSInteger typeInd = [nationNameArray indexOfObject:NationalNameStr];
  return nationIDArray[typeInd];
}



#pragma mark 城市code
// 传入code 获取文字
+ (NSString *)getCityNameStr:(NSString *)cityCode{
  
  
  return nil;
}


// 传入省市区获取code
+ (NSArray *)getProvinceName:(NSString *)ProvinceName cityName:(NSString *)cityName areaName:(NSString *)areaName{
  
  
  return nil;
  
}

- (NSString*)urlEncoded{
  NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
  return encodedString;
}

@end

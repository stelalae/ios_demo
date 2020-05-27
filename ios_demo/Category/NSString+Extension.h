//
//NSString+Extension.h
//IntercontinentalHealth
//
//Created by zsj on 2018/5/11.
//Copyright © 2018年 ITpower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 * 获取lab的行数和每行的内容
 * 返回数组的count是行数，数组里面的对象就是每行的内容
 */
+(NSArray *)getLinesArrayOfStringInLabel:(NSString *)text font:(UIFont *)font rect:(CGRect)rect;

+ (NSString *)dynamicImgUrl:(NSString *)url;

/**
 正则判断
 */
- (BOOL)isQQ; //qq
- (BOOL)isPhoneNumber; //电话
- (BOOL)isIPAddress; //IP地址
- (BOOL)isIdcard; //身份证
- (BOOL)isChinese ; //中文
- (BOOL)isEnglishChinese;//中文或英文
- (BOOL)iSNumber; //是数字
- (BOOL)iSNumber_English;
- (BOOL)isNull;//是否为空
- (BOOL)isPriceNumberTwo; //两位有效数
- (BOOL)isEmal; //邮箱地址校验
- (BOOL)isNotEmoji; //不是emoji
- (BOOL)isHaveCharacters; //判断字符串是否包含特殊字符
- (BOOL)isHaveNum; //判断字符串是否包含数字


/**
 计算文字size
 */
+(CGSize)sizeWith:(CGSize)size font:(UIFont *)font text:(NSString *)text;

+ (NSString *)uuid;
+ (NSDictionary *)getUrlParameterWithUrl:(NSURL *)url;

#pragma mark - 时间与日期

//获取当前时间
+ (NSString *)getCurrentTime;
//返回当前时间的指定格式
+ (NSString *)conversionDateTime:(NSTimeInterval)interval Format:(NSString *)format;
+ (NSString *)getDateTimeByFormat:(NSString *)format;
//时间戳转换为时间
+ (NSString *)conversionTime:(NSString *)str;
//计算距当前的时间差(用于IM)
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;


/**
 获取手机代码，返回代码
 */
+ (NSString *)getIphoneCode;
/**
 获取手机型号，返回型号
 */
+ (NSString *)getIphoneType;


//字典转json
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
//json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//根据id变量类型转化为对应string以供存储
+ (id)getIDVariableValueTypesWithString:(NSString *)string;
//根据存储的信息转为对应的变量类型
+ (NSString *)setIDVariableToString:(id)value;


#pragma mark - 身份证

//根据身份证号获取年龄
+ (NSString *)getIdentityCardAge:(NSString *)numberStr;
//根据身份证获取生日
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;
//从身份证上获取性别
+ (NSString *)getIdentityCardSex:(NSString *)numberStr;


#pragma mark - 证件

//获取证件类型数组
+ (NSArray *)getCredNameArray;
//获取证件类型id数组
+ (NSArray *)getCredIDArray;
//传入证件类型id返回证件名称
+ (NSString *)getCredNameStr:(NSString *)credType;
//传入证件名称返回证件类型id
+ (NSString *)getCredIDNum:(NSString *)credNameStr;


#pragma mark - 职业

//获取职业类型数组
+ (NSArray *)getProfessionalIDArray;
//获取职业类型数组
+ (NSArray *)getProfessionalNameArray;
//传入职业类型id返回职业名称
+ (NSString *)getProfessionalNameStr:(NSString *)ProfessionalType;
//传入职业名称返回职业类型id
+ (NSString *)getProfessionalredIDNum:(NSString *)ProfessionalStr;


#pragma mark - 民族

//获取民族名称数组
+ (NSArray *)getNationalNameArray;
//获取民族id数组
+ (NSArray *)getNationalIDArray;
//传入民族id返回民族名称
+ (NSString *)getNationalNameStr:(NSString *)NationalType;
//传入民族名称返回民族id
+ (NSString *)getNationalIDNum:(NSString *)NationalNameStr;


#pragma mark - 城市

//传入code 获取文字
+ (NSString *)getCityNameStr:(NSString *)cityCode;
//传入省市区获取code
+ (NSArray *)getProvinceName:(NSString *)ProvinceName cityName:(NSString *)cityName areaName:(NSString *)areaName;
//放在url上的字符串编码
- (NSString*)urlEncoded;
@end

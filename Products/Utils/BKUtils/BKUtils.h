//
//  BKUtils.h
//  linyi
//
//  Created by caike on 16/12/20.
//  Copyright © 2016年 com.kunekt.healthy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IsNull(val, def)        ((!val||[val isKindOfClass:[NSNull class]])?def:val)
#define NSStringFromInt(val)    [NSString stringWithFormat:@"%ld", (long)(val)]
#define NSStringFromNum(num)    [NSString stringWithFormat:@"%f", num]
#define NSNumberWithInt(val)    [NSNumber numberWithInt:val]
#define NSNumberWithNum(val)    [NSNumber numberWithDouble:val]
#define NSStringNotNull(val)    ((val)?val:@"")
#define NSStringIsValid(val)    (((val)||[val isKindOfClass:[NSNull class]]||[val isEqualToString:@""])?NO:YES)
#define NSStringNotNilAndNotNSNull(val) ((!val || [val isKindOfClass:[NSNull class]])?@"":val)

#define NSNumberWithStringUid(uid)    [NSNumber numberWithLongLong:uid.longLongValue]
#define NSStringWithNumUid(uid)  [NSString stringWithFormat:@"%lld",uid.longLongValue]
#define DICT_ADD_NUM_OR_STRING(a) (a==nil ?([a isKindOfClass:[NSString class]]?@"":@0):a)
#define PARAM_NOT_NULL(val,parm) ((val)?val:parm)

#define NSNummberNotNull(val)   ((val)?val:@0)

#define NSParamNotExcuse(val,action)   if(val){action;}
#define NSParamNotReturn(val)          if(!val){return;}


@interface BKUtils : NSObject

#pragma mark 正则表达式
//以1开始的11位手机号验证
+ (BOOL)checkPhoneNumInput:(NSString *)numStr;
//蓝牙地址
+ (BOOL)isMACAdress:(NSString *)str;
//俱乐部地址
+ (BOOL)isMatchClubAdress:(NSString *)str ;
//邮箱
+ (BOOL)validateEmail:(NSString *)email;
//手机号
+ (BOOL)validateMobile:(NSString *)mobile;
//用户名
+ (BOOL)validateUserName:(NSString *)name;
//密码
+ (BOOL)validatePassword:(NSString *)passWord;

//星期显示
+ (NSString *)displayString:(Byte)days;

//发送本地推送
+ (void)pushLocalMessageWithContent:(NSString *)contentBody
                    andContentTitle:(NSString *)title
                          soundName:(NSString *)soundName;
@end

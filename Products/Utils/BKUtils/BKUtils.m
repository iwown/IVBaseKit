//
//  BKUtils.m
//  linyi
//
//  Created by caike on 16/12/20.
//  Copyright © 2016年 com.kunekt.healthy. All rights reserved.
//

#import "BKUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>

#define MENU_LAB_TAG 981
#define LEFT_ICON_TAG 982
#define RIGHT_ICON_TAG 983

#define V3_FONT_KEYWORDS 2.386

@implementation BKUtils

#pragma mark 正则表达式判断手机
+ (BOOL)checkPhoneNumInput:(NSString *)numStr {
    
    NSString * MOBILE = @"^1\\d{10}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|78|8[2-478])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|7[06]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:numStr];
    BOOL res2 = [regextestcm evaluateWithObject:numStr];
    BOOL res3 = [regextestcu evaluateWithObject:numStr];
    BOOL res4 = [regextestct evaluateWithObject:numStr];
    
    if (res1 || res2 || res3 || res4 ) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)isMACAdress:(NSString *)str {
    
    NSString * regex        = @"^([A-F0-9][A-F0-9]:){5}[A-F0-9][A-F0-9]$";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:str];
    return isMatch;
}

+ (BOOL)isMatchClubAdress:(NSString *)str {
    
    NSString * regex        = @"[0-9]{1,19},[0-9]{1,19},.*";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:str];
    return isMatch;
}

//邮箱
+ (BOOL)validateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile {
    return [self checkPhoneNumInput:mobile];
}

//用户名
+ (BOOL)validateUserName:(NSString *)name {
    
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

//密码
+ (BOOL)validatePassword:(NSString *)passWord {
    
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

+ (NSString *)displayString:(Byte)days {
    NSLog(@"days char is: %02x",days);
    NSString *str = [NSString stringWithFormat:@""];
    
    if ((days & 0x7c) != 0x7c) {
        if (days>>6 &0x01) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,",NSLocalizedString(@"MON", nil)]];
        }
        
        if (days>>5 &0x01) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,",NSLocalizedString(@"TUE", nil)]];
        }
        
        if (days>>4 &0x01) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,",NSLocalizedString(@"WED", nil)]];
        }
        
        if (days>>3 &0x01) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,",NSLocalizedString(@"THU", nil)]];
        }
        
        if (days>>2 &0x01) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,",NSLocalizedString(@"FRI", nil)]];
        }
    }
    else
    {
        str = [NSString stringWithFormat:@"%@,",NSLocalizedString(@"Weekdays", nil)];
    }
    
    NSString *strWeekEnd;
    
    if ((days & 0x03) == 0x03)
    {
        strWeekEnd = [NSString stringWithFormat:NSLocalizedString(@"Weekends", nil)];
    }
    else if (days>>1 &0x01)
    {
        strWeekEnd = [NSString stringWithFormat:NSLocalizedString(@"SAT", nil)];
    }
    else if (days &0x01)
    {
        strWeekEnd = [NSString stringWithFormat:NSLocalizedString(@"SUN", nil)];
    }
    else
    {
        strWeekEnd = [NSString stringWithFormat:@""];
    }
    
    if ([strWeekEnd isEqualToString:@""])
    {
        if (![str isEqualToString:@""]) {
            NSRange range;
            range.length = str.length - 1;
            range.location = 0;
            str = [str substringWithRange:range];
        }
    }
    else
    {
        if ([str isEqualToString:@""]) {
            str = strWeekEnd;
        }
        else
        {
            str = [str stringByAppendingString:strWeekEnd];
        }
    }
    
    if (days == 0) {
        str = NSLocalizedString(@"Not Set", nil);
    }
    
    if (days == 0xFF)
    {
        str = NSLocalizedString(@"Everyday", nil);
    }
    
    return str;
}

+ (void)pushLocalMessageWithContent:(NSString *)contentBody
                    andContentTitle:(NSString *)title
                          soundName:(NSString *)soundName {
    
    if (@available(iOS 10,*)) {
        //通知内容类
        UNMutableNotificationContent * content = [UNMutableNotificationContent new];
        content.badge = @1;
        content.body = contentBody;
        if (soundName == nil) {
            content.sound =  [UNNotificationSound defaultSound];
        } else {
            content.sound = [UNNotificationSound soundNamed:soundName];
        }
        content.title = title;
        UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"NotificationDefault" content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (!error) {
                NSLog(@"发送本地推送成功 ");
            }
            else{
                NSLog(@"发送本地推送失败 error = %@",error);
            }
        }];
    }else {
        //发送本地推送
        if (soundName == nil) {
            soundName =  UILocalNotificationDefaultSoundName;
        }
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date];
        notification.alertBody = contentBody;
        notification.alertAction = NSLocalizedString(@"Open", nil);
        notification.soundName = soundName;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

@end

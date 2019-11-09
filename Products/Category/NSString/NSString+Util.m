//
//  NSString+Util.m
//  ZLYIwown
//
//  Created by 曹凯 on 16/4/28.
//  Copyright © 2016年 Iwown. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (NSString *)escapeHTML {
    NSMutableString *result = [self mutableCopy];
    [result replaceOccurrencesOfString:@"&"  withString:@"&amp;"  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"<"  withString:@"&lt;"   options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@">"  withString:@"&gt;"   options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"'"  withString:@"&#39;"  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    return result;
}

- (NSString *)deleteHTMLTag {
    NSMutableString *trimmedHTML = [self mutableCopy];
    NSString *styleTagPattern = @"<style[^>]*?>[\\s\\S]*?<\\/style>";
    NSRegularExpression *styleTagRe = [NSRegularExpression regularExpressionWithPattern:styleTagPattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *resultsArray = [styleTagRe matchesInString:trimmedHTML options:0 range:NSMakeRange(0, trimmedHTML.length)];
    for (NSTextCheckingResult *match in [resultsArray reverseObjectEnumerator]) {
        [trimmedHTML replaceCharactersInRange:match.range withString:@""];
    }
    
    NSString *htmlTagPattern = @"<[^>]+>";
    NSRegularExpression *normalHTMLTagRe = [NSRegularExpression regularExpressionWithPattern:htmlTagPattern options:NSRegularExpressionCaseInsensitive error:nil];
    resultsArray = [normalHTMLTagRe matchesInString:trimmedHTML options:0 range:NSMakeRange(0, trimmedHTML.length)];
    for (NSTextCheckingResult *match in [resultsArray reverseObjectEnumerator]) {
        [trimmedHTML replaceCharactersInRange:match.range withString:@""];
    }
    return trimmedHTML;
}

//利用正则表达式验证邮箱的合法性
+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark 正则表达式判断手机号
+ (BOOL)checkPhoneNumInput:(NSString *)numStr {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|7[06-8]|8[0-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|78|8[2-478])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|7[06]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    NSString * VNO = @"^170\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextesvno = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VNO];
    BOOL res1 = [regextestmobile evaluateWithObject:numStr];
    BOOL res2 = [regextestcm evaluateWithObject:numStr];
    BOOL res3 = [regextestcu evaluateWithObject:numStr];
    BOOL res4 = [regextestct evaluateWithObject:numStr];
    BOOL res5 = [regextesvno evaluateWithObject:numStr];

    if (res1 || res2 || res3 || res4 || res5){
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)isMACAdress:(NSString *)str{
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

#pragma mark - string

+ (NSString *)strinByTrimmingCharacter:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}

+ (NSString *)changeToUTF8String:(NSString *)string {
    NSString *doxStr = @"";
    for (int i = 0; i < string.length;i += 1) {
        NSString *subStr = [string substringWithRange:NSMakeRange(i, 1)];
        
        NSString *utf8Str = [subStr stringByRemovingPercentEncoding];
        
        if (utf8Str == nil)
        {
            continue;
        }
        doxStr = [doxStr stringByAppendingString:utf8Str];
    }
    return doxStr;
}

- (BOOL)stringContainsSubString:(NSString *)subStr {
    return [self containsString:subStr];
}

- (BOOL)judgeForStrIsEqualToNull {
    if ([self isKindOfClass:[NSNull class]]  ||
        [self isEqualToString:@""] ||
        [self isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}

- (NSString *)changeToUTF8String {
    NSString *doxStr = @"";
    for (int i = 0; i < self.length;i += 1) {
        NSString *subStr = [self substringWithRange:NSMakeRange(i, 1)];
        NSString *utf8Str = [subStr stringByRemovingPercentEncoding];
        if (utf8Str == nil){
            continue;
        }
        doxStr = [doxStr stringByAppendingString:utf8Str];
    }
    return doxStr;
}

- (int)countWordLenth {
    int i,n=(int)[self length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[self characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}

- (BOOL)isContainsEmoji {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    return returnValue;
}

@end

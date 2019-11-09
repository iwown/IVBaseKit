//
//  NSString+MD5.m
//  ZLYIwown
//
//  Created by CY on 2017/4/20.
//  Copyright © 2017年 Iwown. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)


- (NSString *)MD5
{
    return [NSString MD5ByAStr:self];
}

+ (NSString *)MD5ByAStr:(NSString *)aSourceStr {
    const char* cStr = [aSourceStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
    
    return ret;
}

@end

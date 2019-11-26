//
//  NSString+BLEUtils.h
//  IVBaseKit
//
//  Created by west on 2019/11/21.
//  Copyright © 2019 Iwown. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BLEUtils)

+ (NSString *)getAscIIString:(NSString *)str;

+ (NSString *)getStringWithUtf8:(NSString *)str;

+ (NSString *)getUintStringWithUtf8:(NSString *)str;

//只支持ASCII码支持的字符
+ (NSString *)uint8StrArrayToAscIIString:(NSString *)str;

+ (NSInteger)uint16StrToInteger:(NSString *)str;

+ (NSInteger)uint24StrToInteger:(NSString *)str;

+ (NSInteger)uint32StrToInteger:(NSString *)str;

+ (NSString *)uint32StringfromInteger:(NSInteger)intNum;

+ (NSInteger)int32StrToInteger:(NSString *)str;

+ (NSInteger)int16StrToInteger:(NSString *)str;

+ (NSString *)int16StrFromInteger:(NSInteger)intNum;

#pragma mark - 
// 16进制NSData转换成NSString
+ (NSString *)dataToByteTohex:(NSData *)data;

+ (NSData *)stringToByte:(NSString *)string;

+ (NSString *)hexStringFromString:(NSString *)string;

//两位 16进制转换10进制（高低位互换）
+ (NSString *)toHexString:(int)tmpid;

+ (int)toHexInt:(NSString *)tmpid;

+ (NSString *)uint16ToString:(NSInteger)num;

//4位 16进制
+ (NSString *)hl32StringWithInt:(unsigned long)am;

+ (NSString *)hl32StringByString:(NSString *)string;

+ (NSString *)int64ToHex:(int64_t)tmpid;

+ (NSString *)signedInt64ToHex:(int64_t)intNumber;



@end

NS_ASSUME_NONNULL_END

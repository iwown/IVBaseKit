//
//  NSString+BLEUtils.m
//  IVBaseKit
//
//  Created by west on 2019/11/21.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import "NSString+BLEUtils.h"


@implementation NSString (BLEUtils)


+ (NSString *)getAscIIString:(NSString *)str {
    
    NSString *returnStr = @"";
    for (int i = 0; i < str.length; i ++) {
        int asciiCode = [str characterAtIndex:i];
        NSString *asciiStr = [NSString stringWithFormat:@"%02lx",(long)asciiCode];
        returnStr = [returnStr stringByAppendingString:asciiStr];
    }
    return returnStr;
}

+ (NSString *)getStringWithUtf8:(NSString *)str {
    
    NSCharacterSet *doWant = [NSCharacterSet characterSetWithCharactersInString:@""];
    NSString *dataString = [str stringByAddingPercentEncodingWithAllowedCharacters:doWant];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    dataString = [[dataString componentsSeparatedByCharactersInSet:doNotWant] componentsJoinedByString:@""];
    
    NSString *pushString = [NSString stringWithFormat:@"02ff%@",dataString];
    return pushString;
}

+ (NSString *)getUintStringWithUtf8:(NSString *)str {
    
    NSCharacterSet *doWant = [NSCharacterSet characterSetWithCharactersInString:@""];
    NSString *dataString = [str stringByAddingPercentEncodingWithAllowedCharacters:doWant];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    dataString = [[dataString componentsSeparatedByCharactersInSet:doNotWant] componentsJoinedByString:@""];
    
    return dataString;
}

//只支持ASCII码支持的字符
+ (NSString *)uint8StrArrayToAscIIString:(NSString *)str {
    
    NSString *returnStr = @"";
    for (int i = 0; i < str.length/2; i ++) {
        NSString *rangeStr = [str substringWithRange:NSMakeRange(2*i, 2)];
        unsigned long a =  strtoul([rangeStr UTF8String],0,16);
        char b = toascii((int)a);
        NSString *str = [NSString stringWithFormat:@"%c",b];
        returnStr = [returnStr stringByAppendingString:str];
    }
    return returnStr;
}

+ (NSInteger)uint16StrToInteger:(NSString *)str {
    // 0x00c8
    NSString *lowByte =     [str substringWithRange:NSMakeRange(0, 2)];
    NSString *highByte =    [str substringWithRange:NSMakeRange(2, 2)];
    
    NSString *newStr = [NSString stringWithFormat:@"%@%@",highByte, lowByte];
    
    NSInteger newNum = strtoul([newStr UTF8String],0,16);
    
    return newNum;
}

+ (NSInteger)uint24StrToInteger:(NSString *)str {
    // 0x00c8
    NSString *lowByte =     [str substringWithRange:NSMakeRange(0, 2)];
    NSString *midByte =    [str substringWithRange:NSMakeRange(2, 2)];
    NSString *highByte =    [str substringWithRange:NSMakeRange(4, 2)];
    
    NSString *newStr = [NSString stringWithFormat:@"%@%@%@",highByte, midByte ,lowByte];
    
    NSInteger newNum = strtoul([newStr UTF8String],0,16);
    
    return newNum;
}

+ (NSInteger)uint32StrToInteger:(NSString *)str {
    
    NSString *lowByte =     [str substringWithRange:NSMakeRange(0, 2)];
    NSString *mid1Byte =    [str substringWithRange:NSMakeRange(2, 2)];
    NSString *mid2Byte =    [str substringWithRange:NSMakeRange(4, 2)];
    NSString *highByte =    [str substringWithRange:NSMakeRange(6, 2)];
    
    NSString *newStr = [NSString stringWithFormat:@"%@%@%@%@",highByte, mid2Byte ,mid1Byte, lowByte];
    NSInteger newNum = strtoul([newStr UTF8String],0,16);
    return newNum;
}

+ (NSInteger)int32StrToInteger:(NSString *)str {
    
    NSString *lowByte =     [str substringWithRange:NSMakeRange(0, 2)];
    NSString *mid1Byte =    [str substringWithRange:NSMakeRange(2, 2)];
    NSString *mid2Byte =    [str substringWithRange:NSMakeRange(4, 2)];
    NSString *highByte =    [str substringWithRange:NSMakeRange(6, 2)];
    
    NSString *newStr = [NSString stringWithFormat:@"%@%@%@%@",highByte, mid2Byte ,mid1Byte, lowByte];
    
    unsigned int newNum = (unsigned int)strtoul([newStr UTF8String],0,16);
    int num = newNum;
    NSInteger reNum = num;
    return reNum;
}

+ (NSInteger)int16StrToInteger:(NSString *)str {
    
    NSString *lowByte =     [str substringWithRange:NSMakeRange(0, 2)];
    NSString *highByte =    [str substringWithRange:NSMakeRange(2, 2)];
    
    NSString *newStr = [NSString stringWithFormat:@"%@%@", highByte, lowByte];
    int16_t reNum = strtol([newStr UTF8String], 0, 16);
    return reNum;
}

+ (NSString *)int16StrFromInteger:(NSInteger)intNum {
    
    NSString *str = @"";
    uint16_t uIntNum = (uint16_t)intNum;
    for (int i = 1; i >= 0 ; i --) {
        NSUInteger cy = pow(0x100, i);
        NSUInteger c = uIntNum/cy;
        uIntNum %= cy;
        str = [[NSString stringWithFormat:@"%02lx",(long)c] stringByAppendingString:str];
    }
    return str;
}

+ (NSString *)uint32StringfromInteger:(NSInteger)intNum {
    
    NSString *str = @"";
    uint32_t uIntNum = (uint32_t)intNum;
    for (int i = 3; i >= 0 ; i --) {
        NSUInteger cy = pow(0x100, i);
        NSUInteger c = uIntNum/cy;
        uIntNum %= cy;
        str = [[NSString stringWithFormat:@"%02lx",(long)c] stringByAppendingString:str];
    }
    return str;
}

#pragma mark - 
//接收数据时,NSData－>Byte数组->16进制数
+ (NSString *)NSDataToByteTohex:(NSData *)data {
    
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr = @"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+ (NSString *)hexStringFromString:(NSString *)string {
    
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length] == 1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+ (int)ToHexInt:(NSString*)tmpid {
    
    int int_ch;
    unichar hex_char1 = [tmpid characterAtIndex:0]; ////两位16进制数中的第一位(高位*16)
    int int_ch1;
    if(hex_char1 >= '0'&& hex_char1 <='9')
        int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
    else if(hex_char1 >= 'A'&& hex_char1 <='F')
        int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
    else
        int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
    
    unichar hex_char2 = [tmpid characterAtIndex:1]; ///两位16进制数中的第二位(低位)
    int int_ch2;
    if(hex_char2 >= '0'&& hex_char2 <='9')
        int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
    else if(hex_char1 >= 'A'&& hex_char1 <='F')
        int_ch2 = hex_char2-55; //// A 的Ascll - 65
    else
        int_ch2 = hex_char2-87; //// a 的Ascll - 97
    
    int_ch = int_ch1+int_ch2;
    NSLog(@"int_ch=%d",int_ch);
    
    return int_ch;
}

+ (NSString *)ToHexString:(int)tmpid {
    NSString *endtmp = @"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig) {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
    }
    
    switch (tmp) {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
    }
    
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    NSString *str=@"";
    if([endtmp length]<4) {
        for (int x=(int)[endtmp length]; x<4; x++) {
            str=[str stringByAppendingString:@"0"];
        }
        endtmp=[[NSString alloc]initWithFormat:@"%@%@",str,endtmp];
    }
    return endtmp;
}

+ (NSData*)stringToByte:(NSString*)string {
    
    NSString *hexString = [[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++) {
        unichar hex_char1 = [hexString characterAtIndex:i];
        ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;
        //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16;
        //// A 的Ascll - 65
        else return nil;
        i++;
        unichar hex_char2 = [hexString characterAtIndex:i];
        ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9') int_ch2 = (hex_char2-48);
        //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F') int_ch2 = hex_char2-55;
        //// A 的Ascll - 65
        else return nil;
        tempbyt[0] = int_ch1+int_ch2;
        ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    
    return bytes;
}

+ (NSString *)hl32StringWithInt:(unsigned long)am {
    NSString *str = [NSString stringWithFormat:@"%04lx",am];
    NSString *lStr = [str substringWithRange:NSMakeRange(2,2)];
    NSString *hStr = [str substringWithRange:NSMakeRange(0,2)];
    str = [lStr stringByAppendingString:hStr];
    return str;
}

+ (NSString *)hl32StringByString:(NSString *)string {
    NSString *str = string;
    NSString *lStr = [str substringWithRange:NSMakeRange(2,2)];
    NSString *hStr = [str substringWithRange:NSMakeRange(0,2)];
    str = [lStr stringByAppendingString:hStr];
    return str;
}

+ (NSString *)int64ToHex:(int64_t)tmpid {
    NSString *nLetterValue;
    NSString *str =@"";
    int64_t ttmpig;
    for (int i = 0; i<19; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig) {
            case 10:
                nLetterValue =@"a";break;
            case 11:
                nLetterValue =@"b";break;
            case 12:
                nLetterValue =@"c";break;
            case 13:
                nLetterValue =@"d";break;
            case 14:
                nLetterValue =@"e";break;
            case 15:
                nLetterValue =@"f";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%lld",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    if(str.length == 1)
        return [NSString stringWithFormat:@"0%@", str];
    return [NSString stringWithFormat:@"%@", str];
}

+ (NSString *)signedInt64ToHex:(int64_t)intNumber {
    NSString *hexStr = [NSString stringWithFormat:@"%02lx",(long)intNumber];
    if([hexStr length]>2){
        //this is the right place, when go else it's wrong
        //just to avoid crash in any case
        NSRange range = NSMakeRange([hexStr length]-2, 2);
        return [hexStr substringWithRange:range];
    }
    else return hexStr;
}

+ (NSString *)uint16ToString:(NSInteger)num {
    NSString *str = [NSString stringWithFormat:@"%04lx", (long)num];
    NSString *hStr = [str substringToIndex:2];
    NSString *lStr = [str substringFromIndex:2];
    NSString *reStr = [NSString stringWithFormat:@"%@%@", lStr, hStr];
    return reStr;
}


@end

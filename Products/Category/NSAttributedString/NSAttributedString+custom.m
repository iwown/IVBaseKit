//
//  NSAttributedString+custom.m
//  ZeronerHealthPro
//
//  Created by 曹凯 on 2017/7/6.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "NSAttributedString+custom.h"

@implementation NSAttributedString (custom)

+ (NSAttributedString *)stringToAttributeString:(NSString *)valueStr
                                           font:(UIFont *)fonta
                                            and:(NSString *)unitStr
                                        andfont:(UIFont *)fontb {
    NSString *testString = [valueStr stringByAppendingString:unitStr];
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:testString];
    
    [mString setAttributes:@{NSFontAttributeName:fonta} range:[testString rangeOfString:valueStr]];
    [mString setAttributes:@{NSFontAttributeName:fontb} range:[testString rangeOfString:unitStr]];
    return mString;
}

+ (NSAttributedString *)stringToAttributeString:(NSString *)valueStr
                                          color:(UIColor *)colora
                                            and:(NSString *)unitStr
                                       andColor:(UIColor *)colorb {
    NSString *testString = [valueStr stringByAppendingString:unitStr];
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:testString];
    
    [mString setAttributes:@{NSForegroundColorAttributeName:colora} range:[testString rangeOfString:valueStr]];
    [mString setAttributes:@{NSForegroundColorAttributeName:colorb} range:[testString rangeOfString:unitStr]];
    return mString;
}

+ (NSAttributedString *)stringToAttributeString:(NSString *)valueStr
                                          color:(UIColor *)colora
                                           font:(UIFont *)fonta
                                            and:(NSString *)unitStr
                                       andColor:(UIColor *)colorb
                                        andfont:(UIFont *)fontb {
    NSString *testString = [valueStr stringByAppendingString:unitStr];
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:testString];
    
    [mString setAttributes:@{NSFontAttributeName:fonta,NSForegroundColorAttributeName:colora} range:[testString rangeOfString:valueStr]];
    [mString setAttributes:@{NSFontAttributeName:fontb,NSForegroundColorAttributeName:colorb} range:[testString rangeOfString:unitStr]];
    return mString;
}

+ (NSAttributedString *)stringToAttributeString:(NSArray <NSString *>*)string
                                        andFont:(NSArray <UIFont *>*)font
                                       andColor:(NSArray <UIColor *>*)color {
    NSString *testString = [string firstObject];
    for (int i = 1; i <string.count; i ++) {
        testString = [testString stringByAppendingString:string[i]];
    }
    
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:testString];
    
    for (int i = 0; i <string.count; i ++) {
        [mString setAttributes:@{NSFontAttributeName:font[i],
                                 NSForegroundColorAttributeName:color[i]}
                         range:[testString rangeOfString:string[i]]];
    }
    
    return mString;
}
@end

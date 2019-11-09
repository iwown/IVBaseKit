//
//  NSString+URLEncoding.m
//  ZLYIwown
//
//  Created by west on 16/6/4.
//  Copyright © 2016年 Iwown. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)urlEncodeString {
    NSString *result = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return result;
}

@end

//
//  NSString+URLEncoding.m
//  ZLYIwown
//
//  Created by west on 16/6/4.
//  Copyright © 2016年 Iwown. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)urlEncodeString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             (CFStringRef)@";/?:@&=$+{}<>,",
                                                                                             kCFStringEncodingUTF8));
    return result;
}

@end

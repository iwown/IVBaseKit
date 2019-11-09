//
//  NSObject+JsonData.m
//  ZLYIwown
//
//  Created by CY on 2016/12/6.
//  Copyright © 2016年 Iwown. All rights reserved.
//

#import "NSObject+JsonData.h"

@implementation NSObject (JsonData)
-(NSString*)JSONString;
{
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString ;
    }else{
        return nil;
    }
}

-(NSData*)JSONData{
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}
@end

//
//  NSArray+OutOfIndex.m
//  Kawayi
//
//  Created by CY on 2018/2/5.
//  Copyright © 2018年 A$CE. All rights reserved.
//

#import "NSArray+OutOfIndex.h"

@implementation NSArray (OutOfIndex)

/*
 ** 当数组越界的时候，返回nil
 */
- (id)getElementAtIndex:(NSInteger)index {
    if (index > self.count-1) {
        return nil;
    }else {
        return [self objectAtIndex:index];
    }
}
@end

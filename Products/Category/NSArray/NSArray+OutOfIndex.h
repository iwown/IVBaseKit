//
//  NSArray+OutOfIndex.h
//  Kawayi
//
//  Created by CY on 2018/2/5.
//  Copyright © 2018年 A$CE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (OutOfIndex)

/*
 ** 当数组越界的时候，返回nil
 */
- (id)getElementAtIndex:(NSInteger)index;

@end

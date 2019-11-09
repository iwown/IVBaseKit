//
//  CWWeakProxy.h
//  ZeronerHealthPro
//
//  Created by ChenWu on 2017/5/2.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWWeakProxy : NSProxy

@property (weak,nonatomic,readonly)id target;

+ (instancetype)proxyWithTarget:(id)target;

- (instancetype)initWithTarget:(id)target;

@end

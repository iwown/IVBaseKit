//
//  CWWeakProxy.m
//  ZeronerHealthPro
//
//  Created by ChenWu on 2017/5/2.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "CWWeakProxy.h"

@implementation CWWeakProxy

- (instancetype)initWithTarget:(id)target {
    
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {
    return [[self alloc] initWithTarget:target];
}

#pragma mark - private
- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

#pragma mark - over write
//重写NSProxy如下两个方法，在处理消息转发时，将消息转发给真正的Target处理
- (void)forwardInvocation:(NSInvocation *)invocation {
    
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    return [_target respondsToSelector:aSelector];
}

@end

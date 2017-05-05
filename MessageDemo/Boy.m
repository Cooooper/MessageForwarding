//
//  Boy.m
//  MessageDemo
//
//  Created by Hanyahui on 2017/4/17.
//  Copyright © 2017年 OFashion. All rights reserved.
//

#import "Boy.h"
#import "Girl.h"

@implementation Boy

-(void)say:(NSString *)str girl:(NSString *)girl
{
    NSLog(@"%@",str);
    NSLog(@"%@",girl);
    
}


//在 forwardInvocation: 消息发送前，Runtime 系统会向对象发送methodSignatureForSelector: 消息，并取到返回的方法签名用于生成 NSInvocation 对象。所以重写 forwardInvocation: 的同时也要重写 methodSignatureForSelector: 方法，否则会抛异常。
-(NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        if ([Girl instancesRespondToSelector:aSelector]) {
            signature = [Girl instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature;
}

//NSInvocation 类型的对象，该对象封装了原始的消息和消息的参数
-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([Girl instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:[[Girl alloc] init]];//将消息转发给Girl对象
    }
}

-(id)forwardingTargetForSelector:(SEL)aSelector
{
//    return [[Girl alloc] init];
    return self;
//    return nil;
}





@end

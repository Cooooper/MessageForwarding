//
//  Personal.m
//  MessageDemo
//
//  Created by Hanyahui on 2017/4/26.
//  Copyright © 2017年 OFashion. All rights reserved.
//

#import "Personal.h"

@implementation Personal

- (void)testInvocation {
    int a = 1;
    int b = 2;
    int c = 3;
    SEL myMethod = @selector(myLog:param:parm:);
    SEL myMethod2 = @selector(myLog);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量要和调用的一致。
    
    
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:myMethod];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    //    2.FirstViewController *view = self;
    //    2.[invocation setArgument:&view atIndex:0];
    //    2.[invocation setArgument:&myMethod2 atIndex:1];
    // 设置target
    //    1.[invocation setTarget:self];
    // 设置selector
    [invocation setSelector:myMethod];
    // 注意：1、这里设置参数的Index 需要从2开始，因为前两个被selector和target占用。
    [invocation setArgument:&a atIndex:2];
    [invocation setArgument:&b atIndex:3];
    [invocation setArgument:&c atIndex:4];
    //    [invocation retainArguments];
    // 我们将c的值设置为返回值
    [invocation setReturnValue:&c];
    int d;
    // 取这个返回值
    [invocation getReturnValue:&d];
    NSLog(@"d:%d", d);
    
    NSUInteger argCount = [sig numberOfArguments];
    NSLog(@"argCount:%ld", argCount);
    
    for (NSInteger i=0; i<argCount; i++) {
        NSLog(@"%s", [sig getArgumentTypeAtIndex:i]);
    }
    NSLog(@"returnType:%s ,returnLen:%ld", [sig methodReturnType], [sig methodReturnLength]);
    NSLog(@"signature:%@" , sig);
    
    // 消息调用
    [invocation invokeWithTarget:self];
    [invocation getReturnValue:&d];

    NSLog(@"return value:%d", d);

}

//注意：代码中用1.标识的为第一种用法，通过setTarget和setSelector来设置NSInvocation的参数，而用2.标识的是另一种用法，通过setArgument atIndex:来设置参数。看个人的喜好。。。

- (int)myLog:(int)a param:(int)b parm:(int)c
{
    NSLog(@"MyLog:%d,%d,%d", a, b, c);
    return a+b+c;
}

- (void)myLog
{
    NSLog(@"你好,South China University of Technology");
}

@end

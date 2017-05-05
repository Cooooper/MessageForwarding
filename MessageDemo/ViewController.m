//
//  ViewController.m
//  MessageDemo
//
//  Created by Hanyahui on 2017/4/17.
//  Copyright © 2017年 OFashion. All rights reserved.
//

#import "ViewController.h"

#import "Girl.h"

#import "Boy.h"

#import "Personal.h"

@interface ViewController ()

@property (nonatomic ) NSArray *allDelegates;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self testGril];
//    [self testBoy];
    [self testPersonal];
}

- (void)testGril {
    Girl *girl = [[Girl alloc] init];
    [girl performSelector:@selector(sayGirl:) withObject:nil];
    [girl performSelector:@selector(checkBoy) withObject:nil];
}

- (void)testBoy {
    Boy *boy = [[Boy alloc] init];
//    [boy performSelector:@selector(sayGirl:) withObject:nil];//发一条girl的消息
//    [boy performSelector:@selector(checkBoy) withObject:nil];//发一条两个对象都无法识别的消息，由于girl可以接收任意消息所以这里也不会cash
    
    [boy performSelector:@selector(sayGirl:) withObject:nil];
    [boy performSelector:@selector(checkBoy) withObject:nil];

}


- (void)testPersonal {

    Personal *p = [Personal new];
    [p testInvocation];
    
    
}




- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        for (id target in self.allDelegates) {
            if ((signature = [target methodSignatureForSelector:aSelector])) {
                break;
            }
        }
    }
    return signature;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    for (id target in self.allDelegates) {
        if ([target respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:target];
        }
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    for (id target in self.allDelegates) {
        if ([target respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}


@end

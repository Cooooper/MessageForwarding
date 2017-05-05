//
//  Girl.m
//  MessageDemo
//
//  Created by Hanyahui on 2017/4/17.
//  Copyright © 2017年 OFashion. All rights reserved.
//

#import "Girl.h"

#import <objc/runtime.h>
void dynamicMethodIMP(id self, SEL _cmd)
{
    NSString *className = NSStringFromClass([self class]);
    NSString *selName = NSStringFromSelector(_cmd);
    NSLog(@"%@ :不是%@的方法",selName,className);//给用户警告但是不cash
}

@implementation Girl


- (void)sayGirl:(NSString *)word
{
    NSLog(@"I am a girl");
}

//全部转发
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    //从系统里匹配SEL，如没有就注册SEL
    SEL systemSel = sel_registerName(sel_getName(sel));
    //把所有未知的SEL指向dynamicMethodIMP的实现，让dynamicMethodIMP帮忙打印错误信息，但是程序不会Cash
    class_addMethod(self,systemSel,(IMP)dynamicMethodIMP,"v@:");
    return [super resolveClassMethod:systemSel];
    
//    NSProxy
}


//指定转发
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel == @selector(checkBoy)) {
//        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "V@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}






@end

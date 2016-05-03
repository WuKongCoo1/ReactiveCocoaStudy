//
//  UIViewController+ViewDidLoad.m
//  ReactiveCocoaStudy
//
//  Created by 吴珂 on 16/4/28.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "UIViewController+ViewDidLoad.h"
#import <objc/runtime.h>

@implementation UIViewController (ViewDidLoad)

- (void)swizzling_NoImplement
{
    NSLog(@"dada");
}

- (void)swizzling_ViewWillAppear:(BOOL)animated
{
    NSLog(@"%@", self.view);
    
    [self noImplement];
    
    if ([self isMemberOfClass:[UIViewController class]]) {
        
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
   
    [self swizzling_ViewWillAppear:animated];
}

- (void)swizzling_ViewDidLoad
{
    
    [self swizzling_ViewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}



+ (void)load
{
    swizzleMethod(self, @selector(viewWillAppear:), @selector(swizzling_ViewWillAppear:));
    [self swizzleMethod:self originalSelector:@selector(noImplement) swizzledSelector:@selector(swizzling_NoImplement)];
}

+ (void)swizzleMethod:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        IMP imp = method_getImplementation(originalMethod);
        IMP tImp = class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end

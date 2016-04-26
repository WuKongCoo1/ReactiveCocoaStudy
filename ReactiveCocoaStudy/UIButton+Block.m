//
//  UIButton+Block.m
//  UIButtonBlock
//
//  Created by 珂吴 on 16/4/22.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static const void *UIButtonBlockKey = &UIButtonBlockKey;

@implementation UIButton (Block)

- (void)addActionHandler:(TouchBlock)block
{
    objc_setAssociatedObject(self, &UIButtonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchUp:(UIButton *)btn
{
    TouchBlock block = objc_getAssociatedObject(self, &UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}

@end

//
//  UIButton+Block.h
//  UIButtonBlock
//
//  Created by 珂吴 on 16/4/22.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchBlock)(NSInteger tag);

@interface UIButton (Block)

- (void)addActionHandler:(TouchBlock)block;

@end

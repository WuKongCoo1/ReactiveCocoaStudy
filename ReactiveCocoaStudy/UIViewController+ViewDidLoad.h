//
//  UIViewController+ViewDidLoad.h
//  ReactiveCocoaStudy
//
//  Created by 吴珂 on 16/4/28.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ViewDidLoad)

- (void)swizzling_ViewDidLoad;

- (void)swizzling_ViewWillAppear:(BOOL)animated;

@end

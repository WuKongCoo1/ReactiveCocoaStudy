//
//  ViewController2.h
//  ReactiveCocoaStudy
//
//  Created by 吴珂 on 16/4/25.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
#import "RACSubscriber.h"

@interface ViewController2 : UIViewController

@property (nonatomic, strong) RACSubject *subject;

@end

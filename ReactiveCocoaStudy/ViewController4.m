//
//  ViewController4.m
//  ReactiveCocoaStudy
//
//  Created by 吴珂 on 16/4/26.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "ViewController4.h"

@interface ViewController4 ()

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"冷热信号";
//    [self coldSignal];
    
    [self hotSignal];
}

- (void)runOnce
{
    RACSignal *networkRequest = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@2];
        
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
    // Starts a single request, no matter how many subscriptions `connection.signal`
    // gets. This is equivalent to the -replay operator, or similar to
    // +startEagerlyWithScheduler:block:.
    RACMulticastConnection *connection = [networkRequest multicast:[RACReplaySubject subject]];
    [connection connect];
    
    [connection.signal subscribeNext:^(id response) {
        NSLog(@"subscriber one: %@", response);
    }];
    
    [connection.signal subscribeNext:^(id response) {
        NSLog(@"subscriber two: %@", response);
    }];
}

- (void)coldSignal
{
    
    RACSignal *coldSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        
        return nil;
        
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
        
        [coldSignal subscribeNext:^(id x) {
            NSLog(@"subscribor 1 receive %@", x);
        }];
    }];
    
    
    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        
        [coldSignal subscribeNext:^(id x) {
            NSLog(@"subscribor 2 receive %@", x);
        }];
    }];

}

- (void)hotSignal
{
//    RACSubject *hotSignal = [RACSubject subject];
//    
//        
//    [hotSignal subscribeNext:^(id x) {
//        NSLog(@"subscribor 1 receive %@", x);
//    }];
//    
//    [hotSignal sendNext:@1];
//    
//    [hotSignal subscribeNext:^(id x) {
//        NSLog(@"subscribor 2 receive %@", x);
//    }];
//    
//    [hotSignal sendNext:@2];
//    

    RACMulticastConnection *connection = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
            [subscriber sendNext:@1];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendNext:@2];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            [subscriber sendNext:@3];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:4 schedule:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }] publish];
    [connection connect];
    
    RACSignal *signal = connection.signal;
    
    NSLog(@"Signal was created.");
    [[RACScheduler mainThreadScheduler] afterDelay:1.1 schedule:^{
        [signal subscribeNext:^(id x) {
            NSLog(@"Subscriber 1 recveive: %@", x);
        }];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:2.1 schedule:^{
        [signal subscribeNext:^(id x) {
            NSLog(@"Subscriber 2 recveive: %@", x);
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController5.m
//  ReactiveCocoaStudy
//
//  Created by 吴珂 on 16/4/26.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "ViewController5.h"

@interface ViewController5 ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网络请求";
    
    
    
   /*--------------------------*/
    
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.wukongcoo1.com"]];
    
    self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [self.sessionManager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-type"];
    
    self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    @weakify(self)
    RACSignal *fetchData = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        
        
       NSURLSessionDataTask *task = [self.sessionManager GET:@"fang-wei-xin-biao-qing-shu-ru/" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            if (task.state != NSURLSessionTaskStateCompleted) {
                [task cancel];
            }
        }];
        
    }] replayLazily];
    
    RACSignal *title = [fetchData flattenMap:^RACSignal *(id value) {
        if (value) {
            return [RACSignal return:value];
        } else {
            return [RACSignal error:[NSError errorWithDomain:@"some error" code:400 userInfo:@{@"originData": value}]];
        }
    }];
    
    RACSignal *desc = [fetchData flattenMap:^RACSignal *(id value) {
        if (value) {
            return [RACSignal return:value];
        } else {
            return [RACSignal error:[NSError errorWithDomain:@"some error" code:400 userInfo:@{@"originData": value}]];
        }
    }];
    
    RACSignal *renderedDesc = [desc flattenMap:^RACStream *(NSString *value) {
        NSError *error = nil;

        return [RACSignal error:error];

    }];
    
    
    
    [[RACSignal merge:@[title, desc, renderedDesc]] subscribeError:^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.domain delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

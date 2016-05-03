//
//  ViewController3.m
//  ReactiveCocoaStudy
//
//  Created by 吴珂 on 16/4/25.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()
<
NSURLSessionDelegate,
NSURLSessionDataDelegate,
NSURLSessionTaskDelegate
>
@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"网络请求";
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.wukongcoo1.com/content/images/2016/04/----3.gif"]];
    
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            [subscriber sendNext:data];
            [subscriber sendCompleted];
            
        }];
        
        [task resume];
        
        return nil;
        
    }];
    
    [requestSignal subscribeNext:^(id x) {
        NSLog(@"请求到了 %@", x);
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session NS_AVAILABLE_IOS(7_0)
{
     NSLog(@"%@", session);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"%@", data);
}
@end

//
//  ViewController6.m
//  ReactiveCocoaStudy
//
//  Created by 吴珂 on 16/4/26.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "ViewController6.h"
#import "RACReturnSignal.h"


@interface ViewController6 ()


@property (nonatomic, strong) RACCommand *reuqesCommand;

@end

@implementation ViewController6

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self initialBind];
    
    [self RACMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}

- (void)initialBind
{
    _reuqesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"q"] = @"基础";
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            
            [manager GET:@"https://api.douban.com/v2/book/search" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                // 请求成功调用
                // 把数据用信号传递出去
                [subscriber sendNext:dic];
                
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"");
            }];
            
            return nil;
        }];
        
        
        
        
        // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
        return [requestSignal map:^id(NSDictionary *value) {
            NSMutableArray *dictArr = value[@"books"];
            
            // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
            NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
                
                return value;
            }] array];
            
            return modelArr;
        }];
        
    }];
    
    RACSignal *signal = [_reuqesCommand execute:nil];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)RACMap
{
    NSArray *arr = @[@1, @2, @3, @4];
    
    NSArray *newArr = [[arr.rac_sequence map:^id(NSNumber * value) {
        return @([value integerValue] + 1);
    }] array];
    
    NSLog(@"%@", newArr);
    
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [subscriber sendNext:@3];
        
        return nil;
        
    }] flattenMap:^RACStream *(id value) {
        return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];;

    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@3];
        
        return nil;
        
    }] map:^id(id value) {
        return [NSString stringWithFormat:@"map:%@", value];
    }];
    
    
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}



@end

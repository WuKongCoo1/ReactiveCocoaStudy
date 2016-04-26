//
//  ViewController7.m
//  ReactiveCocoaStudy
//
//  Created by 吴珂 on 16/4/26.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "ViewController7.h"

@interface ViewController7 ()
@property (weak, nonatomic) IBOutlet UITextField *usernameLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController7

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *canLoginSignal = [RACSignal combineLatest:@[
                               _usernameLabel.rac_textSignal,
                               _pwdLabel.rac_textSignal]
                            reduce:^(NSString *username, NSString *password){
                                    NSLog(@"%@", username);
                                   return @(username.length > 5 && password.length > 5);
                               }];
    RAC(self.loginBtn, enabled) = canLoginSignal;
    
//    RACSignal *test = [RACSignal combineLatest:@[
//                              _usernameLabel.rac_textSignal,
//                              _pwdLabel.rac_textSignal]];
//    
//    [test subscribeNext:^(id x) {
//        RACTupleUnpack(NSString *name, NSString *pwd) = x;
//        NSLog(@"%@ %@", name, pwd);
//        self.loginBtn.enabled = name.length >= 5 && pwd.length >= 5;
//    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

//
//  ViewController1.m
//  ReactiveCocoaStudy
//
//  Created by 吴珂 on 16/4/25.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "ViewController1.h"
#import "ReactiveCocoa.h"
#import "ViewController2.h"

@interface ViewController1 ()

@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UITextView *tv;


@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"基本使用";
    
    UIButton *btn = ({
        UIButton *tBtn = [UIButton buttonWithType:UIButtonTypeInfoDark];
        
        tBtn.center = self.view.center;
        
        [tBtn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        tBtn;
    });
    
    [self.view addSubview:btn];
    //按钮事件
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"摸了按钮啦");
    }];
    
    //selector
    [[self rac_signalForSelector:@selector(touchBtn:)] subscribeNext:^(id x) {
        NSLog(@"监听selector");
    }];;
    
    //文本信号
    [_tf.rac_textSignal subscribeNext:^(id x) {
        _lbl.text = x;
    }];
    
    /*宏定义使用*/
    RAC(_lbl, text) = _tv.rac_textSignal;
    
    [RACObserve(_lbl, text) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    RACTuple *tuple = RACTuplePack(@3, @4);
    
    RACTupleUnpack(NSString *key, NSString *value) = tuple;
    
    NSLog(@"%@ %@", key, value);
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    _lbl.userInteractionEnabled = YES;
    [_lbl addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(UITapGestureRecognizer *x) {
        NSLog(@"点击了label");
    }];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [_lbl addGestureRecognizer:pan];
    
    [pan.rac_gestureSignal subscribeNext:^(UIPanGestureRecognizer * x) {
        
    }];
    

}

- (void)touchBtn:(id)sender
{
    NSLog(@"啪啪啪");
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    ViewController2 *vc2 = [ViewController2 new];
//    vc2.subject = [RACSubject new];
//    [vc2.subject subscribeNext:^(id x) {
//        NSLog(@"点击咯");
//    }];
//    [self.navigationController pushViewController:vc2 animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

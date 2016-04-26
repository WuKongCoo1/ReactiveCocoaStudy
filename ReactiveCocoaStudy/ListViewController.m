//
//  ListViewController.m
//  ReactiveCocoaStudy
//
//  Created by 吴珂 on 16/4/25.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()
<
UITableViewDelegate, UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [self nameWithIndexPath:indexPath];
}


#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *vcName = [self nameWithIndexPath:indexPath];
    Class class = NSClassFromString(vcName);
    
    if (class) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        @try {
            id vc = [sb instantiateViewControllerWithIdentifier:vcName];
            [self.navigationController pushViewController:vc animated:YES];
        } @catch (NSException *exception) {
            [self.navigationController pushViewController:[class new] animated:YES];
        } @finally {
            
        }
        
        
        
    }
    
}

- (NSString *)nameWithIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"ViewController%ld", (long)indexPath.row + 1];
}
@end

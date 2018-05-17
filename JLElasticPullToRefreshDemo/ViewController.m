//
//  ViewController.m
//  JLElasticPullToRefreshDemo
//
//  Created by Janlor on 2018/5/7.
//  Copyright © 2018 Janlor. All rights reserved.
//

#import "ViewController.h"
#import "JLElasticRefresh.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed: 57/255.0 green: 67/255.0 blue: 89/255.0 alpha: 1.0];
    
    JLElasticRefreshLoadingViewCircle *loadingView = [[JLElasticRefreshLoadingViewCircle alloc] init];
    loadingView.tintColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [_tableView cyer_addRefreshWithActionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView cyer_stopLoading];
        });
    } loadingView:loadingView];
    [_tableView cyer_setRefreshFillColor:[UIColor colorWithRed: 57/255.0 green: 67/255.0 blue: 89/255.0 alpha: 1.0]];
    [_tableView cyer_setRefreshBackgroundColor:_tableView.backgroundColor];
}

- (void)dealloc {
    [_tableView cyer_removeRefresh];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

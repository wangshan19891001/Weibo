//
//  ProfileViewController.m
//  Weibo
//
//  Created by 王陕 on 16/5/16.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化导航条
    [self initNavigationBar];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}

- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:kScreen];
    }
    return _tableView;
}

#pragma mark - 初始化导航条
- (void) initNavigationBar {

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:(UIBarButtonItemStylePlain) target:self action:@selector(setting)];
}
- (void)setting {
    NSLog(@"设置");
}


#pragma mark - tableView  dataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"profile";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"profile";
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

@end

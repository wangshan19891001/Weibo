//
//  DiscoverViewController.m
//  Weibo
//
//  Created by 王陕 on 16/5/16.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "DiscoverViewController.h"
#import "WSSearchBar.h"

@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;


@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化导航条
    [self initNavigationBar];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:kScreen];
    }
    return _tableView;
}

#pragma mark - 初始化导航条
- (void)initNavigationBar {

    // 设置搜索框
    WSSearchBar *searchBar = [WSSearchBar searchBar];
    searchBar.width = kScreenWidth - 20;
    searchBar.height = 30;
    
    self.navigationItem.titleView = searchBar;
    
}


#pragma mark - tableView  dataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *indentifier = @"discover";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.textLabel.text = @"discover";
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

@end

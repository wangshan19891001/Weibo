//
//  HomeViewController.m
//  Weibo
//
//  Created by 王陕 on 16/5/16.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "HomeViewController.h"
#import "test1ViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeViewController

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
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) Image:@"navigationbar_friendsearch" highlightImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) Image:@"navigationbar_pop" highlightImage:@"navigationbar_pop_highlighted"];

}

- (void)friendsearch {
    NSLog(@"添加好友");
}
- (void)pop {
    NSLog(@"扫一扫");
}

#pragma mark - tableView  dataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"home";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"home";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    test1ViewController *test1 = [[test1ViewController alloc] initWithNibName:@"test1ViewController" bundle:nil];
    
    [self.navigationController pushViewController:test1 animated:YES];
    
}

@end

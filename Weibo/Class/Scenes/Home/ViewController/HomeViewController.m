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
    
    // 初始化tableView视图
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
    
    /*   左导航按钮   */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) Image:@"navigationbar_friendsearch" highlightImage:@"navigationbar_friendsearch_highlighted"];
    
    
    /*   右导航按钮   */
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) Image:@"navigationbar_pop" highlightImage:@"navigationbar_pop_highlighted"];
    
    /*   中间标题   */
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.width = 150;
    titleButton.height = 30;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    // 设置某一个方向的边距, 相当于该方向上的视图切割掉多少像素
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 100, 0, 0)];
    
    // 监听按钮的点击方法
    [titleButton addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

- (void)friendsearch {
    NSLog(@"添加好友");
}
- (void)pop {
    NSLog(@"扫一扫");
}

- (void)titleClick {
    
    // 获取当前屏幕最上层的窗口
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    
    // 添加蒙版, 用来拦截下拉菜单下方视图的点击事件
    UIView *cover = [[UIView alloc] initWithFrame:window.bounds];
    cover.backgroundColor = [UIColor clearColor];
    [window addSubview:cover];
    
    UIImageView *dropdownMenu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popover_background"]];
    dropdownMenu.width = 217;
    dropdownMenu.height = 217;
    dropdownMenu.y = 40;
    dropdownMenu.userInteractionEnabled = YES;
    [cover addSubview:dropdownMenu];
    
    
    
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

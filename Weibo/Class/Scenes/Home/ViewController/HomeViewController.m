//
//  HomeViewController.m
//  Weibo
//
//  Created by 王陕 on 16/5/16.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "HomeViewController.h"
#import "WSDropdownMenu.h"
#import "DropTableVC.h"
#import "test1ViewController.h"

#import "AccountTool.h"
#import "Account.h"

#import <AFNetworking.h>

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:kScreen];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 初始化导航条
    [self initNavigationBar];
    
    // 初始化tableView视图
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // 请求用户信息
    [self setUserInfo];
    
    
}

- (void)setUserInfo {
    
    // https://api.weibo.com/2/users/show.json
    // GET
    // access_token
    // uid
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    Account *account = [AccountTool loadAccount];
    param[@"access_token"] = account.access_token;
    param[@"uid"] = account.uid;
    
    [[AFHTTPSessionManager manager] GET:@"https://api.weibo.com/2/users/show.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"##### Function:%s line:%d ", __FUNCTION__, __LINE__);
        NSLog(@"用户信息请求成功");
        
        NSLog(@"%@", responseObject);
        
        UIButton *button = (UIButton*) self.navigationItem.titleView;
        
        account.name = responseObject[@"name"];
        
        [button setTitle:account.name forState:UIControlStateNormal];
//        button.titleLabel.text = responseObject[@"name"]; // 这个方法点击一次button后, button的题目又变回去了
        
        // 保存账户昵称
        [AccountTool saveAccount:account];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"##### Function:%s line:%d ", __FUNCTION__, __LINE__);
        NSLog(@"用户信息请求失败, error: %@", error);
        
    }];
    

}


#pragma mark - 初始化导航条
- (void)initNavigationBar {
    
    /*   左导航按钮   */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) Image:@"navigationbar_friendsearch" highlightImage:@"navigationbar_friendsearch_highlighted"];
    
    /*   右导航按钮   */
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) Image:@"navigationbar_pop" highlightImage:@"navigationbar_pop_highlighted"];
    
    /*   中间标题   */
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.backgroundColor = [UIColor grayColor];
    titleButton.imageView.backgroundColor = [UIColor yellowColor];
    titleButton.width = 150;
    titleButton.height = 30;
    Account *account = [AccountTool loadAccount];
    [titleButton setTitle:account.name?account.name:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    // 监听按钮的点击方法
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
    
    // 设置某一个方向的边距, 相当于该方向上的视图切割掉多少像素
//    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 100, 0, 0)];
    
    
    // 标题宽度
    // 宽度乘上scale系数, 保证retina屏幕上的图片宽度是正确的
//    CGFloat titleW = titleButton.titleLabel.width * [UIScreen mainScreen].scale;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = titleButton.titleLabel.font;
    CGFloat titleW = [titleButton.currentTitle sizeWithAttributes:attrs].width * [UIScreen mainScreen].scale;
    
    
    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;
    CGFloat left = titleW + imageW;
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
    titleButton.titleLabel.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
    
    
    
    
    
    // 什么情况下建议使用imageEdgeInsets, titleEdgeInsets
    // 如果按钮内部的图片, 文字固定, 用这两个属性来设置间距会比较简单
    // 这两个属性是接收像素的, 使用的时候需要在原来宽,高的基础上乘 [UIScreen mainScreen].scale
    // imageEdgeInsets 试用范围在文字和图片的宽度在某几个之间是固定的, 不取决于外界, 上例中, 只有titleButton的达到一定宽度时, 试用imageEdgeInsets 才有效果
    // 按钮的imageRect 和 titleRect 这两个属性, 本质上都是依据UIEdgeInsesMake 这个属性设置的
    // 使用这个属性, 在某些情况下, 可以不用自定义按钮, 就可以满足文字在左边,图片在右边的效果
    
    
    
}

- (void)friendsearch {
    NSLog(@"添加好友");
}
- (void)pop {
    NSLog(@"扫一扫");
}

- (void)titleClick:(UIButton *)titleButton {
    
    
    
    DropTableVC *dropTVC = [[DropTableVC alloc] init];
    dropTVC.view.height = 44 * 3;
    dropTVC.view.backgroundColor = [UIColor clearColor];
//    dropTVC.tableView.backgroundColor = [UIColor clearColor];
    
    WSDropdownMenu *dropdownMenu = [WSDropdownMenu menu];
    
    dropdownMenu.dropTVC = dropTVC;
    
    
    [dropdownMenu showFrom:titleButton];
    
    
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

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
#import "TitleButton.h"
#import "test1ViewController.h"

#import "Account.h"
#import "Status.h"
#import "User.h"

#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

#import "UserInfoReq.h"
#import "StatusReq.h"
#import "LoadMoreFooter.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *statusArray;


@end

@implementation HomeViewController

- (NSMutableArray *)statusArray {
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    return _statusArray;
}

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
    [self loadUserInfo];
    
    // 加载微博数据 (改为程序启动后, 自动进入下拉刷新状态)
//    [self loadNewStatus];
    
    // 集成下拉刷新控件
    [self setupDownRefresh];
    
    // 集成上拉刷新控件
    [self setupUpRefresh];
    
    //获得微博未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    //主线程也会抽时间处理一下timer (不管主线程是否正在处理其他事件)
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]; //默认timer也是加到主运行循环的, 这里主要是为了修改运行循环的模式
    //主运行循环在程序进入后台时, 会停止运行, 需要在appDelegate中做一些处理
    
    
}

//设置未读微博数
- (void)setupUnreadCount {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    Account *account = [LocalTools loadAccount];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = account.access_token;
    param[@"uid"] = account.uid;
    
    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //微博的未读数
//        int unRead = [responseObject[@"status"] intValue];
//        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", unRead];
        
        NSString *unread = [responseObject[@"status"] description];
        if ([unread isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
        
            self.tabBarItem.badgeValue = unread;
            [UIApplication sharedApplication].applicationIconBadgeNumber = [unread integerValue];
        }
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取未读微博数失败");
        
    }];
    
    
}




#pragma mark - 初始化控件
- (void)initNavigationBar {
    
    /*   左导航按钮   */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) Image:@"navigationbar_friendsearch" highlightImage:@"navigationbar_friendsearch_highlighted"];
    
    /*   右导航按钮   */
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) Image:@"navigationbar_pop" highlightImage:@"navigationbar_pop_highlighted"];
    
    /*   中间标题   */
    TitleButton *titleButton = [[TitleButton alloc] init];
    Account *account = [LocalTools loadAccount];
    [titleButton setTitle:account.name?account.name:@"首页" forState:UIControlStateNormal];
    
    // 监听按钮的点击方法
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮自适应
//    [titleButton sizeToFit];
    self.navigationItem.titleView = titleButton;
    
    
    // 设置某一个方向的边距, 相当于该方向上的视图切割掉多少像素
//    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 100, 0, 0)];
    
    
    // 标题宽度
    // 宽度乘上scale系数, 保证retina屏幕上的图片宽度是正确的
//    CGFloat titleW = titleButton.titleLabel.width * [UIScreen mainScreen].scale;
    
    
    //根据字体查看字体所占的宽度 
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = titleButton.titleLabel.font;
//    CGFloat titleW = [titleButton.currentTitle sizeWithAttributes:attrs].width * [UIScreen mainScreen].scale;
//    
//    
//    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;
//    CGFloat left = titleW + imageW;
//    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
//    titleButton.titleLabel.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
    
    
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

- (void)setupDownRefresh {
    
    //1, 添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    //只有手动下拉, 才会触发valueChanged
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //2, 程序启动后, 马上进入刷新状态
    [control beginRefreshing];
    
    //3, 手动调用刷新方法
    [self refreshStateChange:control];
    
    
}
- (void)refreshStateChange:(UIRefreshControl*)control {

    Account *account = [LocalTools loadAccount];
    
    StatusReq* request = [[StatusReq alloc] init];
    request.access_token = account.access_token;
    request.count = @20;
    
    //取出微博中最前面的微博 (微博数据的第一条, 最新, id最大)
    Status *firstStatus = self.statusArray.firstObject;
    if (firstStatus) {
        request.since_id = firstStatus.idstr;
    }
    
    
    NetTools *server = [NetTools sharedManager];
    [server loadStatus:request success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"##### Function:%s line:%d ", __FUNCTION__, __LINE__);
        NSLog(@"下拉刷新请求成功");
        
        //下拉刷新成功, 清空badgeValue
        self.tabBarItem.badgeValue = nil;
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        // 将微博的字典数组 转为 模型数组
        NSArray *newStatusArray = [Status mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //newStatusArray 需要插入到原来总数组的最前面
        
        if (newStatusArray.count > 0) {
            
            NSRange range = NSMakeRange(0, newStatusArray.count); //从头0开始, count是插入的长度
            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
            [self.statusArray insertObjects:newStatusArray atIndexes:set];
        }
        
        //刷新UI
        [self.tableView reloadData];
        
        //结束刷新
        [control endRefreshing];
        
        
        //显示最新微博数量
        [self showNewStatusCount:(int)newStatusArray.count];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"##### Function:%s line:%d ", __FUNCTION__, __LINE__);
        NSLog(@"下拉刷新请求失败, error: %@", error);
        
        //结束刷新状态
        [control endRefreshing];
    }];
}

//显示最新微博的数量
- (void)showNewStatusCount:(int)count {
    
    //1, 创建
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    //2, 设置属性
    if (count == 0) {
        label.text = @"没有新的微博数据";
    }else{
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据", count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    label.y = 64 - label.height;
    
    //3,添加
    //将label添加到导航控制器的view中, 并且在导航栏的下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //4,动画
    float duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        
//        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        
    } completion:^(BOOL finished) {
        
        float delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            
//            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
        }];
    }];
    
    //如果某个动画执行完毕后, 又要互道动画执行前的状态, 建议用transform做动画
    
}


//上拉加载控件
- (void)setupUpRefresh {
    
    LoadMoreFooter *footer = [LoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    
}



#pragma mark - 加载数据
/**
 *  加载用户信息
 */
- (void)loadUserInfo {
    
    Account *account = [LocalTools loadAccount];
    UserInfoReq *request = [[UserInfoReq alloc] init];
    request.access_token = account.access_token;
    request.uid = account.uid;
    
    NetTools *server = [NetTools sharedManager];
    [server loadUserInfo:request success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"##### Function:%s line:%d ", __FUNCTION__, __LINE__);
        NSLog(@"用户信息请求成功");
        
        UIButton *button = (UIButton*) self.navigationItem.titleView;
        
        account.name = responseObject[@"name"];
        
        [button setTitle:account.name forState:UIControlStateNormal];
//        button.titleLabel.text = responseObject[@"name"]; // 这个方法点击一次button后, button的题目又变回去了
        
        // 保存账户昵称
        [LocalTools saveAccount:account];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"##### Function:%s line:%d ", __FUNCTION__, __LINE__);
        NSLog(@"用户信息请求失败, error: %@", error);
    }];
}

/**
 *  加载微博数据
 */
- (void)loadNewStatus {

    Account *account = [LocalTools loadAccount];
    
    StatusReq* request = [[StatusReq alloc] init];
    request.access_token = account.access_token;
    request.count = @20;
    
    NetTools *server = [NetTools sharedManager];
    [server loadStatus:request success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"##### Function:%s line:%d ", __FUNCTION__, __LINE__);
        NSLog(@"微博数据请求成功");
        
        //网络请求下来的最新的微博数据
        NSArray *newStatusArray = [Status mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        [self.statusArray addObjectsFromArray:newStatusArray];
        
        [self.tableView reloadData];
        
//        NSArray *statusArray = responseObject[@"statuses"];
//        for (NSDictionary *dict in statusArray) {
//            
////            Status *status = [[Status alloc] init];
////            [status mj_setKeyValues:dict];
//
//            // 如果使用KVC赋值, 需要重写setValue:forUndefinedKey:
////            [status setValuesForKeysWithDictionary:dict];
//            
//            
//            
//            Status *status = [Status mj_objectWithKeyValues:dict];
//            
//            
//            
//            [self.statusArray addObject:status];
//        }
//        
//        
//        [self.tableView reloadData];
        
        
        // 包含模型的复杂字典, 不能写到plist文件中
//        NSFileManager *manager = [NSFileManager defaultManager];
//        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//        NSString *filePath = [path stringByAppendingPathComponent:@"status.plist"];
//        [manager createFileAtPath:filePath contents:nil attributes:nil];
//        
//        NSDictionary *dict = [responseObject mj_keyValues];
//        [dict writeToFile:filePath atomically:YES];
//        
//        NSDictionary *dic = @{@"wangshan":@"name"};
//        NSLog(@"%@", dict);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"##### Function:%s line:%d ", __FUNCTION__, __LINE__);
        NSLog(@"微博数据请求失败, error: %@", error);
        
    }];
}


#pragma mark - tableView  dataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    Status *status = self.statusArray[indexPath.row];
    
    cell.textLabel.text = status.user.name;
    cell.detailTextLabel.text = status.text;
    NSString *urlString = status.user.profile_image_url;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    test1ViewController *test1 = [[test1ViewController alloc] initWithNibName:@"test1ViewController" bundle:nil];
    
    [self.navigationController pushViewController:test1 animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.statusArray.count == 0 || self.tableView.tableFooterView.isHidden == NO) {
        return;
    }
    
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */

    
}

- (void)loadMoreStatus {
    
    Account *account = [LocalTools loadAccount];
    
    StatusReq* request = [[StatusReq alloc] init];
    request.access_token = account.access_token;
    request.count = @20;
    
    //取出微博中最前面的微博 (微博数据的第一条, 最新, id最大)
    Status *lastStatus = self.statusArray.lastObject;
    if (lastStatus) {
        
        long long maxId = lastStatus.idstr.longLongValue -1;
        request.max_id = @(maxId);
    }
    
    
    NetTools *server = [NetTools sharedManager];
    [server loadStatus:request success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"##### Function:%s line:%d ", __FUNCTION__, __LINE__);
        NSLog(@"下拉刷新请求成功");
        
        
        // 将微博的字典数组 转为 模型数组
        NSArray *newStatusArray = [Status mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //newStatusArray 需要插入到原来总数组的最前面
        
        if (newStatusArray.count > 0) {
            
//            NSRange range = NSMakeRange(0, newStatusArray.count); //从头0开始, count是插入的长度
//            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
//            [self.statusArray insertObjects:newStatusArray atIndexes:set];
            
            //加载到的更多的微博数据,加载到总数组的最后面
            [self.statusArray addObjectsFromArray:newStatusArray];
            
            
        }
        
        //刷新UI
        [self.tableView reloadData];
        
        //结束刷新
        self.tableView.tableFooterView.hidden = YES;
        
        
        //显示最新微博数量 (上拉加载时, 不用显示微博数量)
//        [self showNewStatusCount:(int)newStatusArray.count];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"##### Function:%s line:%d ", __FUNCTION__, __LINE__);
        NSLog(@"下拉刷新请求失败, error: %@", error);
        
        //结束刷新状态
        self.tableView.tableFooterView.hidden = YES;
    }];
    
}



@end

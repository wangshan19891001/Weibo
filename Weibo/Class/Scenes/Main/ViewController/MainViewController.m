//
//  MainViewController.m
//  Weibo
//
//  Created by 王陕 on 16/5/17.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "MainViewController.h"
#import "DiscoverViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "WSNavigationController.h"
#import "WSTabBar.h"


@interface MainViewController ()<WSTabBarDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建子控制器 首页 消息 发现 我
    // 首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self addChildViewController:homeVC title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    
    // 消息
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    [self addChildViewController:messageVC title:@"消息" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
    
    // 发现
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc] init];
    [self addChildViewController:discoverVC title:@"发现" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    
    // 我
    ProfileViewController *profileVC= [[ProfileViewController alloc] init];
    [self addChildViewController:profileVC title:@"我" image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];
    
    
    // 替换系统的tabBar
    WSTabBar *tabBar = [[WSTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}

- (void)tabBarDidClickPlusButton:(WSTabBar *)tabBar {
    
    NSLog(@"加号");
    
}



/**
 *  添加子控制器
 *
 *  @param viewController 子控制器
 *  @param title          标题
 *  @param image          图片
 *  @param selectImage    被选中图片
 */
- (void)addChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    
    // 设置控制器的tabBarItem标题
    viewController.tabBarItem.title = title;
    viewController.navigationItem.title = title;
    
    // 被选中时, 文字的颜色
    NSDictionary *textAttr = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [viewController.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateSelected];
    
    // 设置图片
    viewController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 给子控制器添加导航控制器
    WSNavigationController *nav = [[WSNavigationController alloc] initWithRootViewController:viewController];
    
    // 将子控制器添加到tabBar控制器上
    [self addChildViewController:nav];
    
    // tabBar标签控制器, 在切换多个子视图控制器时, 除了当前显示的页面外, 其余视图也不会被销毁. 多个视图控制器存在于self.viewControllers 和 self.childViewControllers 数组中
    
}



@end

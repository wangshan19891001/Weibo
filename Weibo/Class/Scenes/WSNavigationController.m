//
//  WSNavigationController.m
//  Weibo
//
//  Created by 王陕 on 16/5/24.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "WSNavigationController.h"

@interface WSNavigationController ()

@end

@implementation WSNavigationController

// 第一次加载这个类的时候调用
+ (void)initialize {
    
//    [UINavigationBar appearance]; // 设置导航栏文字大小, 颜色
    
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance]; // 导航栏item的大小, 颜色
    
    // 设置普通状态
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttr forState:(UIControlStateNormal)];
    
    // 设置不可用状态
    NSMutableDictionary *disabelAttr = [NSMutableDictionary dictionary];
    disabelAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    disabelAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disabelAttr forState:(UIControlStateDisabled)];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        
        // 在弹出下一级控制器时, 设置下一级控制器的底部tabBar 为隐藏状态
        [viewController setHidesBottomBarWhenPushed:YES];
        
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backAction) Image:@"navigationbar_back" highlightImage:@"navigationbar_back_highlighted"];
        
        
//        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [rightButton setImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
//        [rightButton setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
//        [rightButton addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
//        rightButton.size = rightButton.currentImage.size;
//        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(moreAction) Image:@"navigationbar_more" highlightImage:@"navigationbar_more_highlighted"];
    }
    
    [super pushViewController:viewController animated:animated];
    
}





- (void)backAction {
    
    [self popViewControllerAnimated:YES];
}

- (void)moreAction {

    [self popToRootViewControllerAnimated:YES];
}





@end

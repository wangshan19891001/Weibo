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
        
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//        leftButton.frame = CGRectMake(0, 0, leftButton.currentImage.size.width, leftButton.currentImage.size.height);
        leftButton.size = leftButton.currentImage.size;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        [rightButton addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
//        rightButton.frame = CGRectMake(0, 0, rightButton.currentImage.size.width, rightButton.currentImage.size.height);
        rightButton.size = rightButton.currentImage.size;
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        
        
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

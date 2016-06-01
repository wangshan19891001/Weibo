//
//  UIWindow+Extension.m
//  Weibo
//
//  Created by 王陕 on 16/5/31.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "MainViewController.h"

@implementation UIWindow (Extension)

+ (void)switchRootViewController {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MainViewController *mainVC = [[MainViewController alloc] init];
    window.rootViewController = mainVC;
}

- (void)switchRootViewController {
    
    self.rootViewController = [[MainViewController alloc] init];

}



@end

//
//  AppDelegate.m
//  Weibo
//
//  Created by 王陕 on 16/5/16.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "DiscoverViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "WSNewFeatureViewController.h"
#import "OAuthViewController.h"

#import "AccountTool.h"
#import "Account.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    // 设置窗口的根控制器
//    MainViewController *mainVC = [[MainViewController alloc] init];
//    self.window.rootViewController = mainVC;
//    WSNewFeatureViewController *newFeatureVC = [[WSNewFeatureViewController alloc] init];
//    self.window.rootViewController = newFeatureVC;
//    self.window.rootViewController = [[OAuthViewController alloc] init];
    
//    NSLog(@"Function:%s line:%d", __func__, __LINE__);
    
    
    Account *account = [AccountTool loadAccount];
    
    if (account) {
        
//        MainViewController *mainVC = [[MainViewController alloc] init];
//        self.window.rootViewController = mainVC;
        
        [self.window switchRootViewController];
        
    }else {
    
        self.window.rootViewController = [[OAuthViewController alloc] init];
    }
    
    
   
    
    
    return YES;
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

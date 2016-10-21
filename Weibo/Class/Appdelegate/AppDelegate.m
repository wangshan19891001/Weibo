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

#import "Account.h"

#import <SDWebImageManager.h>

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
    
    
    Account *account = [LocalTools loadAccount];
    
    if (account) { //之前已经登录成功过
        
//        MainViewController *mainVC = [[MainViewController alloc] init];
//        self.window.rootViewController = mainVC;
        
        [self.window switchRootViewController];
        
    }else {
    
        self.window.rootViewController = [[OAuthViewController alloc] init];
    }
    
    return YES;
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    //取消下载
    [manager cancelAll];
    //清除内存中的所有图片
    [manager.imageCache clearMemory];
//    [manager.imageCache clearDisk];
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    //后台暂停状态: 停止一切动画, 定时器, 多媒体,联网操作
    
    //后台运行状态
    //向操作系统申请后台运行的资格, 能维持多久是不确定的
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        //当申请的后台运行时间已经结束(过期), 就会调用这个block
        [application endBackgroundTask:task];
        
        
        
    }];
    
    
    // 在Info.plst中设置后台模式：Required background modes == App plays audio or streams audio/video using AirPlay
    // 搞一个0kb的MP3文件，没有声音
    // 循环播放
    
    // 以前的后台模式只有3种
    // 保持网络连接
    // 多媒体应用
    // VOIP:网络电话
    
    
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

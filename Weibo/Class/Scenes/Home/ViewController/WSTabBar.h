//
//  WSTabBar.h
//  Weibo
//
//  Created by 王陕 on 16/5/26.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSTabBar;

@protocol WSTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(WSTabBar *)tabBar;

@end


@interface WSTabBar : UITabBar

@property (nonatomic, weak) id<WSTabBarDelegate> delegate;

@end

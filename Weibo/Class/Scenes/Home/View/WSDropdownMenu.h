//
//  WSDropdownMenu.h
//  Weibo
//
//  Created by 王陕 on 16/5/25.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropTableVC.h"

@interface WSDropdownMenu : UIView


+ (instancetype)menu;

- (void)showFrom:(UIView *)view;

- (void)hide;

@property (nonatomic, strong) UIView *content;

@property (nonatomic, strong) DropTableVC *dropTVC;

@end

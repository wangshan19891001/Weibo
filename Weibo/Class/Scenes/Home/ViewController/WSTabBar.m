//
//  WSTabBar.m
//  Weibo
//
//  Created by 王陕 on 16/5/26.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "WSTabBar.h"


@interface WSTabBar ()

@property (nonatomic, weak) UIButton *plusBtn;
@end


@implementation WSTabBar

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}

/**
 *  加好按钮点击事件
 */
- (void)plusClick {
    
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    // 设置加号按钮的位置
    self.plusBtn.centerX = self.width / 2;
    self.plusBtn.centerY = self.height / 2;
    
    // 设置其他tabBarButton 的位置和尺寸
    CGFloat tabBarButtonW = self.width / 5;
    NSInteger tabBarItemIndex = 0;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *child in self.subviews) {
        
//        WSLog(@"%@", child);
        
        if ([child isKindOfClass:class]) {
            // 设置宽度
            child.width = tabBarButtonW;
            // 设置位置
            child.x = tabBarItemIndex * tabBarButtonW;
            tabBarItemIndex ++;
        }
        
        if (tabBarItemIndex == 2) {
            tabBarItemIndex ++;
        }
        
        
    }

}




@end

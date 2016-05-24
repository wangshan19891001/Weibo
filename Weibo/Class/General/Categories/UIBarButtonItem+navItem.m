//
//  UIBarButtonItem+navItem.m
//  Weibo
//
//  Created by 王陕 on 16/5/24.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "UIBarButtonItem+navItem.h"

@implementation UIBarButtonItem (navItem)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action Image:(NSString *)image highlightImage:(NSString *)highlightImage {
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    rightButton.size = rightButton.currentImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}


@end

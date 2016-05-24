//
//  UIBarButtonItem+navItem.h
//  Weibo
//
//  Created by 王陕 on 16/5/24.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (navItem)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action Image:(NSString *)image highlightImage:(NSString *)highlightImage;



@end

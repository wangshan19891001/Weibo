//
//  WSSearchBar.m
//  Weibo
//
//  Created by 王陕 on 16/5/24.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "WSSearchBar.h"

@implementation WSSearchBar

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置搜索框
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.placeholder = @"请输入搜索条件";
        self.font = [UIFont systemFontOfSize:15];
        
        
        // 设置左侧放大镜图片
        // UIImageView 通过initWithImage创建的时候, 默认的尺寸就是image的frame
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

+ (instancetype)searchBar {

    return [[self alloc] init];
}







@end

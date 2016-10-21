//
//  LoadMoreFooter.m
//  Weibo
//
//  Created by 王陕 on 16/10/21.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "LoadMoreFooter.h"

@implementation LoadMoreFooter

+ (instancetype)footer {
    return [[NSBundle mainBundle] loadNibNamed:@"LoadMoreFooter" owner:nil options:nil].lastObject;
}

@end

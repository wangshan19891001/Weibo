//
//  User.m
//  Weibo
//
//  Created by 王陕 on 16/6/6.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "User.h"

@implementation User
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;  //self.vip  的判断写在set方法比写在get方法中好, 在set方法中只用计算一次, 在get方法中, 每次调用都需要计算
}


//- (BOOL)isVip
//{
//    return self.mbrank > 2;
//}

@end

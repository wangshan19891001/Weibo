//
//  Status.h
//  Weibo
//
//  Created by 王陕 on 16/6/6.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Status : NSObject


@property (nonatomic, strong) User *user;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *idstr;


@end

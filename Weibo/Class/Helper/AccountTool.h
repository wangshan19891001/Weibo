//
//  AccountTool.h
//  Weibo
//
//  Created by 王陕 on 16/5/30.
//  Copyright © 2016年 王陕. All rights reserved.
//  处理账号相关的操作: 存储账号, 取出账号, 验证账号

#import <Foundation/Foundation.h>

#import "Account.h"

// 业务逻辑: 在程序中要执行的一些逻辑代码

// 模型不能专门写分类, 模型是不能执行业务逻辑的


@interface AccountTool : NSObject
/**
 *  本地保存账号
 *
 *  @param account 账户模型
 */
+ (void)saveAccount:(Account *)account;
/**
 *  取出本地保存的账号
 *
 *  @return 账户模型
 */
+ (Account *)loadAccount;


@end

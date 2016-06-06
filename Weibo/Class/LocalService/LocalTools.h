//
//  LocalTools.h
//  Weibo
//
//  Created by 王陕 on 16/6/3.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Account.h"

@interface LocalTools : NSObject

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

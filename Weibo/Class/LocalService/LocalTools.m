//
//  LocalTools.m
//  Weibo
//
//  Created by 王陕 on 16/6/3.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "LocalTools.h"

@implementation LocalTools
/**
 *  本地保存账号
 *
 *  @param account 账户模型
 */
+ (void)saveAccount:(Account *)account {
    
    
    // 这里不能设置创建时间, 否则在程序中每次保存账户时, 都会将新的创建时间保存, 这样创建时间永远不会过期, 所以, 保存创建时间应该放在Account.m 中,第一次用来接收系统返回Model的时候
    //    account.create_time = [NSDate date];
    // 获取沙盒路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"account.archive"];
    [NSKeyedArchiver archiveRootObject:account toFile:filePath];
}

/**
 *  取出本地保存的账号
 *
 *  @return 账户模型
 */
+ (Account *)loadAccount {
    
    // 获取沙盒路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"account.archive"];
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    // 获得过期时间
    NSDate *expires_time = [account.create_time dateByAddingTimeInterval:expires_in];
    
    // 获得当前时间
    NSDate *now_time = [NSDate date];
    
//    NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
    
    NSComparisonResult result = [now_time compare:expires_time];
    if (result == NSOrderedDescending && result == NSOrderedSame) {
        return nil;
    }
    
    return account;
}



@end

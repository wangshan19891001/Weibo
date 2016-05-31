//
//  AccountTool.m
//  Weibo
//
//  Created by 王陕 on 16/5/30.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "AccountTool.h"
#import "Account.h"

@implementation AccountTool

+ (void)saveAccount:(Account *)account {
    
    
    // 获取账号的存储时间
    account.create_time = [NSDate date];
    
    // 获取沙盒路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"account.archive"];
    [NSKeyedArchiver archiveRootObject:account toFile:filePath];
}

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

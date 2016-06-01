//
//  Account.m
//  Weibo
//
//  Created by 王陕 on 16/5/27.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    
    Account *account = [[self alloc] init];
    account.access_token = [dict valueForKey:@"access_token"];
    account.expires_in = [dict valueForKey:@"expires_in"];
    account.uid = [dict valueForKey:@"uid"];
    // 获取账号的存储时间
    account.create_time = [NSDate date];
    return account;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.create_time forKey:@"create_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.create_time = [aDecoder decodeObjectForKey:@"create_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}


@end

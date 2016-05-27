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
    return account;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder setValue:self.access_token forKey:@"access_token"];
    [aCoder setValue:self.expires_in forKey:@"expires_in"];
    [aCoder setValue:self.uid forKey:@"uid"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        
        self.access_token = [aDecoder valueForKey:@"access_token"];
        self.expires_in = [aDecoder valueForKey:@"expires_in"];
        self.uid = [aDecoder valueForKey:@"uid"];
    }
    return self;
}


@end

//
//  Account.h
//  Weibo
//
//  Created by 王陕 on 16/5/27.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>


@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *expires_in;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, strong) NSDate *create_time;
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary*)dict;

@end

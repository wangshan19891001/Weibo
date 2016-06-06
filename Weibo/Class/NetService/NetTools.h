//
//  NetTools.h
//  Weibo
//
//  Created by 王陕 on 16/6/3.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Account.h"

@class StatusReq;
@class UserInfoReq;

@interface NetTools : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

/**
 *  单例
 *
 */
+ (NetTools *)sharedManager;



/**
 *  请求用户信息
 *
 */
- (void)loadUserInfo:(UserInfoReq *)request success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  加载微博数据
 *
 */
- (void)loadStatus:(StatusReq *)request success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;




@end

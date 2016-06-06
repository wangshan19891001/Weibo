//
//  NetTools.m
//  Weibo
//
//  Created by 王陕 on 16/6/3.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "NetTools.h"

#import "UserInfoReq.h"
#import "StatusReq.h"

@implementation NetTools

/**
 *  单例
 *
 */
+ (NetTools *)sharedManager {
    static NetTools *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[NetTools alloc] init];
    });
    return handle;
}
- (instancetype)init {
    @synchronized (self) {
        self.manager = [AFHTTPSessionManager manager];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.requestSerializer.timeoutInterval = 15;
    }
    return self;
}


/**
 *  请求用户信息
 *
 */
- (void)loadUserInfo:(UserInfoReq *)request success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    [[AFHTTPSessionManager manager] GET:url parameters:[request mj_keyValues] progress:nil success:success failure:failure];
}


/**
 *  请求微博数据
 *
 */
- (void)loadStatus:(StatusReq *)request success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    [[AFHTTPSessionManager manager] GET:url parameters:[request mj_keyValues] progress:nil success:success failure:failure];
}








@end

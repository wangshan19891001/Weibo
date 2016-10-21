//
//  StatusReq.h
//  Weibo
//
//  Created by 王陕 on 16/6/6.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusReq : NSObject

/**
 *  OAuth 授权后的令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  单页返回微博的数目  默认20, 最大不超过100
 */
@property (nonatomic, strong) NSNumber *count;
/**
 *  当前数组中since_id最大的
 */
@property (nonatomic, copy) NSString *since_id;

@property (nonatomic, strong) NSNumber *max_id;
@end

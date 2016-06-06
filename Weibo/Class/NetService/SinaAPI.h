//
//  SinaAPI.h
//  Weibo
//
//  Created by 王陕 on 16/6/3.
//  Copyright © 2016年 王陕. All rights reserved.
//

#ifndef SinaAPI_h
#define SinaAPI_h

#define Sina_api @"https://api.weibo.com"



/**
 *  授权接口
 */
#define Sina_api_oauth2 [Sina_api stringByAppendingString:@"/oauth2"]
#define Sina_api_authorize [Sina_api_oauth2 stringByAppendingString:@"/authorize"]

/**
 *  用户接口
 */
#define Sina_api_users_show @"https://api.weibo.com/2/users/show.json"



#endif /* SinaAPI_h */

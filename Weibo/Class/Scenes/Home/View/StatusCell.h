//
//  StatusCell.h
//  Weibo
//
//  Created by 王陕 on 16/10/25.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;

@interface StatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) StatusFrame *statusFrame;

@end

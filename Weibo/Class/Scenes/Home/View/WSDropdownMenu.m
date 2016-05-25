//
//  WSDropdownMenu.m
//  Weibo
//
//  Created by 王陕 on 16/5/25.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "WSDropdownMenu.h"

@interface WSDropdownMenu ()

@property (nonatomic, strong) UIImageView *containerView;

@end


@implementation WSDropdownMenu

- (UIImageView *)containerView {

    if (!_containerView) {
        _containerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popover_background"]];
        _containerView.width = 217;
        _containerView.height = 217;
        _containerView.userInteractionEnabled = YES;
        [self addSubview:_containerView];
    }
    return _containerView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



+ (instancetype)menu {
    
    return [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
}


- (void)setContent:(UIView *)content {

    _content = content;
    
    content.x = 10;
    content.y = 15;
    
    content.width = self.containerView.width - 20;
    
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    
    [self.containerView addSubview:content];
}

- (void)setDropTVC:(DropTableVC *)dropTVC {

    _dropTVC = dropTVC;
    self.content = dropTVC.view;
}



- (void)showFrom:(UIView *)view {
    
    // 获取最上层的window
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    
    [window addSubview:self];
    
    
    
    
    // 转换坐标系
    // 默认情况下, frame是以父控件左上角为坐标原点的
    CGRect newFrame = [view convertRect:view.frame toView:window];
//    NSLog(@"%f", CGRectGetMidX(newFrame));
    self.containerView.centerX = CGRectGetMidX(newFrame) - 120;
    self.containerView.y = CGRectGetMaxY(newFrame);
    
}


// 隐藏
- (void)hide {
    [self removeFromSuperview];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self hide];
}

















@end

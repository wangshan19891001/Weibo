//
//  TitleButton.m
//  Weibo
//
//  Created by 王陕 on 16/6/2.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor grayColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = self.titleLabel.font;
//    CGFloat titleW = [self.currentTitle sizeWithAttributes:attrs].width;
    
    self.titleLabel.x = 0;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self sizeToFit];
}



@end

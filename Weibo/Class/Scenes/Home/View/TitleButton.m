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


//所有修改frame的方法, 最终都会调用setFrame 方法 (想在系统计算和设置完按钮的尺寸后, 在修改一下尺寸)
- (void)setFrame:(CGRect)frame {
    
    NSLog(@"++++++++%@", NSStringFromCGRect(frame));
    frame.size.width += 10;
    
    //将外部传入的frame进行修改后, 在传入系统的设置frame
    [super setFrame:frame];
    
    
}








- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //如果仅仅是调整按钮内部titleLabel 和 imageView 的位置, 那么在layoutSubviews中单独设置位置即可
    
    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = self.titleLabel.font;
//    CGFloat titleW = [self.currentTitle sizeWithAttributes:attrs].width;
    
    self.titleLabel.x = 0;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 10;
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit]; //内容有多少, 按钮的尺寸就有多少, 每次设置title的时候都会进行尺寸的设置
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self sizeToFit];
}



@end

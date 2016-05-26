//
//  WSNewFeatureViewController.m
//  Weibo
//
//  Created by 王陕 on 16/5/26.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "WSNewFeatureViewController.h"

#define NewFeatureCount 4

@interface WSNewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation WSNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:kScreen];
    scrollView.contentSize = CGSizeMake(4 * kScreenWidth, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < 4; i++) {
        
        NSString *image = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
        imageView.x = scrollW * i;
        imageView.y = 0;
        imageView.width = scrollW;
        imageView.height = scrollH;
        [scrollView addSubview:imageView];
        
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewFeatureCount;
    pageControl.currentPageIndicatorTintColor = Color(253, 98, 42);
    pageControl.pageIndicatorTintColor = Color(189, 189, 189);
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    
    
    
}

#pragma mark - scrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 设置当前
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);   // 四舍五入
    
}









@end

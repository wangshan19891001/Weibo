//
//  test1ViewController.m
//  Weibo
//
//  Created by 王陕 on 16/5/17.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "test1ViewController.h"

@interface test1ViewController ()

@end

@implementation test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0, 0, leftButton.currentImage.size.width, leftButton.currentImage.size.height);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    
}

- (void)backAction {

    [self.navigationController popViewControllerAnimated:YES];
}



@end

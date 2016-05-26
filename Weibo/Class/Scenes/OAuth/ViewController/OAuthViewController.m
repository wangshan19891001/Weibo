//
//  OAuthViewController.m
//  Weibo
//
//  Created by 王陕 on 16/5/26.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "OAuthViewController.h"

@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1506295948&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    
}

#pragma mark - webView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"网页加载完成");
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载网页");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"%@", request.URL.absoluteString);
    return YES;
}


@end

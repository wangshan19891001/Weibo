//
//  OAuthViewController.m
//  Weibo
//
//  Created by 王陕 on 16/5/26.
//  Copyright © 2016年 王陕. All rights reserved.
//

#import "OAuthViewController.h"
#import "MainViewController.h"

#import "Account.h"

@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSString *urlString = [Sina_api_authorize stringByAppendingString:@"?client_id=1506295948&redirect_uri=http://www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [webView loadRequest:request];
    
}

#pragma mark - webView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"网页加载完成");
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载网页");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [MBProgressHUD hideHUDForView:webView animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
//    NSLog(@"%@", request.URL.absoluteString);
    
    
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        
        // 截取"code="后面的参数
        NSInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
//        NSLog(@"code = %@", code);
        
        // 利用code 换一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    
    
    return YES;
}


/**
 *  利用code (授权成功后的request token) 换取一个accessToken
 *
 *  @param code 授权成功后的request Token
 */
- (void)accessTokenWithCode:(NSString *)code {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"1506295948" forKey:@"client_id"];
    [param setValue:@"e1f879c7ca9c733c54ca7f969ee04b70" forKey:@"client_secret"];
    [param setValue:@"authorization_code" forKey:@"grant_type"];
    [param setValue:@"http://www.baidu.com" forKey:@"redirect_uri"];
    [param setValue:code forKey:@"code"];
    
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        NSLog(@"请求成功responseObject:%@", responseObject);
        
        /* 存储账号信息 */
        // 字典转模型
        Account *account = [Account accountWithDict:responseObject];
        // 本地存储数据
        [LocalTools saveAccount:account];
        
        // 如果是字典类型, 则可以直接通过writeToFile: 方法直接存储到本地
//        [responseObject writeToFile:filePath atomically:YES];
        
//        MainViewController *mainVC = [[MainViewController alloc] init];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        window.rootViewController = mainVC;
        [window switchRootViewController];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败error+++++ %@", error);
    }];
    
    
    
}



@end

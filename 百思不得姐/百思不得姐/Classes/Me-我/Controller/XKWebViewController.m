//
//  XKWebViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/7.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKWebViewController.h"
#import "XKSquare.h"

@interface XKWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bacItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation XKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.square.url]]];
    self.title = self.square.name;
    self.webView.backgroundColor = XKCommonBgColor;
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.webView.scalesPageToFit = YES;
}

- (IBAction)back:(id)sender {
    [self.webView goBack];
}

- (IBAction)forward:(id)sender {
    [self.webView goForward];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.bacItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}
@end

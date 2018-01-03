//
//  MXWebViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXWebViewController.h"
#import <WebKit/WebKit.h>

@interface MXWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic)WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation MXWebViewController

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _webView.frame = self.contentView.frame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc]init];
    [self.contentView addSubview:webView];
    NSLog(@"%@",self.url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [webView loadRequest:request];
    _webView = webView;
    
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    self.title = self.webView.title;
    self.back.enabled = self.webView.canGoBack;
    self.forward.enabled = self.webView.canGoForward;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (IBAction)backClick:(id)sender {
    [self.webView goBack];
}

- (IBAction)forwardClick:(id)sender {
    [self.webView goForward];
}

- (IBAction)reFreshClick:(id)sender {
    [self.webView reload];
}

@end

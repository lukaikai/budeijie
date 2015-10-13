//
//  XKAdViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/10/10.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKAdViewController.h"
#import <AFNetworking.h>
@interface XKAdViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *adImageView;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation XKAdViewController
#pragma mark - lazy
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"demo"] = @1;
    params[@"entrytype"] = @1;
    
    [self.manager GET:@"http://sprite.spriteapp.com/ad/get.php" parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        
//        XKWriteToPlist(responseObject[@"return"], @"ad");
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
    }];
}

- (IBAction)passBtn
{
    self.view.window.hidden = YES;
}

@end

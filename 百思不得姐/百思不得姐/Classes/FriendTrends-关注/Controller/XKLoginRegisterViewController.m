//
//  XKLoginRegisterViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/3.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//  登录页面

#import "XKLoginRegisterViewController.h"
#import "XKLoginRegisterTextField.h"

@interface XKLoginRegisterViewController ()
// 登录界面 左边约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;
@property (weak, nonatomic) IBOutlet XKLoginRegisterTextField *nameTextField;
@property (weak, nonatomic) IBOutlet XKLoginRegisterTextField *pwdTextField;

@end

@implementation XKLoginRegisterViewController

- (IBAction)login
{
    NSString *name = self.nameTextField.text;
    NSString *pwd = self.pwdTextField.text;
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef removeObjectForKey:@"name"];
    [userDef removeObjectForKey:@"pwd"];
    [userDef setObject:name forKey:@"name"];
    [userDef setObject:pwd forKey:@"pwd"];
    [userDef synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
/**
 *  关闭
 */
- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// iOS7之前修改状态栏样式
// [UIApplication sharedApplication].statusBarStyle;
// iOS7开始由控制器来修改状态栏样式
/**
 * 让状态栏样式为白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/**
 *  退出键盘
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
/**
 *  修改约束 切换至注册界面
 */
- (IBAction)loginOrRegister:(UIButton *)sender
{
    // 修改约束
    if (self.leftSpace.constant == 0) {
        self.leftSpace.constant = - self.view.width;
        sender.selected = YES;
    }else{
        self.leftSpace.constant = 0;
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view layoutIfNeeded];
    }];
}
@end

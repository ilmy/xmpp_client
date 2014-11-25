//
//  MainViewController.m
//  xmpp_client
//
//  Created by 李明杨 on 14-11-20.
//  Copyright (c) 2014年 李明杨. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AppHUD getInstance] showLoading:@"正在连接服务器...." withViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onGetonlineListAction:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app queryRoster];
}

-(void)setConnectResult:(BOOL)status
{
    if (status) {
        [[AppHUD getInstance] showMessage:@"服务器连接成功" withViewController:self];
      LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self.navigationController pushViewController:loginController animated:YES];
    }
    else
    {
        [[AppHUD getInstance] showMessage:@"服务器连接失败" withViewController:self.navigationController.visibleViewController];
    }
}
-(void)setuserLabel:(NSString *)userLabel
{
    _userLabel.text = userLabel;
}
-(void)setLoginResult:(BOOL)status
{
    if (status) {
        [[AppHUD getInstance] showMessage:@"登陆成功" withViewController:self];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        
        [[AppHUD getInstance] showMessage:@"登陆失败" withViewController:self.navigationController.visibleViewController];
    }

}

-(void)setRegisterResult:(BOOL)status
{
    if (status) {
        [[AppHUD getInstance] showMessage:@"注册成功" withViewController:self];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        
        [[AppHUD getInstance] showMessage:@"注册失败" withViewController:self.navigationController.visibleViewController];
    }
}

@end

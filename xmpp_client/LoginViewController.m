//
//  ViewController.m
//  xmpp_client
//
//  Created by 李明杨 on 14-11-20.
//  Copyright (c) 2014年 李明杨. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.userName.text = @"asdf";
   
}

- (IBAction)signBtnAction:(id)sender{
    if(self.userName.text!=nil&&self.passWord.text!=nil)
    {
        [self appDelegate].isLogined = YES;
        [[self appDelegate] connect:self.userName.text withpassword:self.passWord.text];
       
        [[AppHUD getInstance] showLoading:@"正在登陆..." withViewController:self];
       
    }
    
    
}
-(void)setLoginResult:(BOOL)status
{
    
    if(status)
    {
    
    }
    else
    {
        [[AppHUD getInstance] showMessage:@"用户名密码错误" withViewController:self];
    }
    
}
- (IBAction)registerBtnAction:(id)sender {
    UIViewController *registerController= [self.storyboard instantiateViewControllerWithIdentifier:@"registerViewController"];
    [self.navigationController pushViewController:registerController animated:YES];
}

-(AppDelegate*)appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

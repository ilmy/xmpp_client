//
//  MainViewController.h
//  xmpp_client
//
//  Created by 李明杨 on 14-11-20.
//  Copyright (c) 2014年 李明杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppHUD.h"
#import "LoginViewController.h"
@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

- (IBAction)onGetonlineListAction:(id)sender;
-(void)setConnectResult:(BOOL)status;
-(void)setLoginResult:(BOOL)status;
-(void)setRegisterResult:(BOOL)status;
-(void)setuserLabel:(NSString *)userLabel;
@end

//
//  ViewController.h
//  xmpp_client
//
//  Created by 李明杨 on 14-11-20.
//  Copyright (c) 2014年 李明杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AppHUD.h"
@class RegisterViewController;

@interface LoginViewController : UIViewController<MBProgressHUDDelegate>
{
}
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)signBtnAction:(id)sender;
- (IBAction)registerBtnAction:(id)sender;

@end


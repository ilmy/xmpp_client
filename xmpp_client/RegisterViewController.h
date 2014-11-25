//
//  RegisterViewController.h
//  xmpp_client
//
//  Created by 李明杨 on 14-11-22.
//  Copyright (c) 2014年 李明杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AppHUD.h"

@interface RegisterViewController : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)registerBtnAction:(id)sender;

@end

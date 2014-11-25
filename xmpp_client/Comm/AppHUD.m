//
//  AppHUD.m
//  xmpp_client
//
//  Created by 李明杨 on 14-11-24.
//  Copyright (c) 2014年 李明杨. All rights reserved.
//

#import "AppHUD.h"

@implementation AppHUD

+(AppHUD*)getInstance
{
    static AppHUD *appHUD;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appHUD = [[AppHUD alloc] init];
        
    });
    return appHUD;
}
- (void)showMessageTitle:(NSString*)str withDetail:(NSString*)detail withViewController:(UIViewController *)viewController
{
    [_HUD hide:YES];
    _HUD = [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];//[[MBProgressHUD alloc] initWithView:viewController.view];
   // [viewController.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeText;
    _HUD.labelText = str;
    _HUD.margin = 10.f;
    _HUD.detailsLabelText = detail;
    _HUD.removeFromSuperViewOnHide = YES;
    //[_HUD show:YES];
    [_HUD hide:YES afterDelay:2];
    
    
    
    
    // Configure for text only and offset down
    //hud.removeFromSuperViewOnHide = YES;
    
}
- (void)showMessage:(NSString*)str withViewController:(UIViewController *)viewController
{
    [_HUD hide:YES];
    _HUD = [[MBProgressHUD alloc] initWithView:viewController.view];
    [viewController.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeText;
    _HUD.delegate = viewController;
    _HUD.labelText = str;
    [_HUD show:YES];
    [_HUD hide:YES afterDelay:2];
    
    
    
    
    // Configure for text only and offset down
    //hud.removeFromSuperViewOnHide = YES;
    
}

- (void)showMessageForCustom:(NSString*)str withViewController:(UIViewController *)viewController
{
    [_HUD hide:YES];
    _HUD = [[MBProgressHUD alloc] initWithView:viewController.view];
    [viewController.view addSubview:_HUD];
    _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.delegate = viewController;
    _HUD.labelText = str;
    [_HUD show:YES];
    [_HUD hide:YES afterDelay:2];
}
-(void)showLoading:(NSString*)str withViewController:(UIViewController *)viewController
{
    [_HUD hide:YES];
    _HUD = [[MBProgressHUD alloc] initWithView:viewController.view];
    [viewController.view addSubview:_HUD];
    _HUD.delegate = self;
    _HUD.labelText = str;
    [_HUD show:YES];
}

@end

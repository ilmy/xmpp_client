//
//  AppHUD.h
//  xmpp_client
//
//  Created by 李明杨 on 14-11-24.
//  Copyright (c) 2014年 李明杨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface AppHUD : NSObject
{
    
}
@property (strong,nonatomic) MBProgressHUD *HUD;
+(AppHUD*)getInstance;
- (void)showMessage:(NSString*)str withViewController:(UIViewController *)viewController;
-(void)showLoading:(NSString*)str withViewController:(UIViewController *)viewController;
- (void)showMessageForCustom:(NSString*)str withViewController:(UIViewController *)viewController;
- (void)showMessageTitle:(NSString*)str withDetail:(NSString*)detail withViewController:(UIViewController *)viewController;

@end

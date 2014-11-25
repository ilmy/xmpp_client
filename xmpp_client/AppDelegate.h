//
//  AppDelegate.h
//  xmpp_client
//
//  Created by 李明杨 on 14-11-20.
//  Copyright (c) 2014年 李明杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"
#import "MainViewController.h"
#import <FlexManager.h>
#define APP_DELEGATE(){[[UIApplication sharedApplication] delegate]}

@interface AppDelegate : UIResponder <UIApplicationDelegate,XMPPRosterDelegate>
{
    BOOL customCertEvaluation;
    BOOL isXmppConnected;
   
    NSString *password;
}

@property (nonatomic, strong, readonly) XMPPStream *xmppStream;
@property (nonatomic, strong, readonly) XMPPReconnect *xmppReconnect;
@property (nonatomic, strong, readonly) XMPPRoster *xmppRoster;
@property (nonatomic, strong, readonly) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong, readonly) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic, strong, readonly) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic, strong, readonly) XMPPCapabilities *xmppCapabilities;
@property (nonatomic, strong, readonly) XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;
@property (nonatomic, strong, readonly) XMPPvCardCoreDataStorage *xmppvCardStorage;
@property (strong,nonatomic) UINavigationController *navigateionController;
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) MainViewController *mainController;
@property (assign,nonatomic) BOOL isLogined;
//连接
- (BOOL)connect;
- (BOOL)connect:(NSString*)user withpassword:(NSString*)pwd;
//释放连接
- (void)disconnect;
//注册
-(BOOL)registerUser:(NSString*)user withpassword:(NSString*)pwd;
//上线
- (void)goOnline;
//离线
- (void)goOffline;
- (void)queryRoster;
@end


//
//  AppDelegate.m
//  xmpp_client
//
//  Created by 李明杨 on 14-11-20.
//  Copyright (c) 2014年 李明杨. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
NSString *const kXMPPmyJID = @"kXMPPmyJID";
NSString *const kXMPPmyPassword = @"kXMPPmyPassword";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     [self setupStream];
   
    
    
   _mainController = (MainViewController*)self.window.rootViewController;


    [self connect];
    _navigateionController = [[UINavigationController alloc] initWithRootViewController:_mainController];
    _navigateionController.navigationBarHidden = YES;
    self.window.rootViewController = _navigateionController;
    
     [_window makeKeyAndVisible];
#ifdef DEBUG
    [[FLEXManager sharedManager] showExplorer];
#endif
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark ---- XMPPFramework配置
- (void)setupStream
{
    
    _xmppStream = [[XMPPStream alloc] init];
    
#if !TARGET_IPHONE_SIMULATOR
    {
        
        _xmppStream.enableBackgroundingOnSocket = YES;
    }
#endif
    
    
    _xmppReconnect = [[XMPPReconnect alloc] init];
    
    
    _xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    
    _xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:_xmppRosterStorage];
    
    _xmppRoster.autoFetchRoster = YES;
    _xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;

    
    _xmppvCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _xmppvCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:_xmppvCardStorage];
    
    _xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_xmppvCardTempModule];
    
    
    _xmppCapabilitiesStorage = [XMPPCapabilitiesCoreDataStorage sharedInstance];
    _xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:_xmppCapabilitiesStorage];
    
    _xmppCapabilities.autoFetchHashedCapabilities = YES;
    _xmppCapabilities.autoFetchNonHashedCapabilities = NO;
    
    // Activate xmpp modules
    
    [_xmppReconnect         activate:_xmppStream];
    [_xmppRoster            activate:_xmppStream];
    [_xmppvCardTempModule   activate:_xmppStream];
    [_xmppvCardAvatarModule activate:_xmppStream];
    [_xmppCapabilities      activate:_xmppStream];
    
    // Add ourself as a delegate to anything we may be interested in
    
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [_xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    
    [_xmppStream setHostName:@"127.0.0.1"];
    [_xmppStream setHostPort:5222];
    
    customCertEvaluation = YES;
}
#pragma mark ---- xmpp事件
///连接成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"连接成功");
    [_mainController setConnectResult:YES];
    isXmppConnected = YES;
    if(_isLogined){
        NSError *error = nil;
        if (![[self xmppStream] authenticateWithPassword:password error:&error])
        {
            NSLog(@"Error authenticating: %@", error);
        }
    }
}
///连接失败
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"连接断开");
    [_mainController setConnectResult:NO];
    
    if (!isXmppConnected)
    {
        //DDLogError(@"Unable to connect to server. Check xmppStream.hostName");
    }
}
///登陆成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    
    NSLog(@"登陆成功");
    [_mainController setLoginResult:YES];
    NSString *_tempuser = sender.myJID.user;
    [_mainController setuserLabel:_tempuser];
    [self goOnline];
}
///登陆失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    [_mainController setLoginResult:NO];
    NSLog(@"登陆失败");
}
- (void)xmppStream:(XMPPStream *)sender didReceiveError:(id)error
{
    NSLog(@"阿萨德发的");
}
///注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    
    [[NSUserDefaults standardUserDefaults] setObject:sender.myJID.user forKey:kXMPPmyJID];
    [_mainController setuserLabel:sender.myJID.user];
    [_navigateionController popToRootViewControllerAnimated:YES];
    [_mainController setRegisterResult:YES];
    NSLog(@"账户注册成功");
    [self goOnline];
}
///注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error
{
   [_mainController setRegisterResult:NO];
    NSLog(@"账户注册失败");
    NSLog(@"%@",error);
}
///上线成功
- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    NSLog(@"%@",iq);
    NSLog(@"上线成功");
    return YES;
}
///获取好友状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    NSString *presenceType = [presence type];
    NSString *userId = [[sender myJID] user];
    NSString *presenceFromUser = [[presence from] user];
    

}

- (void)queryRoster {
    NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    XMPPJID *myJID = self.xmppStream.myJID;
    [iq addAttributeWithName:@"from" stringValue:_xmppStream.hostName];
    [iq addAttributeWithName:@"to" stringValue:myJID.domain];
    [iq addAttributeWithName:@"id" stringValue:@"123456"];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addChild:query];
    [self.xmppStream sendElement:iq];
}
///接收消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSString *messageBody = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    NSString *fromname = [from isEqualToString:_xmppStream.hostName]?@"服务器":from;
    fromname = [NSString stringWithFormat:@"来至 %@ 的消息",fromname];
    NSString *str = [NSString stringWithFormat:@"%@",messageBody];
    [[AppHUD getInstance] showMessageTitle:str withDetail:fromname withViewController:_mainController];
    
    
    
    NSLog(@"接收消息:%@",message);
}

- (BOOL)connect
{
   return [self connect:[[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyJID] withpassword:[[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyPassword]] ;
}
- (BOOL)connect:(NSString*)user withpassword:(NSString*)pwd
{  if (user != nil) {
    user = [NSString stringWithFormat:@"%@@%@",user,_xmppStream.hostName];
    }
    if (![_xmppStream isDisconnected]) {
        if(_isLogined){
            NSError *error = nil;
            password=pwd;
            [[self xmppStream] setMyJID:[XMPPJID jidWithString:user]];
            if (![[self xmppStream] authenticateWithPassword:password error:&error])
            {
                NSLog(@"Error authenticating: %@", error);
            }
        }
        return YES;
    }
    NSString *myJID = user;
    NSString *myPassword = pwd;
        if ( myPassword != nil) {
        password = myPassword;
    }
    if (myJID != nil) {
    
        [_xmppStream setMyJID:[XMPPJID jidWithString:myJID]];
    }else{
        [_xmppStream setMyJID:[XMPPJID jidWithString:@"a"]];
    }
    NSError *error = nil;
    [_xmppStream connectWithTimeout:10 error:&error];
    if(error)
    {
        NSLog(@"连接失败%@",error);
    }
    
    return YES;
}
-(BOOL)registerUser:(NSString*)user withpassword:(NSString*)pwd
{
    
    user = [NSString stringWithFormat:@"%@@%@",user,_xmppStream.hostName];
    if (![_xmppStream isConnected])
    {
        [self connect:user withpassword:nil];
    }
    [_xmppStream setMyJID:[XMPPJID jidWithString:user]];
    NSError *err;
    if([_xmppStream registerWithPassword:pwd error:&err])
    {return YES;}
    else{return NO;}
    
}

- (void)disconnect
{
    [self goOffline];
    [_xmppStream disconnect];
}
- (void)goOffline
{
    NSLog(@"准备下线");
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
}
- (void)goOnline
{
        NSLog(@"准备上线");
    	XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
        [[self xmppStream] sendElement:presence];
}


@end

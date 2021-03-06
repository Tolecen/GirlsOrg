//
//  GSAppDelegate.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/11/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSAppDelegate.h"
#import "GSHomeVC.h"
#import "GSSearchVC.h"
#import "GSProfileVC.h"
#import "GSPublishVC.h"
#import "GSTabBarController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "GSLogInViewController.h"
static const NSUInteger kTabBarDefaultHeight = 45.f;

@implementation GSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    [[UINavigationBar appearance] setBarTintColor:RGBCOLOR(250, 89, 172, 1)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [SMS_SDK registerApp:@"4e94befa71df" withSecret:@"085a86819aba85e8acc4492441c6ac74"];
    [MagicalRecord setupCoreDataStack];
    
    [self getQiuniuUploadToken];

    GSTabBarController *tabBarController = [[GSTabBarController alloc] initWithTabBarHeight:kTabBarDefaultHeight];
    tabBarController.minimumHeightToDisplayTitle = 40.f;
    GSHomeVC *homeVC = [[GSHomeVC alloc] init];
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController *searchNavi = [[UINavigationController alloc] initWithRootViewController:[[GSSearchVC alloc] init]];
    UINavigationController *profileNavi = [[UINavigationController alloc] initWithRootViewController:[[GSProfileVC alloc] init]];
    [tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                          homeNavi,
                                          searchNavi,
                                          profileNavi,
                                          [[GSPublishVC alloc] init],nil]];
    self.window.rootViewController = tabBarController;    
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)getQiuniuUploadToken
{
    [GSNetWorkManager getUploadToken];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (GSAppDelegate *)shareInstance
{
    return (GSAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)login:(id)obj selector:(SEL)selector{
    if ([GSUserInfo isLogin] && _doLoginViewController && _loginSel &&
        [_doLoginViewController respondsToSelector:_loginSel]) {
        [_doLoginViewController performSelector:_loginSel withObject:nil];
        return;
    }
    _loginSel = selector;
    _doLoginViewController = obj;
    
    GSLogInViewController * loginV = [[GSLogInViewController alloc] init];
    UINavigationController * logNavi = [[UINavigationController alloc] initWithRootViewController:loginV];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:logNavi animated:YES completion:nil];

}

@end

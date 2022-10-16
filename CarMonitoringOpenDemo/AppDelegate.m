//
//  AppDelegate.m
//  CarMonitoringOpenDemo
//
//  Created by 王恒 on 2022/10/12.
//

#import "AppDelegate.h"
#if __has_include(<AWHBGaudeMapBus/AWHBGaudeMapBus.h>)
#import <AWHBGaudeMapBus/AWHBGMRuntime.h>
#endif
#import <AWHBPublicBusiness/AWHBPBConfig.h>

#import <UMCommon/UMCommon.h>
#import<UMShare/UMShare.h>
#import <AWHBoneRuntime/AWHBoneRuntime.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AWHBPBConfig setup];
#if __has_include(<AWHBGaudeMapBus/AWHBGaudeMapBus.h>)
    [AWHBGMRuntime application:application didFinishLaunchingWithOptions:launchOptions mapServicesApiKey:@"******"];
    [UMConfigure initWithAppkey:@"60fbd85317313b21b4531111" channel:@"App Store"];
#endif
    [self confitUShareSettings];
    [self configUSharePlatforms];
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    return [AWHBRTools getInterfaceOrientationMask];
}

-(void)confitUShareSettings
{
    // 微信、QQ、微博完整版会校验合法的universalLink，不设置会在初始化平台失败
       //配置微信Universal Link需注意 universalLinkDic的key是rawInt类型，不是枚举类型 ，即为 UMSocialPlatformType.wechatSession.rawInt
    [UMSocialGlobal shareInstance].universalLinkDic =@{@(UMSocialPlatformType_WechatSession):@"****"};
    
}
-(void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"***" appSecret:@"***" redirectURL:@"***"];
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end

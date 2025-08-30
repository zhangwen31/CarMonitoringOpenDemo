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
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AWHBPBConfig setup];
#if __has_include(<AWHBGaudeMapBus/AWHBGaudeMapBus.h>)
//    NSString *apiKey = @"******"; //无效
    NSString *apiKey = @"123456"; //无效 需要去高德地图注册 https://lbs.amap.com/api/ios-navi-sdk/guide/create-project/foundation-sdk
    [AWHBGMRuntime application:application didFinishLaunchingWithOptions:launchOptions mapServicesApiKey:apiKey];
    [UMConfigure initWithAppkey:@"60fbd85317313b21b4531111" channel:@"App Store"];
#endif
    [self confitUShareSettings];
    [self configUSharePlatforms];
    
    // 1. 初始化窗口
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
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



@end

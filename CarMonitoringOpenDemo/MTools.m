//
//  MTools.m
//  CarMonitoringOpenDemo
//
//  Created by 王恒 on 2022/10/13.
//

#import "MTools.h"
#import <UMShare/UMShare.h>
#import <AWHBBasicBusiness/UIViewController+AWHBB.h>
#import <AWHBoneResources/AWHBoneResources.h>

@implementation MTools

+ (void)load
{
#if __has_include(<AWHBGaudeMapBus/AWHBGaudeMapBus.h>)

    [AWHBRService registerProtocol:@protocol(AWHBRShareProtocol) handler:[MTools shareInstancet]];
    
#endif
    
}

+ (instancetype)shareInstancet
{
    static MTools *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[MTools alloc] init];
    });
    return m;
}

/** 分享三方应用  需要接入方自己实现该功能
 * @param title 标题
 * @param desc 描述
 * @param url 分享链接
 *
 */
- (void)shareTitle:(NSString *)title desc:(NSString *)desc url:(NSString *)url
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:[AWHBRSUtilities imageNamed:@"云查车"]];
    shareObject.webpageUrl = url;
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:nil  completion:^(id result, NSError *error) {
        if (error) {
            [[AWHBRTools getCurrentVC] showHint:AWHBRLocalizedString(@"分享失败")];
        } else {
            [[AWHBRTools getCurrentVC] showHint:AWHBRLocalizedString(@"分享成功")];
        }
    }];
}

- (void)shareMessageText:(NSString *)text { 
    //创建分享消息对象
    UMSocialMessageObject*messageObject =[UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = text;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:nil completion:^(id data,NSError*error){
        if (error) {
            [[AWHBRTools getCurrentVC] showHint:AWHBRLocalizedString(@"分享失败")];
        } else {
            [[AWHBRTools getCurrentVC] showHint:AWHBRLocalizedString(@"分享成功")];
        }
    }];
}


@end

//
//  AllHeaderCollectionReusableView.m
//  CarMonitoring
//
//  Created by 潘振 on 2018/7/15.
//  Copyright © 2018年 潘振. All rights reserved.
//

#import "AllHeaderCollectionReusableView.h"
#import <Masonry/Masonry.h>
#import <AWHBoneRuntime/AWHBoneRuntime.h>
#import <AWHBBasicBusiness/AWHBBasicBusiness.h>

@implementation AllHeaderCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imageView = [AWHBBControl createImageViewFrame:CGRectZero imageName:@""];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(scaleFrom750(10));
            make.centerY.equalTo(self.mas_centerY);
        }];
        self.label = [AWHBBControl createLabelWithFrame:CGRectZero Font:scaleFrom750(30) Text:@"" Color:@"333333"];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.imageView.mas_centerY);
            make.left.equalTo(self.imageView.mas_right).offset(scaleFrom720(5));
        }];
    }
    return self;
}
@end

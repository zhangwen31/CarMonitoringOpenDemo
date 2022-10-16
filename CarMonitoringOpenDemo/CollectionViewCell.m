//
//  FirstViewCollectionViewCell.m
//  CarMonitoring
//
//  Created by 潘振 on 2019/4/3.
//  Copyright © 2019 潘振. All rights reserved.
//

#import "CollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <AWHBoneRuntime/AWHBoneRuntime.h>
#import <AWHBBasicBusiness/AWHBBasicBusiness.h>

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _locationImage = [AWHBBControl createImageViewFrame:CGRectZero imageName:@""];
        [self.contentView addSubview:_locationImage];
        [_locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(scaleFrom750(35));
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];
        
        _title = [AWHBBControl createLabelWithFrame:CGRectZero Font:scaleFrom750(24) Text:@"" Color:@"666666"];
        _title.numberOfLines = 0;
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-scaleFrom750(30));
            make.centerX.equalTo(self->_locationImage.mas_centerX);
            make.width.equalTo(@(scaleFrom750(150)));
        }];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
@end

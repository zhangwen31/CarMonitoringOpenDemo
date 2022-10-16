//
//  FirstViewCollectionViewCell.h
//  CarMonitoring
//
//  Created by 潘振 on 2019/4/3.
//  Copyright © 2019 潘振. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
//图片
@property(strong,nonatomic)UIImageView *locationImage;
//标题
@property(strong,nonatomic)UILabel *title;
@end

NS_ASSUME_NONNULL_END

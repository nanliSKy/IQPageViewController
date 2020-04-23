//
//  IQPageScrTitleViewCell.h
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IQPageTitleConfig.h"
NS_ASSUME_NONNULL_BEGIN


@interface IQDisplayTitleLabel : UILabel
/** */
@property (nonatomic, assign) CGFloat progress;
/** */
@property (nonatomic, strong) UIColor *fillColor;

@end


@interface IQPageScrTitleViewCell : UICollectionViewCell
/** */
@property (nonatomic, strong) IQDisplayTitleLabel *titleLab;
/** */
@property (nonatomic, strong) IQPageTitleConfig *titleConfig;

@end



NS_ASSUME_NONNULL_END

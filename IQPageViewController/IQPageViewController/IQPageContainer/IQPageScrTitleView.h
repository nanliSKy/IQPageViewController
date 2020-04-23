//
//  IQPageScrTitleView.h
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IQPageTitleConfig.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, iQPageTitleScrollType) {
    iQPageTitleScrollColor = 0,
    iQPageTitleScrollCover,
    iQPageTitleScrollLine,
    iQPageTitleScrollColorAndCover,
    iQPageTitleScrollColorAndLine
};

@class IQPageScrTitleView;
@protocol IQPageScrTitleViewScrollerDelegate <NSObject>

/// viewController 滑动激化 titleView 索引变化
/// @param index viewControllers 中的 的 index 位置viewController
- (void)iQPageScrTitleViewDidScroll:(NSInteger)index;

@end

@protocol IQPageScrTitleConfigDelegate <NSObject>

- (NSInteger)iQPageScrTitle:(IQPageScrTitleView *)scrTitleView;

@required
/// 返回标题数组
- (NSArray <IQPageTitleConfig *> *)iQPageScrTitleConfigArray;



@end

@interface IQPageScrTitleView : UIView
/** */
@property (nonatomic, weak) id<IQPageScrTitleViewScrollerDelegate> scrollerDelegate;
/** */
@property (nonatomic, weak) id<IQPageScrTitleConfigDelegate> titleConfigDelegate;
/** */
@property (nonatomic, assign) iQPageTitleScrollType iQPageTitleScrollType;
/** */
@property (nonatomic, strong) UIColor *indicatorColor;
/** */
@property (nonatomic, assign) CGFloat indicatorWidth;
/** */
@property (nonatomic, strong) UIColor *coverColor;

- (void)reloadData;

- (void)iQPageScrTitleViewDidScroll:(NSInteger)index next:(NSInteger)next distanceProgress:(CGFloat)progress;

- (void)iQPageScrTitleViewEndScroller:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

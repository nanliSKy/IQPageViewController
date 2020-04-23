//
//  IQPageContainerView.h
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class IQPageContainerView;
@protocol IQPageContainerScrollerDelegate <NSObject>

/// viewController 滑动激化 titleView 索引变化
/// @param index viewControllers 中的 的 index 位置viewController
/// @param progress next 或 pro 的比例 ( 0, 1 )
- (void)iQPageContainerScrollerDidScroll:(NSInteger)index next:(NSInteger)next distanceProgress:(CGFloat)progress;

- (void)iQPageContainerEndScroller:(NSInteger)index;
@end

@interface IQPageContainerView : UIView
/** */
@property (nonatomic, weak) id<IQPageContainerScrollerDelegate> pageContainerScrollerDelegate;
/** */
@property (nonatomic, strong) NSArray <UIViewController *> *viewControllerList;

- (void)iQPageContainerScrollerDidScroll:(NSInteger)index distanceProgress:(CGFloat)progress;
@end

NS_ASSUME_NONNULL_END

//
//  IQPageScrContainerView.h
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IQPageScrTitleView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol IQPageScrContainerDelegate <NSObject>

@optional;
- (void)iQPageScrContainerDidScroll:(UIViewController *)viewController atIndex:(NSInteger)index;

- (void)iQPageScrContainerEndScroller:(NSInteger)index;
@end

@interface IQPageScrContainerView : UIView
/** */
@property (nonatomic, strong) NSArray <UIViewController *> *viewControllerList;
/** */
@property (nonatomic, strong) UITableView *tableView;
/** 头部视图*/
@property (nonatomic, strong) UIView *tableHeaderView;
/** 标题栏高度*/
@property (nonatomic, assign) CGFloat titleViewHeight;
/** table 是否允许滑动*/
@property (nonatomic, assign) BOOL enableScroll;
/** */
@property (nonatomic, strong) IQPageScrTitleView *scrTitleView;

/** */
@property (nonatomic, weak) id<IQPageScrContainerDelegate> scrContainerDelegate;

@end

NS_ASSUME_NONNULL_END

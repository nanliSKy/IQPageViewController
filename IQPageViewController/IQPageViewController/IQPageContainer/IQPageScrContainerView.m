//
//  IQPageScrContainerView.m
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import "IQPageScrContainerView.h"


#import "IQPageScrContainerViewCell.h"

@interface IQPageScrContainerView ()<UITableViewDataSource, UITableViewDelegate, IQPageContainerScrollerDelegate, IQPageScrTitleViewScrollerDelegate>

/** */
@property (nonatomic, assign) CGFloat titleViewHeight;

/** */
@property (nonatomic, assign) BOOL tableHeaderViewScroll;

@end

@implementation IQPageScrContainerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.titleViewHeight = 50;
         [self subviewCreate];
    }
    return self;
}

- (void)subviewCreate {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 200)];
    self.tableHeaderViewScroll = NO;
    self.tableHeaderView = headerView;
    headerView.backgroundColor = [UIColor purpleColor];
    self.tableView.tableHeaderView = headerView;
    [self addSubview:self.tableView];
    self.scrTitleView.scrollerDelegate = self;

}

- (void)setTableHeaderView:(UIView *)tableHeaderView {
    _tableHeaderView = tableHeaderView;
    self.tableView.tableHeaderView = _tableHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    [self.scrTitleView reloadData];
    return self.scrTitleView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IQPageScrContainerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IQPageScrContainerViewCell class])];
    cell.containerView.pageContainerScrollerDelegate = self;
    cell.containerView.viewControllerList = self.viewControllerList;
    return cell;
}


#pragma mark IQPageContainerScrollerDelegate


- (void)iQPageContainerScrollerDidScroll:(NSInteger)index next:(NSInteger)next distanceProgress:(CGFloat)progress {
    [self.scrTitleView iQPageScrTitleViewDidScroll:index next:next distanceProgress:progress];
}

- (void)iQPageContainerEndScroller:(NSInteger)index {
    if (self.scrContainerDelegate && [self.scrContainerDelegate respondsToSelector:@selector(iQPageScrContainerEndScroller:)]) {
        [self.scrContainerDelegate iQPageScrContainerEndScroller:index];
    }
    [self.scrTitleView iQPageScrTitleViewEndScroller:index];
}

#pragma mark IQPageScrTitleViewScrollerDelegate
- (void)iQPageScrTitleViewDidScroll:(NSInteger)index {
    IQPageScrContainerViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.containerView iQPageContainerScrollerDidScroll:index distanceProgress:0];
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.sectionHeaderHeight = self.titleViewHeight;
        CGFloat rowHeight = CGRectGetHeight(self.frame)-self.titleViewHeight;
        if (!self.tableHeaderViewScroll) {
            rowHeight -= 200;
        }
        _tableView.rowHeight = rowHeight;
        [_tableView registerClass:[IQPageScrContainerViewCell class] forCellReuseIdentifier:NSStringFromClass([IQPageScrContainerViewCell class])];
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (IQPageScrTitleView *)scrTitleView {
    if (!_scrTitleView) {
        _scrTitleView = [[IQPageScrTitleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), self.titleViewHeight)];
    }
    return _scrTitleView;
}
@end


//
//  IQPageContainerView.m
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import "IQPageContainerView.h"
#import "IQPageContainerViewCell.h"

@interface IQPageContainerView ()<UICollectionViewDelegate, UICollectionViewDataSource>
/** */
@property (nonatomic, strong) UICollectionView *collectionView;
/** */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@implementation IQPageContainerView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self subviewCreate];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:self.collectionView];
}

- (void)setViewControllerList:(NSArray<UIViewController *> *)viewControllerList {
    _viewControllerList = viewControllerList;

}
- (void)subviewCreate {
    
}

- (void)iQPageContainerScrollerDidScroll:(NSInteger)index distanceProgress:(CGFloat)progress {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewControllerList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IQPageContainerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([IQPageContainerViewCell class]) forIndexPath:indexPath];
    UIViewController *viewController = self.viewControllerList[indexPath.row];
    cell.viewController = viewController;
//    [cell.containerView addSubview:viewController.view];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

   
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat progress = scrollView.contentOffset.x / viewWidth - floor(scrollView.contentOffset.x / viewWidth);
    NSUInteger leftIndex = floor(scrollView.contentOffset.x / viewWidth);
    NSUInteger rightIndex = leftIndex + 1;
    if (self.pageContainerScrollerDelegate && [self.pageContainerScrollerDelegate respondsToSelector:@selector(iQPageContainerScrollerDidScroll:next:distanceProgress:)]) {
        [self.pageContainerScrollerDelegate iQPageContainerScrollerDidScroll:leftIndex next:rightIndex distanceProgress:progress];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX/CGRectGetWidth(scrollView.frame);

    if (self.pageContainerScrollerDelegate && [self.pageContainerScrollerDelegate respondsToSelector:@selector(iQPageContainerEndScroller:)]) {
        [self.pageContainerScrollerDelegate iQPageContainerEndScroller:index];
    }
    
    
    
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        CGFloat witdh = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        flowLayout.itemSize = CGSizeMake(witdh, height);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[IQPageContainerViewCell class] forCellWithReuseIdentifier:NSStringFromClass([IQPageContainerViewCell class])];
    }
    return _collectionView;
}

@end

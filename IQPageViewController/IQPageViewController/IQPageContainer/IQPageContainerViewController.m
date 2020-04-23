//
//  IQPageContainerViewController.m
//  sss
//
//  Created by nanli on 2020/4/23.
//  Copyright © 2020 darchain. All rights reserved.
//

#import "IQPageContainerViewController.h"

@interface IQPageContainerViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
/** */
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation IQPageContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view addSubview:self.collectionView];
}

- (void)setViewControllerList:(NSArray<UIViewController *> *)viewControllerList {
    _viewControllerList = viewControllerList;

}


- (void)iQPageContainerScrollerDidScroll:(NSInteger)index distanceProgress:(CGFloat)progress {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewControllerList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    UIViewController *viewController = self.viewControllerList[indexPath.row];
    viewController.view.frame = self.view.bounds;
    [cell.contentView addSubview:viewController.view];
    

    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

   
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat progress = scrollView.contentOffset.x / viewWidth - floor(scrollView.contentOffset.x / viewWidth);
    NSUInteger index = floor(scrollView.contentOffset.x / viewWidth);

    NSInteger rightIndex = index+1;
    if (self.pageContainerScrollerDelegate && [self.pageContainerScrollerDelegate respondsToSelector:@selector(iQPageContainerScrollerDidScroll:next:distanceProgress:)]) {
        [self.pageContainerScrollerDelegate iQPageContainerScrollerDidScroll:index next:rightIndex distanceProgress:progress];
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
        CGFloat witdh = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        flowLayout.itemSize = CGSizeMake(witdh, height);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _collectionView;
}



@end

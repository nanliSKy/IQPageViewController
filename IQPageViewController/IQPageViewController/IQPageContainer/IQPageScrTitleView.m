//
//  IQPageScrTitleView.m
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import "IQPageScrTitleView.h"

#import "IQPageScrTitleViewCell.h"


@interface IQPageScrTitleFlowLayout : UICollectionViewFlowLayout

@end

@implementation IQPageScrTitleFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    return attrs;
}
@end

@interface IQPageScrTitleView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** */
@property (nonatomic, strong) UIScrollView *backScrView;
/** */
@property (nonatomic, strong) UICollectionView *collectionView;
/** */
@property (nonatomic, assign) NSInteger column;
/** */
@property (nonatomic, assign) NSInteger titleCount;
/** */
@property (nonatomic, assign) NSInteger currentIndex;
/** */
@property (nonatomic, strong) UIView *indicatorView;
/** */
@property (nonatomic, strong) UIView *indicatorBackView;
/** */
@property (nonatomic, strong) NSMutableArray <IQDisplayTitleLabel *> *titleLabelArr;
/** */
@property (nonatomic, strong) NSMutableDictionary *mutableCell;

/** */
@property (nonatomic, strong) NSArray <IQPageTitleConfig *> *pageTitleConfigs;

@end

@implementation IQPageScrTitleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         [self subviewCreate];
    }
    return self;
}

- (void)reloadData {
    if (self.titleConfigDelegate && [self.titleConfigDelegate respondsToSelector:@selector(iQPageScrTitle:)]) {
        self.titleCount = [self.titleConfigDelegate iQPageScrTitle:self];
    }
    
    [self.collectionView reloadData];
    IQPageScrTitleViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([IQPageScrTitleViewCell class]) forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [self updateIndicatorViewConstraints:cell.bounds];
    
    
}

- (void)subviewCreate {
    
    self.iQPageTitleScrollType = iQPageTitleScrollColor;
    
    _indicatorWidth = 80;
    self.currentIndex = 0;
    self.column = 4;
    [self addSubview:self.backScrView];
    [self addSubview:self.collectionView];
    [self addSubview:self.indicatorView];
    
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:2]
    ]];
    
  
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [self.collectionView reloadData];
    self.backScrView.contentSize = self.collectionView.contentSize;
}

- (void)setIQPageTitleScrollType:(iQPageTitleScrollType)iQPageTitleScrollType {
    _iQPageTitleScrollType = iQPageTitleScrollType;
    switch (_iQPageTitleScrollType) {
        case iQPageTitleScrollColor:
            self.indicatorView.hidden = YES;
            self.indicatorBackView.hidden = YES;
            break;
        case iQPageTitleScrollLine:
        case iQPageTitleScrollColorAndLine:
            self.indicatorView.hidden = NO;
            self.indicatorBackView.hidden = YES;
            break;
        case iQPageTitleScrollCover:
        case iQPageTitleScrollColorAndCover:
            self.indicatorBackView.hidden = NO;
            self.indicatorView.hidden = YES;
            break;

    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor = indicatorColor;
    self.indicatorView.backgroundColor = _indicatorColor;
}

- (void)setCoverColor:(UIColor *)coverColor {
    _coverColor = coverColor;
    self.indicatorBackView.backgroundColor = _coverColor;
}

- (void)setIndicatorWidth:(CGFloat)indicatorWidth {
    _indicatorWidth = indicatorWidth;
}

- (void)setTitleConfigDelegate:(id<IQPageScrTitleConfigDelegate>)titleConfigDelegate {
    _titleConfigDelegate = titleConfigDelegate;
    self.pageTitleConfigs = [self.titleConfigDelegate iQPageScrTitleConfigArray];
}

- (void)updateIndicatorViewConstraints:(CGRect)benchFrame {
    CGRect rect = benchFrame;
    rect.size.height = 36;
    rect.origin.y = (CGRectGetHeight(self.frame)-36)/2.0;
    self.indicatorBackView.frame = rect;
    
    
    NSLayoutConstraint *constranint = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.indicatorBackView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *constranintWidth = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_indicatorWidth];
    
    [NSLayoutConstraint activateConstraints:@[constranint, constranintWidth]];
    
}


- (void)iQPageScrTitleViewDidScroll:(NSInteger)index next:(NSInteger)next distanceProgress:(CGFloat)progress {
    
    switch (self.iQPageTitleScrollType) {
        case iQPageTitleScrollColor:
            [self modifyColorWithScrollProgress:progress LeftIndex:index RightIndex:next];
            break;
        case iQPageTitleScrollLine:
            [self modifyCoverWithScrollProgress:progress LeftIndex:index RightIndex:next];
            break;
        case iQPageTitleScrollCover:
            self.indicatorView.hidden = YES;
            [self modifyCoverWithScrollProgress:progress LeftIndex:index RightIndex:next];
            break;
        case iQPageTitleScrollColorAndLine:
            self.indicatorBackView.hidden = YES;
            [self modifyCoverWithScrollProgress:progress LeftIndex:index RightIndex:next];
            [self modifyColorWithScrollProgress:progress LeftIndex:index RightIndex:next];
            break;
        case iQPageTitleScrollColorAndCover:
            self.indicatorView.hidden = YES;
            [self modifyCoverWithScrollProgress:progress LeftIndex:index RightIndex:next];
            [self modifyColorWithScrollProgress:progress LeftIndex:index RightIndex:next];
            break;
    }
    
//    [self modifyCoverWithScrollProgress:progress LeftIndex:index RightIndex:next];
//    [self modifyColorWithScrollProgress:progress LeftIndex:index RightIndex:next];
    
//    [self modifyTitleScaleWithScrollProgress:scale LeftIndex:index RightIndex:next];
}


- (void)iQPageScrTitleViewEndScroller:(NSInteger)index {
    self.currentIndex = index;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    IQPageScrTitleViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([IQPageScrTitleViewCell class]) forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGRect rect = cell.frame;

    [self updateIndicatorViewConstraints:rect];
}

#pragma mark method

CG_EXTERN NSArray* IQColorGetRGBA(UIColor *color) {
    
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
    
}

- (void)cellClickUpdateIndicatorViewConstraintsIndex:(NSInteger)index {
    IQPageScrTitleViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([IQPageScrTitleViewCell class]) forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];

    //Cover
    CGRect rect = cell.frame;
    [self updateIndicatorViewConstraints:rect];
}

- (void)cellClickUpdateLabelColorIndex:(NSInteger)index {
    IQPageTitleConfig *titleConfig = self.pageTitleConfigs[index];
    for (IQDisplayTitleLabel *lab in self.titleLabelArr) {
        NSInteger selectIndex = [self.titleLabelArr indexOfObject:lab];
        if (selectIndex == index) {
            lab.textColor = titleConfig.selectColor;
            lab.font = titleConfig.selectFont;
        }else {
            lab.textColor = titleConfig.color;
            lab.font = titleConfig.font;
        }
    }
}

- (void)modifyCoverWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    
    //通过判断isClickTitle的属性来防止二次偏移
   
    
    if (rightIndex >= self.titleLabelArr.count) return;
    IQDisplayTitleLabel *leftLabel = self.titleLabelArr[leftIndex];
    IQDisplayTitleLabel *rightLabel = self.titleLabelArr[rightIndex];
    
    
    CGFloat deltaWidth = CGRectGetWidth(rightLabel.frame) * progress + CGRectGetWidth(leftLabel.frame) *(1-progress) ;
    
    IQPageScrTitleViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([IQPageScrTitleViewCell class]) forIndexPath:[NSIndexPath indexPathForRow:leftIndex inSection:0]];

    CGRect rect = cell.frame;
    if (progress >= 0 && leftIndex != self.pageTitleConfigs.count) {
        rect.origin.x += cell.frame.size.width*progress;
    }
    rect.size.width = deltaWidth;
   [self updateIndicatorViewConstraints:rect];
    
    
    
}

- (void)modifyColorWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    if (rightIndex >= self.titleLabelArr.count) return;
    IQDisplayTitleLabel *leftLabel = self.titleLabelArr[leftIndex];
    IQDisplayTitleLabel *rightLabel = self.titleLabelArr[rightIndex];
    
    CGFloat rightScale = progress;
    
    CGFloat leftScale = 1 - rightScale;
    
    IQPageTitleConfig *titleConfig = self.pageTitleConfigs[leftIndex]; 
    NSArray *endRGBA = IQColorGetRGBA(titleConfig.selectColor);
    NSArray *startRGBA = IQColorGetRGBA(titleConfig.color);
    

    CGFloat deltaR = [endRGBA[0] floatValue] - [startRGBA[0] floatValue];
    CGFloat deltaG = [endRGBA[1] floatValue] - [startRGBA[1] floatValue];
    CGFloat deltaB = [endRGBA[2] floatValue] - [startRGBA[2] floatValue];
    CGFloat deltaA = [endRGBA[3] floatValue] - [startRGBA[3] floatValue];


    
    UIColor *rightColor = [UIColor colorWithRed:[startRGBA[0] floatValue] + rightScale *deltaR green:[startRGBA[1] floatValue] + rightScale *deltaG blue:[startRGBA[2] floatValue] + rightScale *deltaB alpha:[startRGBA[3] floatValue] + rightScale *deltaA];

    UIColor *leftColor = [UIColor colorWithRed:[startRGBA[0] floatValue] + leftScale * deltaR green:[startRGBA[1] floatValue] + leftScale *deltaG blue:[startRGBA[2] floatValue] + leftScale *deltaB alpha:[startRGBA[3] floatValue] + leftScale *deltaA];

    rightLabel.textColor = rightColor;
    leftLabel.textColor = leftColor;
    
//    rightLabel.textColor    = titleConfig.color;
//    rightLabel.fillColor = titleConfig.selectColor;
//    rightLabel.progress  = rightScale;
//
//    leftLabel.textColor     = titleConfig.selectColor;
//    leftLabel.fillColor  = titleConfig.color;
//    leftLabel.progress   = rightScale;
    
    
}

- (void)modifyTitleScaleWithScrollProgress:(CGFloat)progress LeftIndex:(NSUInteger)leftIndex RightIndex:(NSUInteger)rightIndex {
    
    
    
    IQDisplayTitleLabel *leftLabel = self.titleLabelArr[leftIndex];
    IQDisplayTitleLabel *rightLabel = self.titleLabelArr[rightIndex];
    
    
    CGFloat rightScale = progress;
    
    CGFloat leftScale = 1 - rightScale;
    
    CGFloat scaleTransform = 1.2;
    
    scaleTransform -= 1;
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * scaleTransform + 1, rightScale * scaleTransform +1);
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleCount;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = [self.mutableCell objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"titleCell%@", indexPath];
        [self.mutableCell setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        [self.collectionView registerClass:[IQPageScrTitleViewCell class] forCellWithReuseIdentifier:identifier];
    }
    
    IQPageScrTitleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
   
    IQPageTitleConfig *titleConfig = self.pageTitleConfigs[indexPath.row];
    titleConfig.isSelect = (self.currentIndex == indexPath.row);
    cell.titleConfig = titleConfig;
    if (![self.titleLabelArr containsObject:cell.titleLab]) {
        [self.titleLabelArr addObject:cell.titleLab];
    }
  
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.scrollerDelegate && [self.scrollerDelegate respondsToSelector:@selector(iQPageScrTitleViewDidScroll:)]) {
        [self.scrollerDelegate iQPageScrTitleViewDidScroll:indexPath.row];
    }

    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.currentIndex = indexPath.row;
    
    switch (self.iQPageTitleScrollType) {
        case iQPageTitleScrollColor:
            [self cellClickUpdateLabelColorIndex:indexPath.row];
            break;
        case iQPageTitleScrollLine:
        case iQPageTitleScrollCover:
        case iQPageTitleScrollColorAndLine:
        case iQPageTitleScrollColorAndCover:
            [self cellClickUpdateLabelColorIndex:indexPath.row];
            [self cellClickUpdateIndicatorViewConstraintsIndex:indexPath.row];
            break;
    }
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    IQPageTitleConfig *titleConfig = self.pageTitleConfigs[indexPath.row];
    BOOL isSelect = self.currentIndex == indexPath.row;
    CGRect rect = [titleConfig.title boundingRectWithSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.frame)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: isSelect ? titleConfig.selectFont : titleConfig.font} context:nil];
    CGFloat minWitdh = self.frame.size.width/self.column;
    CGFloat width = MAX(minWitdh, rect.size.width+10);
    return CGSizeMake(width, CGRectGetHeight(self.frame));
    return CGSizeZero;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.backScrView.contentOffset = scrollView.contentOffset;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        IQPageScrTitleFlowLayout *flowLayout = [[IQPageScrTitleFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
//        CGFloat witdh = self.frame.size.width/self.column;
//        CGFloat height = self.frame.size.height;
//        flowLayout.itemSize = CGSizeMake(witdh, height);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[IQPageScrTitleViewCell class] forCellWithReuseIdentifier:NSStringFromClass([IQPageScrTitleViewCell class])];
        
    }
    return _collectionView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}

- (UIScrollView *)backScrView {
    if (!_backScrView) {
        _backScrView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _backScrView.showsVerticalScrollIndicator = NO;
        _backScrView.showsHorizontalScrollIndicator = NO;
    }
    return _backScrView;
}

- (UIView *)indicatorBackView {
    if (!_indicatorBackView) {
        _indicatorBackView = [[UIView alloc] init];
        _indicatorBackView.layer.cornerRadius = 18;
        _indicatorBackView.backgroundColor = [UIColor redColor];
//        _indicatorBackView.hidden = YES;
        [self.backScrView addSubview:_indicatorBackView];
    }
    return _indicatorBackView;
}

- (NSMutableArray<IQDisplayTitleLabel *> *)titleLabelArr {
    if (!_titleLabelArr) {
        _titleLabelArr = [NSMutableArray array];
    }
    return _titleLabelArr;
}

- (NSMutableDictionary *)mutableCell {
    if (!_mutableCell) {
        _mutableCell = [NSMutableDictionary dictionary];
    }
    return _mutableCell;
}
@end

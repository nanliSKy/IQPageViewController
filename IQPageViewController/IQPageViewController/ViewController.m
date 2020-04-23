//
//  ViewController.m
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import "ViewController.h"
#import "IQPageScrContainerView.h"
#import "ListViewController.h"
@interface ViewController ()<IQPageScrContainerDelegate, IQPageScrTitleConfigDelegate>
/** */
@property (nonatomic, strong) NSArray <NSString *> *controllerTitles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSLog(@"%@  %@",NSStringFromCGRect(UIScreen.mainScreen.bounds), NSStringFromCGRect(self.view.frame));
    IQPageScrContainerView *containerView = [[IQPageScrContainerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    containerView.scrContainerDelegate = self;
    containerView.scrTitleView.titleConfigDelegate = self;
    containerView.scrTitleView.iQPageTitleScrollType = iQPageTitleScrollColorAndLine;
    containerView.scrTitleView.indicatorWidth = 60;
    
    containerView.viewControllerList = @[[ListViewController new], [ListViewController new], [ListViewController new], [ListViewController new], [ListViewController new], [ListViewController new], [ListViewController new]];
    containerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:containerView];
    // Do any additional setup after loading the view.
}

- (NSArray<NSString *> *)controllerTitles {
    if (!_controllerTitles) {
        _controllerTitles = @[@"精选", @"电影", @"电视剧", @"综艺", @"爱豆", @"纪录片", @"HowTo"];
    }
    return _controllerTitles;
}
#pragma mark IQPageScrContainerDelegate

- (void)iQPageScrContainerEndScroller:(NSInteger)index {
    NSLog(@"index=%li", (long)index);
}
    

#pragma mark IQPageScrTitleConfigDelegate

- (NSArray<IQPageTitleConfig *> *)iQPageScrTitleConfigArray {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<self.controllerTitles.count; i++) {
        [arr addObject:[IQPageTitleConfig titleConfigCreate:self.controllerTitles[i]]];
    }
    return arr;
}

- (NSInteger)iQPageScrTitle:(IQPageScrTitleView *)scrTitleView {
    return self.controllerTitles.count;
}
@end

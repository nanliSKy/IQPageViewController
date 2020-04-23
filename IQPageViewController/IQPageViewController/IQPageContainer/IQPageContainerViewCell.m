//
//  IQPageContainerViewCell.m
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import "IQPageContainerViewCell.h"
@interface IQPageContainerViewCell ()


@end
@implementation IQPageContainerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self subviewCreate];
    }
    return self;
}
- (void)subviewCreate {
    

}

- (void)setViewController:(UIViewController *)viewController {
    _viewController = viewController;
    [self.contentView addSubview:_viewController.view];
    _viewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:_viewController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:_viewController.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:_viewController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:_viewController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]
    ]];
}


@end

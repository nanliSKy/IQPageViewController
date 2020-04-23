//
//  IQPageScrTitleViewCell.m
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import "IQPageScrTitleViewCell.h"

@implementation IQPageScrTitleViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self subviewCreate];
    }
    return self;
}

- (void)setTitleConfig:(IQPageTitleConfig *)titleConfig {
    _titleConfig = titleConfig;
    _titleLab.text = _titleConfig.title;
    if (_titleConfig.isSelect) {
        self.titleLab.font = _titleConfig.selectFont;
        self.titleLab.textColor = _titleConfig.selectColor;
    }else {
        self.titleLab.font = _titleConfig.font;
        self.titleLab.textColor = _titleConfig.color;
    }
}

- (void)subviewCreate {
    
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLab];
    
    self.titleLab.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]
    ]];
}

- (IQDisplayTitleLabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[IQDisplayTitleLabel alloc] init];
        _titleLab.textColor = [UIColor redColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;

    }
    return _titleLab;
}

@end

@implementation IQDisplayTitleLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [_fillColor set];
    rect.size.width = rect.size.width *_progress;
    
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame] ) {
        self.userInteractionEnabled = YES;
        
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
- (void)setProgress:(CGFloat)progress {
    _progress  = progress;
    
    [self setNeedsDisplay];
}


@end

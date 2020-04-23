//
//  IQPageScrContainerViewCell.m
//  IQPageViewController
//
//  Created by nanli on 2020/4/16.
//  Copyright © 2020 darchain. All rights reserved.
//

#import "IQPageScrContainerViewCell.h"



@interface IQPageScrContainerViewCell ()

@end
@implementation IQPageScrContainerViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {

    self.containerView.frame = self.bounds;
    [self subviewCreate];
}

- (void)subviewCreate {
    
    [self.contentView addSubview:self.containerView];

}

- (IQPageContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[IQPageContainerView alloc] initWithFrame:CGRectZero];
    }
    return _containerView;
}

@end

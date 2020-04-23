//
//  IQPageTitleConfig.m
//  IQPageViewController
//
//  Created by nanli on 2020/4/17.
//  Copyright © 2020 darchain. All rights reserved.
//

#import "IQPageTitleConfig.h"

@implementation IQPageTitleConfig

+ (instancetype)titleConfigCreate:(NSString *)title {
    IQPageTitleConfig *titleConfig = [[IQPageTitleConfig alloc] init];
    titleConfig.title = title;
    titleConfig.font = [UIFont systemFontOfSize:14];
    titleConfig.selectFont = [UIFont systemFontOfSize:14];
    titleConfig.color = [UIColor blackColor];
    titleConfig.selectColor = [UIColor redColor];
    return titleConfig;
}
@end

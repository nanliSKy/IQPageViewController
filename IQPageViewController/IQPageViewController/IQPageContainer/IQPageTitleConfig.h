//
//  IQPageTitleConfig.h
//  IQPageViewController
//
//  Created by nanli on 2020/4/17.
//  Copyright © 2020 darchain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface IQPageTitleConfig : NSObject
/** */
@property (nonatomic, copy) NSString *title;
/** */
@property (nonatomic, strong) UIColor *color;
/** */
@property (nonatomic, strong) UIColor *selectColor;
/** */
@property (nonatomic, strong) UIFont *font;
/** */
@property (nonatomic, strong) UIFont *selectFont;
/** */
@property (nonatomic, assign) BOOL isSelect;

+ (instancetype)titleConfigCreate:(NSString *)title;

@end

NS_ASSUME_NONNULL_END

//
//  TFY_LineView.h
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFY_LineView;

NS_ASSUME_NONNULL_BEGIN

#define TFY_ColorMaster [UIColor colorWithRed:49/255.0 green:51/255.0 blue:64/255.0 alpha:1]

typedef void(^TFY_LineViewSelectChangeBlock)(TFY_LineView *lineView, BOOL selected);

@interface TFY_LineView : UIView

@property (strong, nonatomic) UIView    *lineView;
@property (assign, nonatomic) BOOL      selected;

/**
 下划线颜色
 状态：未选中状态，且没有填充文字时
 默认：[UIColor colorWithRed:49/255.0 green:51/255.0 blue:64/255.0 alpha:1]
 */
@property (strong, nonatomic) UIColor *underlineColorNormal;

/**
 下划线颜色
 状态：选中状态时
 默认：[UIColor colorWithRed:49/255.0 green:51/255.0 blue:64/255.0 alpha:1]
 */
@property (strong, nonatomic) UIColor *underlineColorSelected;

/**
 下划线颜色
 状态：未选中状态，且有填充文字时
 默认：[UIColor colorWithRed:49/255.0 green:51/255.0 blue:64/255.0 alpha:1]
 */
@property (strong, nonatomic) UIColor *underlineColorFilled;

/**
 选择状态改变时回调
 */
@property (copy, nonatomic) TFY_LineViewSelectChangeBlock __nullable selectChangeBlock;

@end

NS_ASSUME_NONNULL_END

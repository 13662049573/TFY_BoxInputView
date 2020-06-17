//
//  TFY_BoxInputCell.h
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFY_BoxInputCellProperty.h"

#define TFY_BoxCursoryAnimationKey @"CRBoxCursoryAnimationKey"
#define TFY_BoxInputCellID @"CRBoxInputCellID"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_BoxInputCell : UICollectionViewCell

/**
 光标 除非您知道自己在做什么，否则不应该使用这些属性。
 */
@property (strong, nonatomic) UIView *cursorView;
@property (assign, nonatomic) BOOL ifNeedCursor;

/**
 boxInputCellProperty 除非您知道自己在做什么，否则不应该使用这些属性。
 */
@property (strong, nonatomic) TFY_BoxInputCellProperty *boxInputCellProperty;

@end

NS_ASSUME_NONNULL_END

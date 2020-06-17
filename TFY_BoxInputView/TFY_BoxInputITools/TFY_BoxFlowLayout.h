//
//  TFY_BoxFlowLayout.h
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFY_BoxFlowLayout : UICollectionViewFlowLayout
/**
 * ifNeedEqualGap default: YES
 */
@property (assign, nonatomic) BOOL ifNeedEqualGap;

@property (assign, nonatomic) NSInteger itemNum;
/**
 * minLineSpacing default: 10
 */
@property (assign, nonatomic) NSInteger minLineSpacing;

- (void)autoCalucateLineSpacing;

@end

NS_ASSUME_NONNULL_END

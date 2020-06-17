//
//  TFY_SecrectImageView.h
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFY_SecrectImageView : UIView
/**选择显示的图片 默认-锁-*/
@property (strong, nonatomic) UIImage   *image;
/**自定义图片的宽度 - 高度*/
@property (assign, nonatomic) CGSize   size;

@end

NS_ASSUME_NONNULL_END

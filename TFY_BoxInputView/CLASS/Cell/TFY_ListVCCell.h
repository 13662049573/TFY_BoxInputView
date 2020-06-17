//
//  TFY_ListVCCell.h
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFY_BoxInputModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_ListVCCell : UITableViewCell

- (void)loadDataWithModel:(TFY_BoxInputModel *)model;

@end

NS_ASSUME_NONNULL_END

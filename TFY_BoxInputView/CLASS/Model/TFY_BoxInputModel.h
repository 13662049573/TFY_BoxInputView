//
//  TFY_BoxInputModel.h
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TFY_BoxInputModelType) {
    TFY_BoxInputModelNormalType,
    TFY_BoxInputModelPlaceholderType,
    TFY_BoxInputModelCustomBoxType,
    TFY_BoxInputModelLineType,
    TFY_BoxInputModelSecretSymbolType,
    TFY_BoxInputModelSecretImageType,
    TFY_BoxInputModelSecretViewType,
};

@interface TFY_BoxInputModel : NSObject
@property (strong, nonatomic) NSString  *name;
@property (strong, nonatomic) NSString  *imageName;
@property (assign, nonatomic) TFY_BoxInputModelType type;
@end

NS_ASSUME_NONNULL_END

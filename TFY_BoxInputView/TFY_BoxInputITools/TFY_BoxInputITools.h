//
//  TFY_BoxInputITools.h
//  TFY_BoxInputView
//
//  Created by 田风有 on 2020/9/10.
//  Copyright © 2020 田风有. All rights reserved.
//  最新版本 : 2.1.0

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double TFY_BoxInputIToolsVersionNumber;

FOUNDATION_EXPORT const unsigned char TFY_BoxInputIToolsVersionString[];

#define TFY_BoxInputIToolsRelease 0

#if TFY_BoxInputIToolsRelease

#import <TFY_BoxInputITools/TFY_LineView.h>
#import <TFY_BoxInputITools/TFY_BoxInputView.h>

#else

#import "TFY_LineView.h"
#import "TFY_BoxInputView.h"

#endif

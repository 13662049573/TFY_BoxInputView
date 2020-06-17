//
//  TFY_BoxTextField.m
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import "TFY_BoxTextField.h"

@implementation TFY_BoxTextField
/**
 * /禁止可被粘贴复制
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

@end

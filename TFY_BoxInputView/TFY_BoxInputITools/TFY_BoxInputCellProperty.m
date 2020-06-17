//
//  TFY_BoxInputCellProperty.m
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import "TFY_BoxInputCellProperty.h"

static CGFloat circleViewWidth = 20;

@interface TFY_BoxInputCellProperty ()
@property (copy, nonatomic, readwrite) NSString *originValue;
@end

@implementation TFY_BoxInputCellProperty

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        // UI
       self.borderWidth = (0.5);
       self.cellBorderColorNormal = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
       self.cellBorderColorSelected = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1];
       self.cellBorderColorFilled = nil;
       self.cellBgColorNormal = [UIColor whiteColor];
       self.cellBgColorSelected = [UIColor whiteColor];
       self.cellBgColorFilled = nil;
       self.cellCursorColor = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1];
       self.cellCursorWidth = 2;
       self.cellCursorHeight = 32;
       self.cornerRadius = 4;
       
       // line
       self.showLine = NO;
       
       // label
       self.cellFont = [UIFont systemFontOfSize:20];
       self.cellTextColor = [UIColor blackColor];
       
       // Security
       self.ifShowSecurity = NO;
       self.securitySymbol = @"❦";
       self.originValue = @"";
       self.securityType = TFY_BoxSecuritySymbolType;
       
       // Placeholder
       self.cellPlaceholderText = nil;
       self.cellPlaceholderTextColor = [UIColor colorWithRed:114/255.0 green:116/255.0 blue:124/255.0 alpha:0.3];
       self.cellPlaceholderFont = [UIFont systemFontOfSize:20];
       
       // Block
       self.customSecurityViewBlock = ^UIView * _Nonnull{
           return [weakSelf defaultCustomSecurityView];
       };
       self.customLineViewBlock = ^TFY_LineView * _Nonnull{
           return [TFY_LineView new];
       };
       self.configCellShadowBlock = nil;
       
       // Test
       self.index = 0;
    }
    return self;
}

#pragma mark - Copy
- (id)copyWithZone:(NSZone *)zone{
    TFY_BoxInputCellProperty *copy = [[self class] allocWithZone:zone];
    // UI
    copy.borderWidth = _borderWidth;
    copy.cellBorderColorNormal = [_cellBorderColorNormal copy];
    copy.cellBorderColorSelected = [_cellBorderColorSelected copy];
    if (_cellBorderColorFilled) {
        copy.cellBorderColorFilled = [_cellBorderColorFilled copy];
    }
    copy.cellBgColorNormal = [_cellBgColorNormal copy];
    copy.cellBgColorSelected = [_cellBgColorSelected copy];
    if (_cellBgColorFilled) {
        copy.cellBgColorFilled = [_cellBgColorFilled copy];
    }
    copy.cellCursorColor = [_cellCursorColor copy];
    copy.cellCursorWidth = _cellCursorWidth;
    copy.cellCursorHeight = _cellCursorHeight;
    copy.cornerRadius = _cornerRadius;
    
    // line
    copy.showLine = _showLine;
    
    // label
    copy.cellFont = [_cellFont copy];
    copy.cellTextColor = [_cellTextColor copy];
    
    // Security
    copy.ifShowSecurity = _ifShowSecurity;
    copy.securitySymbol = [_securitySymbol copy];
    copy.originValue = [_originValue copy];
    copy.securityType = _securityType;
    
    // Placeholder
    if (_cellPlaceholderText) {
        copy.cellPlaceholderText = [_cellPlaceholderText copy];
    }
    copy.cellPlaceholderTextColor = [_cellPlaceholderTextColor copy];
    copy.cellPlaceholderFont = [_cellPlaceholderFont copy];
    
    // Block
    copy.customSecurityViewBlock = [_customSecurityViewBlock copy];
    copy.customLineViewBlock = [_customLineViewBlock copy];
    
    if (_configCellShadowBlock) {
        copy.configCellShadowBlock = [_configCellShadowBlock copy];
    }
    
    // Test
    copy.index = _index;
    
    return copy;
}

#pragma mark - Getter
- (UIView *)defaultCustomSecurityView{
    UIView *customSecurityView = [UIView new];
    customSecurityView.backgroundColor = [UIColor clearColor];
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(circleViewWidth/1.5, circleViewWidth/2, circleViewWidth, circleViewWidth)];
    circleView.backgroundColor = [UIColor blackColor];
    circleView.layer.cornerRadius = 4;
    [customSecurityView addSubview:circleView];
    return customSecurityView;
}


#pragma mark - Setter
- (void)setMyOriginValue:(NSString *)originValue {
    _originValue = originValue;
}

@end

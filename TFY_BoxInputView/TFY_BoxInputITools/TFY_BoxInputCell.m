//
//  TFY_BoxInputCell.m
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import "TFY_BoxInputCell.h"
#import "TFY_LineView.h"

@interface TFY_BoxInputCell ()
@property (strong, nonatomic) UILabel *valueLabel;
@property (strong, nonatomic) CABasicAnimation *opacityAnimation;
@property (strong, nonatomic) UIView *customSecurityView;
@property (strong, nonatomic) TFY_LineView *lineView;

@end

@implementation TFY_BoxInputCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.ifNeedCursor = YES;
        
        [self initCellProperty];
        
        self.userInteractionEnabled = NO;
        
        [self.contentView addSubview:self.valueLabel];
        self.valueLabel.center = self.center;
        
        [self.contentView addSubview:self.cursorView];
        self.cursorView.center = self.center;
    }
    return self;
}

-(UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [UILabel new];
        _valueLabel.font = [UIFont systemFontOfSize:38];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _valueLabel;
}

-(UIView *)cursorView{
    if (!_cursorView) {
        _cursorView = [UIView new];
    }
    return _cursorView;
}


- (void)initCellProperty{
    TFY_BoxInputCellProperty *cellProperty = [TFY_BoxInputCellProperty new];
    self.boxInputCellProperty = cellProperty;
}


- (void)valueLabelLoadData{
    self.valueLabel.hidden = NO;
    
    [self hideCustomSecurityView];
    
    // 默认字体配置
    __weak typeof(self) weakSelf = self;
    void (^defaultTextConfig)(void) = ^{
        if (weakSelf.boxInputCellProperty.cellFont) {
            weakSelf.valueLabel.font = weakSelf.boxInputCellProperty.cellFont;
        }
        
        if (weakSelf.boxInputCellProperty.cellTextColor) {
            weakSelf.valueLabel.textColor = weakSelf.boxInputCellProperty.cellTextColor;
        }
    };
    
    // 占位字符字体配置
    void (^placeholderTextConfig)(void) = ^{
        if (weakSelf.boxInputCellProperty.cellFont) {
            weakSelf.valueLabel.font = weakSelf.boxInputCellProperty.cellPlaceholderFont;
        }
        
        if (weakSelf.boxInputCellProperty.cellTextColor) {
            weakSelf.valueLabel.textColor = weakSelf.boxInputCellProperty.cellPlaceholderTextColor;
        }
    };
    
    BOOL hasOriginValue = self.boxInputCellProperty.originValue && self.boxInputCellProperty.originValue.length > 0;
    if (hasOriginValue) {
        if (self.boxInputCellProperty.ifShowSecurity) {
            if (self.boxInputCellProperty.securityType == TFY_BoxSecuritySymbolType) {
                self.valueLabel.text = self.boxInputCellProperty.securitySymbol;
            }else if (self.boxInputCellProperty.securityType == TFY_BoxSecurityCustomViewType) {
                self.valueLabel.hidden = YES;
                [self showCustomSecurityView];
            }
        }else{
            self.valueLabel.text = self.boxInputCellProperty.originValue;
        }
        defaultTextConfig();
    }else{
        BOOL hasPlaceholderText = self.boxInputCellProperty.cellPlaceholderText && self.boxInputCellProperty.cellPlaceholderText.length > 0;
        // 有占位字符
        if (hasPlaceholderText) {
            self.valueLabel.text = self.boxInputCellProperty.cellPlaceholderText;
            placeholderTextConfig();
        }
        else{// 空
            self.valueLabel.text = @"";
            defaultTextConfig();
        }
    }
}

- (void)hideCustomSecurityView{
    // 必须加上这个法官。否则_customSecurityView可能为空，并导致错误。
    if (self.customSecurityView) {
        self.customSecurityView.alpha = 0;
    }
}

#pragma mark - 自定义安全视图
- (void)showCustomSecurityView{
    if (!self.customSecurityView.superview) {
        [self.contentView addSubview:self.customSecurityView];
        self.customSecurityView.frame = self.cursorView.bounds;
    }
    self.customSecurityView.alpha = 1;
}

- (CABasicAnimation *)opacityAnimation{
    if (!_opacityAnimation) {
        _opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityAnimation.fromValue = @(1.0);
        _opacityAnimation.toValue = @(0.0);
        _opacityAnimation.duration = 0.9;
        _opacityAnimation.repeatCount = HUGE_VALF;
        _opacityAnimation.removedOnCompletion = YES;
        _opacityAnimation.fillMode = kCAFillModeForwards;
        _opacityAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    return _opacityAnimation;
}

- (void)setSelected:(BOOL)selected{
    if (selected) {
        self.layer.borderColor = self.boxInputCellProperty.cellBorderColorSelected.CGColor;
        self.backgroundColor = self.boxInputCellProperty.cellBgColorSelected;
    }else{
        BOOL hasFill = _valueLabel.text.length > 0 ? YES : NO;
        UIColor *cellBorderColor = self.boxInputCellProperty.cellBorderColorNormal;
        UIColor *cellBackgroundColor = self.boxInputCellProperty.cellBgColorNormal;
        if (hasFill) {
            if (self.boxInputCellProperty.cellBorderColorFilled) {
                cellBorderColor = self.boxInputCellProperty.cellBorderColorFilled;
            }
            if (self.boxInputCellProperty.cellBgColorFilled) {
                cellBackgroundColor = self.boxInputCellProperty.cellBgColorFilled;
            }
        }
        self.layer.borderColor = cellBorderColor.CGColor;
        self.backgroundColor = cellBackgroundColor;
    }
    
    if (_lineView) {
        // 未选中
        if (!selected) {
            if (self.boxInputCellProperty.originValue.length > 0 && self.lineView.underlineColorFilled) {
                // 有内容
                self.lineView.lineView.backgroundColor = self.lineView.underlineColorFilled;
            }else if (self.lineView.underlineColorNormal) {
                // 无内容
                self.lineView.lineView.backgroundColor = self.lineView.underlineColorNormal;
            }else{
                // 默认
                self.lineView.lineView.backgroundColor = TFY_ColorMaster;
            }
        }
        else if (selected && self.lineView.underlineColorSelected){// 已选中
            self.lineView.lineView.backgroundColor = self.lineView.underlineColorSelected;
        }
        else{// 默认
            self.lineView.lineView.backgroundColor = TFY_ColorMaster;
        }
        
        self.lineView.selected = selected;
    }
    
    if (self.ifNeedCursor) {
        if (selected) {
            self.cursorView.hidden= NO;
            [self.cursorView.layer addAnimation:self.opacityAnimation forKey:TFY_BoxCursoryAnimationKey];
        }else{
            self.cursorView.hidden= YES;
            [self.cursorView.layer removeAnimationForKey:TFY_BoxCursoryAnimationKey];
        }
    }else{
        self.cursorView.hidden= YES;
    }
}

- (void)setBoxInputCellProperty:(TFY_BoxInputCellProperty *)boxInputCellProperty{
    _boxInputCellProperty = boxInputCellProperty;
    
    self.cursorView.backgroundColor = boxInputCellProperty.cellCursorColor;
    
    self.cursorView.frame = CGRectMake(0, 0, boxInputCellProperty.cellCursorWidth, boxInputCellProperty.cellCursorHeight);
    self.cursorView.center = self.contentView.center;
    
    self.layer.cornerRadius = boxInputCellProperty.cornerRadius;
    self.layer.borderWidth = boxInputCellProperty.borderWidth;
    
    [self valueLabelLoadData];
}

- (UIView *)customSecurityView{
    if (!_customSecurityView) {
        if(self.boxInputCellProperty.customSecurityViewBlock){
            _customSecurityView = self.boxInputCellProperty.customSecurityViewBlock();
        }
    }
    return _customSecurityView;
}

- (void)layoutSubviews
{
    __weak typeof(self) weakSelf = self;
    
    if (self.boxInputCellProperty.showLine && !self.lineView) {
        self.lineView = _boxInputCellProperty.customLineViewBlock();
        [self.contentView addSubview:self.lineView];
        self.lineView.frame = CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width, 2);
    }
    
    if (self.boxInputCellProperty.configCellShadowBlock) {
        self.boxInputCellProperty.configCellShadowBlock(weakSelf.layer);
    }
    self.cursorView.frame = self.valueLabel.frame = self.bounds;
    [super layoutSubviews];
}

@end

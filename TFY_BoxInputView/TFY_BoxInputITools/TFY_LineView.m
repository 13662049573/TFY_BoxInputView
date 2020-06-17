//
//  TFY_LineView.m
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import "TFY_LineView.h"

static CGFloat sepLineViewHeight = 4;

@implementation TFY_LineView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.underlineColorNormal = TFY_ColorMaster;
        self.underlineColorSelected = TFY_ColorMaster;
        self.underlineColorFilled = TFY_ColorMaster;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lineView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.lineView.frame = CGRectMake(0, 0, self.frame.size.width, sepLineViewHeight);
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,sepLineViewHeight)];
        _lineView.backgroundColor = self.underlineColorNormal;
        _lineView.layer.cornerRadius = sepLineViewHeight/2;
        _lineView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
        _lineView.layer.shadowOpacity = 1;
        _lineView.layer.shadowOffset = CGSizeMake(0, 2);
        _lineView.layer.shadowRadius = 4;
    }
    return _lineView;
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;
    if (self.selectChangeBlock) {
        __weak __typeof(self)weakSelf = self;
        self.selectChangeBlock(weakSelf, selected);
    }
}

@end

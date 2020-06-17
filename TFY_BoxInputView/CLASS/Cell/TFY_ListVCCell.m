//
//  TFY_ListVCCell.m
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import "TFY_ListVCCell.h"

@interface TFY_ListVCCell ()
TFY_CATEGORY_STRONG_PROPERTY UIView *lineView;
TFY_CATEGORY_STRONG_PROPERTY UIImageView *imageViews;
TFY_CATEGORY_STRONG_PROPERTY UILabel *nameLabel;
@end

@implementation TFY_ListVCCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.tfy_LeftSpace(30).tfy_TopSpace(10).tfy_RightSpace(30).tfy_Height(20);
        
        [self.contentView addSubview:self.lineView];
        self.lineView.tfy_LeftSpaceEqualView(self.nameLabel).tfy_TopSpaceToView(0, self.nameLabel).tfy_size(TFY_Width_W/2, 2);
        
        [self.contentView addSubview:self.imageViews];
        self.imageViews.tfy_Center(0, 0).tfy_size(TFY_Width_W-60, 90);
        
    }
    return self;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = tfy_view();
        _lineView.backgroundColor = [UIColor blueColor];
    }
    return _lineView;
}

-(UIImageView *)imageViews{
    if (!_imageViews) {
        _imageViews = tfy_imageView();
    }
    return _imageViews;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = tfy_label();
        _nameLabel.tfy_textcolor(@"212121", 1).tfy_fontSize([UIFont systemFontOfSize:14]).tfy_alignment(0);
    }
    return _nameLabel;
}

#pragma mark - Load Data
- (void)loadDataWithModel:(TFY_BoxInputModel *)model{
    self.nameLabel.text = model.name;
    self.imageViews.image = [UIImage imageNamed:model.imageName];
}

@end

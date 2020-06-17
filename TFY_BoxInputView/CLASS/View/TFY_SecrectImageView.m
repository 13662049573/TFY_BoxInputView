//
//  TFY_SecrectImageView.m
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import "TFY_SecrectImageView.h"

@interface TFY_SecrectImageView ()
@property(nonatomic , strong)UIImageView *lockImgView;
@end

@implementation TFY_SecrectImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lockImgView];
        self.lockImgView.tfy_Center(0, 0).tfy_size(23, 27);
    }
    return self;
}


-(UIImageView *)lockImgView{
    if (!_lockImgView) {
        _lockImgView = [[UIImageView alloc] init];
        _lockImgView.image = [self tfy_fileImage:@"smallLock" fileName:nil];
        _lockImgView.userInteractionEnabled = YES;
    }
    return _lockImgView;
}

-(UIImage *)tfy_fileImage:(NSString *)fileImage fileName:(NSString *)fileName {
    return [UIImage imageWithContentsOfFile:[[[[NSBundle mainBundle] pathForResource:@"TFY_BoxInputImage" ofType:@"bundle"] stringByAppendingPathComponent:fileName] stringByAppendingPathComponent:fileImage]];
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.lockImgView.image = _image;
}

-(void)setSize:(CGSize)size{
    _size = size;

    self.lockImgView.tfy_Center(0, 0).tfy_size(_size.width, _size.height);
   
}

@end

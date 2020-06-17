//
//  TFY_BoxFlowLayout.m
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import "TFY_BoxFlowLayout.h"

@implementation TFY_BoxFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ifNeedEqualGap = YES;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minLineSpacing = 10;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsetsZero;
        self.itemNum = 1;
    }
    return self;
}

- (void)prepareLayout{
    if (_ifNeedEqualGap) {
        [self autoCalucateLineSpacing];
    }
    [super prepareLayout];
}

- (void)autoCalucateLineSpacing{
    if (self.itemNum > 1) {
        CGFloat width = CGRectGetWidth(self.collectionView.frame);
        self.minimumLineSpacing = floor(1.0 * (width - self.itemNum * self.itemSize.width - self.collectionView.contentInset.left - self.collectionView.contentInset.right) / (self.itemNum - 1));
        
        if (self.minimumLineSpacing < self.minLineSpacing) {
            self.minimumLineSpacing = self.minLineSpacing;
        }
    }else{
        self.minimumLineSpacing = 0;
    }
}

@end

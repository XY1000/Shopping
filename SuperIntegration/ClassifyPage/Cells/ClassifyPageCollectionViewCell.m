//
//  ClassifyPageCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/20.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ClassifyPageCollectionViewCell.h"

@implementation ClassifyPageCollectionViewCell

- (void)awakeFromNib {
    self.collectionViewCellImageView.layer.borderWidth = 0.5;
    self.collectionViewCellImageView.layer.borderColor = RGB(244, 245, 246).CGColor;
}

@end

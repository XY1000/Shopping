//
//  ClassifyPageBannerCollectionReusableView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/21.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ClassifyPageBannerCollectionReusableView.h"

@interface ClassifyPageBannerCollectionReusableView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewToLeftLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewToRightLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightLayoutConstraint;

@end

@implementation ClassifyPageBannerCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
    [self.imageViewToLeftLayoutConstraint setConstant:ClassifyPageCollectionViewCellMinimumInteritem];
    [self.imageViewToRightLayoutConstraint setConstant:ClassifyPageCollectionViewCellMinimumLine];
    [self.imageViewHeightLayoutConstraint setConstant:ClassifyPageCollectionViewBannerImageViewHeight];
}

@end

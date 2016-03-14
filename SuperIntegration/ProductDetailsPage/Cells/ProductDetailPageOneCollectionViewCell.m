//
//  ProductDetailPageOneCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ProductDetailPageOneCollectionViewCell.h"
#import "ProductDetailPageModel.h"

@interface ProductDetailPageOneCollectionViewCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBoreDistanceLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBorderDistanceLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelToBorderTopLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelToLabelTopLayoutConstraint;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation ProductDetailPageOneCollectionViewCell

- (void)awakeFromNib {
    [self.leftBoreDistanceLayoutConstraint setConstant:ProductDetailPage_LeftOrRightBorderDistance];
    [self.rightBorderDistanceLayoutConstraint setConstant:ProductDetailPage_LeftOrRightBorderDistance];
    [self.labelToBorderTopLayoutConstraint setConstant:ProductDetailPage_TopOrBottomBorderDistance];
    [self.labelToLabelTopLayoutConstraint setConstant:ProductDetailPage_TopLabelDistance];
}

- (void)cellWithModel:(ProductDetailPageModel *)model andPrice:(NSInteger)price {
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld", (long)price];
}

@end

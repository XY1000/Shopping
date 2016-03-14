//
//  PublicZeroCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "PublicZeroCollectionViewCell.h"
#import "SearchResultModel.h"
#import "OrderModel.h"
@interface PublicZeroCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelBottomToImageLayoutConstraint;

@end

@implementation PublicZeroCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.labelBottomToImageLayoutConstraint setConstant:-PublicZeroCellLabelValue];
}

- (void)cellWithModel:(SearchResultModel *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld", (long)model.price];
}

- (void)cellWithOrderModel:(OrderModelProductList *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld", (long)model.amount];
}

@end

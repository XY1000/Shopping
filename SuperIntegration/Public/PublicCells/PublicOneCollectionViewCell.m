//
//  PublicOneCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "PublicOneCollectionViewCell.h"
#import "SearchResultModel.h"
#import "GuessYouLikeModel.h"

@interface PublicOneCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightLayoutConstraint;
@end

@implementation PublicOneCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.imageViewHeightLayoutConstraint setConstant:PublicOneCellImageHeight];
}

- (void)cellWithModel:(SearchResultModel *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"place"]];
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld", (long)model.price];
}

- (void)cellWithGuessModel:(GuessYouLikeModel *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"place"]];
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld", (long)model.amount];
}

@end

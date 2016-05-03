//
//  OrderProductTableViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderProductTableViewCell.h"
#import "ShoppingCartPageModel.h"
#import "OrderModel.h"
@interface OrderProductTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
//订单详情
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelBottomToImageLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_ImageWidth;

@end

@implementation OrderProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.labelBottomToImageLayoutConstraint setConstant:-PublicZeroCellLabelValue];
    self.layout_ImageWidth.constant = (PublicZeroCellHeight - 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithModel:(ShoppingCartPageModel *)model {
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f", [model.price floatValue] * model.amount];
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"place"]];
    
}

- (void)cellWithOrderDetailModel:(OrderDetailModelProductList *)orderDetailModel {
    self.nameLabel.text = orderDetailModel.name;
    self.priceLabel.text = orderDetailModel.amount;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:orderDetailModel.image] placeholderImage:[UIImage imageNamed:@"place"]];
    self.numLabel.text = [NSString stringWithFormat:@"%ld", (long)orderDetailModel.num];
}

@end

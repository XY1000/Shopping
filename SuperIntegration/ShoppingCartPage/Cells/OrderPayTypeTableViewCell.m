//
//  OrderPayTypeTableViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderPayTypeTableViewCell.h"
#import "OrderModel.h"
@interface OrderPayTypeTableViewCell()


@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation OrderPayTypeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithOrderDetailModel:(OrderDetailModel *)orderDetailModel {
    self.typeLabel.text = orderDetailModel.payType;
}

@end

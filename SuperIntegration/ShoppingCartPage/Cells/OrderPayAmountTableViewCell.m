//
//  OrderPayAmountTableViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderPayAmountTableViewCell.h"

@interface OrderPayAmountTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *productPayAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *roadPayAmountLabel;

@end

@implementation OrderPayAmountTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithProductPrice:(NSString *)productPrice roadPrice:(CGFloat)roadPrice {
    self.productPayAmountLabel.text = [NSString stringWithFormat:@"%@分", productPrice];
    self.roadPayAmountLabel.text = [NSString stringWithFormat:@"%.2f分", roadPrice];
}

@end

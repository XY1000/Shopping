//
//  OrderDetailStateTableViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderDetailStateTableViewCell.h"

@interface OrderDetailStateTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;


@end

@implementation OrderDetailStateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithNumber:(NSString *)number State:(NSString *)state {
    self.orderNumberLabel.text = number;
    self.orderStateLabel.text = state;
}

@end

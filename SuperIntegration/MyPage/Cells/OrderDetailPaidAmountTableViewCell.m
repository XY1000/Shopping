//
//  OrderDetailPaidAmountTableViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderDetailPaidAmountTableViewCell.h"

@interface OrderDetailPaidAmountTableViewCell()


@property (weak, nonatomic) IBOutlet UILabel *paidAmountLabel;

@end

@implementation OrderDetailPaidAmountTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithPaidAmount:(NSString *)paidAmount {
    self.paidAmountLabel.text = [NSString stringWithFormat:@"%@分",paidAmount];
}

@end

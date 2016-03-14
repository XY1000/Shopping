//
//  ProductDetailPageWithAddressTableViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ProductDetailPageWithAddressTableViewCell.h"

@interface ProductDetailPageWithAddressTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *selectImage;

@end

@implementation ProductDetailPageWithAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)cellWithAddress:(NSString *)address andSelectedAddress:(NSString *)selectedAddress {
    self.addressLabel.text = address;
    if ([address isEqualToString:selectedAddress]) {
        self.addressLabel.textColor = RGB(204, 10, 42);
        self.selectImage.hidden = NO;
    } else {
        self.addressLabel.textColor = RGB(51, 51, 51);
        self.selectImage.hidden = YES;
    }
}

@end

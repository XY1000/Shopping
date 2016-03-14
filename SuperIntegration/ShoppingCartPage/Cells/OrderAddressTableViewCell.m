//
//  OrderAddressTableViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderAddressTableViewCell.h"
#import "AddressModel.h"
#import "OrderModel.h"
@interface OrderAddressTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressDesLabel;


@end

@implementation OrderAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithModel:(AddresslistModel *)model {
    self.model_Address = model;
    self.nameLabel.text = model.contact;
    self.phoneLabel.text = [NSString stringWithFormat:@"%@", [model.telephone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
    self.addressDesLabel.text = model.addressDetail;
    
    if (model.isDefault == 1) {
        [self.btn_Select setSelected:YES];
    } else {
        [self.btn_Select setSelected:NO];
    }
}

- (void)cellWithOrderDetailModel:(OrderDetailModel *)orderDetailModel {
    self.nameLabel.text = orderDetailModel.contact;
    self.phoneLabel.text = [NSString stringWithFormat:@"%@", [orderDetailModel.telephone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
    self.addressDesLabel.text = orderDetailModel.address;
}


/**
 *  地质管理
 */
- (IBAction)btn_SelectClicked:(id)sender {
//    if (self.btn_Select.selected) {
//        [self.btn_Select setSelected:NO];
//    } else {
//        [self.btn_Select setSelected:YES];
//    }
}

@end

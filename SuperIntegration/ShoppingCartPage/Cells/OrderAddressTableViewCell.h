//
//  OrderAddressTableViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddresslistModel;
//订单详情
@class OrderDetailModel;
@interface OrderAddressTableViewCell : UITableViewCell

@property (strong, nonatomic) AddresslistModel *model_Address;
@property (weak, nonatomic) IBOutlet UIButton *btn_Select;

- (void)cellWithModel:(AddresslistModel *)model;

- (void)cellWithOrderDetailModel:(OrderDetailModel *)orderDetailModel;
@end

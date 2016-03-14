//
//  OrderProductTableViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCartPageModel;
@class OrderDetailModelProductList;
@interface OrderProductTableViewCell : UITableViewCell

- (void)cellWithModel:(ShoppingCartPageModel *)model;


- (void)cellWithOrderDetailModel:(OrderDetailModelProductList *)orderDetailModel;
@end

//
//  OrderPayTypeTableViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderDetailModel;
@interface OrderPayTypeTableViewCell : UITableViewCell

- (void)cellWithOrderDetailModel:(OrderDetailModel *)orderDetailModel;

@end

//
//  OrderDetailTableViewController.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewController : UITableViewController

/**
 *  订单编号
 */
@property (copy, nonatomic) NSString *orderNumber;
/**
 *  订单状态
 */
@property (copy, nonatomic) NSString *orderState;
/**
 *  实付金额
 */
@property (copy, nonatomic) NSString *orderPaidAmount;
@end

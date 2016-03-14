//
//  OrderAddressManagerTableViewController.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/8.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddresslistModel;
@interface OrderAddressManagerTableViewController : UITableViewController

@property (copy, nonatomic) void(^block_DidSelectAddress)(AddresslistModel *model);

@end

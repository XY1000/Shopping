//
//  ProductDetailPageWithAddressTableViewController.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailPageWithAddressTableViewController : UITableViewController

@property (copy, nonatomic) NSString *addressString;
@property (copy, nonatomic) void(^backSelectAddressBlock)(NSArray *addressArray);

@end

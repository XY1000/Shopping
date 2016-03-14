//
//  ProductDetailPageWithAddressTableViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailPageWithAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

- (void)cellWithAddress:(NSString *)address andSelectedAddress:(NSString *)selectedAddress;

@end

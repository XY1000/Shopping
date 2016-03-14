//
//  AddressTableViewCell.h
//  SuperIntegration
//
//  Created by tmp on 16/1/28.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface AddressTableViewCell : UITableViewCell
@property(nonatomic,strong)AddresslistModel * listModel;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@end

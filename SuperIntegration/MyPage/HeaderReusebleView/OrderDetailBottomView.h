//
//  OrderDetailBottomView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailBottomView : UIView

@property (copy, nonatomic) void(^deleteOrderClickedBlock)();
@property (copy, nonatomic) void(^customerServiceClickedBlock)();
@property (copy, nonatomic) void(^againBuyClickedBlock)();
@end

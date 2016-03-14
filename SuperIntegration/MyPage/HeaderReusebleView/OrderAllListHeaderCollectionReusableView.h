//
//  OrderAllListHeaderCollectionReusableView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
@interface OrderAllListHeaderCollectionReusableView : UICollectionReusableView

- (void)viewWithModel:(OrderModel *)model;

@property (copy, nonatomic) void(^goDetailButtonClicked)(NSString *orderNumber, NSString *orderState);

@end

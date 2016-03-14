//
//  OrderAllListCollectionViewController.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    allOrderList = 1,
    unPayOrderList,
    unSendOrderList,
    unReceiveOrderList
}GetOrderType;

@interface OrderAllListCollectionViewController : UICollectionViewController

@property (assign, nonatomic) GetOrderType orderType;

@end

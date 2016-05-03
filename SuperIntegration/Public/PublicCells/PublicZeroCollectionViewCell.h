//
//  PublicZeroCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlipEditView.h"
@class SearchResultModel;
@class OrderModelProductList;


@interface PublicZeroCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) LeftSlipEditView *slipView;

//搜索
- (void)cellWithModel:(SearchResultModel *)model;
//订单
- (void)cellWithOrderModel:(OrderModelProductList *)model;


@end

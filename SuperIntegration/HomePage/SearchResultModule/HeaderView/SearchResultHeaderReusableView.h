//
//  SearchResultHeaderReusableView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/27.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultHeaderReusableView : UICollectionReusableView

//查询到的商品数组
@property (strong, nonatomic) NSArray *searchResultModelArray;
//价格排序
@property (copy, nonatomic) void(^block_PriceCompare)(NSArray *compareArray);
//筛选
@property (copy, nonatomic) void (^shaixuanClickedBlock)();

@end

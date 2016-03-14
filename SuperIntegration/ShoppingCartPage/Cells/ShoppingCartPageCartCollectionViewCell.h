//
//  ShoppingCartPageCartCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCartPageModel;
@interface ShoppingCartPageCartCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;
//修改购物车
@property (copy, nonatomic) void(^updateClickedBlock)(NSInteger cartId, NSInteger nowAmount);
//选择商品  返回选中数组中的个数
@property (copy, nonatomic) void(^selectedClickedBlock)(NSInteger selectedMArrayCount);
/**
 *  <#Description#>
 *
 *  @param model  <#model description#>
 *  @param MArray 不选择的购物车数组 
 */
- (void)cellWithModel:(ShoppingCartPageModel *)model andCellType:(CellType)cellType;

@end

//
//  ProductDetailPageBottomView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailPageBottomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btn_ShoppingCart;
@property (weak, nonatomic) IBOutlet UIButton *btn_Favorite;
@property (weak, nonatomic) IBOutlet UIButton *btn_CustomerService;
@property (weak, nonatomic) IBOutlet UIButton *btn_GoBuy;
@property (weak, nonatomic) IBOutlet UIButton *addShoppingCartButton;

/**
 *  //点击购物车
 */
@property (copy, nonatomic) void(^shoppingCartClickedBlock)();
/**
 *  点击关注
 */
@property (copy, nonatomic) void(^favoriteClickedBlock)();
/**
 *  点击客服
 */
@property (copy, nonatomic) void(^customServiceClickedBlock)();
/**
 *  点击立即购买
 */
@property (copy, nonatomic) void(^goBuyClickedBlock)();
/**
 *  点击添加购物车
 */
@property (copy, nonatomic) void(^addShoppingCartClickedBlock)();

@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;

@end

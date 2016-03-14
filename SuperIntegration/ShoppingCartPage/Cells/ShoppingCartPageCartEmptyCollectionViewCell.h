//
//  ShoppingCartPageCartEmptyCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartPageCartEmptyCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) void(^loginClickedBlock)();
@property (copy, nonatomic) void(^goShoppingClickedBlock)();


//根据是否登录判断是否隐藏登录按钮
- (void)isHiddenLoginButtonSuperView;

@end

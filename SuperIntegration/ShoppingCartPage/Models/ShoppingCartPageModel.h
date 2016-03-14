//
//  ShoppingCartPageModel.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartPageModel : NSObject

/**
 *  cartId
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  sku
 */
@property (copy, nonatomic) NSString *sku;
/**
 *  产品名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  图片
 */
@property (copy, nonatomic) NSString *image;
/**
 *  积分价格
 */
@property (assign, nonatomic) NSInteger price;
/**
 *  数量
 */
@property (assign, nonatomic) NSInteger amount;

+ (ShoppingCartPageModel *)modelWithDic:(NSDictionary *)dic;

@end

//
//  SearchResultModel.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/25.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "BaseModel.h"

@interface SearchResultModel : BaseModel

/**
 *  关注id
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
@property (copy, nonatomic) NSString *price;

@property (copy, nonatomic) NSString *amount;

//缓存的图片
@property (strong, nonatomic) UIImage *clipedImage;

+ (SearchResultModel *)modelWithDic:(NSDictionary *)dic;

@end

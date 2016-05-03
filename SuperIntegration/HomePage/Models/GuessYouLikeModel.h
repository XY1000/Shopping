//
//  GuessYouLikeModel.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/24.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "BaseModel.h"

@interface GuessYouLikeModel : BaseModel

/**
 *  id
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
@property (copy, nonatomic) NSString *amount;

/**
 *  裁剪后的图片
 */
@property (strong, nonatomic) UIImage *clipedImage;

+ (GuessYouLikeModel *)modelWithDic:(NSDictionary *)dic;

@end

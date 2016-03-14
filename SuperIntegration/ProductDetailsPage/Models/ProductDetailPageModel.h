//
//  ProductDetailPageModel.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/18.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "BaseModel.h"

@interface ProductDetailPageModel : BaseModel

/**
 *  商品编码
 */
@property (copy, nonatomic) NSString *sku;
/**
 *  主图地址
 */
@property (copy, nonatomic) NSString *image;
/**
 *  品牌
 */
@property (copy, nonatomic) NSString *brand;
/*
 *  商品名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  型号
 */
@property (copy, nonatomic) NSString *model;
/**
 *  重量
 */
@property (copy, nonatomic) NSString *weight;
/**
 *  上下架状态
 */
@property (copy, nonatomic) NSString *state;
/**
 *  产地
 */
@property (copy, nonatomic) NSString *productArea;
/**
 *  条形码
 */
@property (copy, nonatomic) NSString *upc;
/**
 *  销售单位
 */
@property (copy, nonatomic) NSString *saleUnit;
/**
 *  类别
 */
@property (copy, nonatomic) NSString *category;
/**
 *  html描述
 */
@property (copy, nonatomic) NSString *introduction;
@property (copy, nonatomic) NSString *externalEanCode;
@property (copy, nonatomic) NSString *service;
@property (assign, nonatomic) BOOL isSuccess;
@property (copy, nonatomic) NSString *returnMsg;
/**
 *  产品参数
 */
@property (strong, nonatomic) NSDictionary *param;

+ (ProductDetailPageModel *)modelWithDic:(NSDictionary *)dic;

@end


@interface ProductDetailPageWithImagesModel : BaseModel

@property (copy, nonatomic) NSString *path;
@property (copy, nonatomic) NSString *primary;

+ (ProductDetailPageWithImagesModel *)modelWithDic:(NSDictionary *)dic;

@end

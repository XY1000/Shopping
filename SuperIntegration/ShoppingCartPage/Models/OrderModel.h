//
//  OrderModel.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "BaseModel.h"

@interface OrderModel : BaseModel

/**
 *  订单id
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  订单编号
 */
@property (assign, nonatomic) NSInteger orderNumber;
/**
 *  下单时间
 */
@property (copy, nonatomic) NSString *createTime;
/**
 *  订单价格
 */
@property (copy, nonatomic) NSString *orderAmount;
/**
 *  订单状态
 */
@property (copy, nonatomic) NSString *status;
/**
 *  支付类型
 */
@property (copy, nonatomic) NSString *payType;
/**
 *  产品列表
 */
@property (strong, nonatomic) NSArray *productList;

+ (OrderModel *)modelWithDic:(NSDictionary *)dic;
@end

@interface OrderModelProductList : BaseModel

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
 *  价格
 */
@property (copy, nonatomic) NSString *amount;
/**
 *  数量
 */
@property (assign, nonatomic) NSInteger num;

+ (OrderModelProductList *)modelWithDic:(NSDictionary *)dic;

@end


/**
 *  订单详情
 */
@interface OrderDetailModel : BaseModel
/**
 *  收货人
 */
@property (copy, nonatomic) NSString *contact;
/**
 *  收货地址
 */
@property (copy, nonatomic) NSString *address;
/**
 *  省份id
 */
@property (copy, nonatomic) NSString *provinceId;
/**
 *  城市id
 */
@property (copy, nonatomic) NSString *cityId;
/**
 *  区id
 */
@property (copy, nonatomic) NSString *countyId;
/**
 *  乡镇id
 */
@property (copy, nonatomic) NSString *townId;
/**
 *  支付类型
 */
@property (copy, nonatomic) NSString *payType;
/**
 *  订单价格
 */
@property (copy, nonatomic) NSString *orderAmount;
/**
 *  手机号
 */
@property (copy, nonatomic) NSString *telephone;
@property (copy, nonatomic) NSString *phone;
/**
 *  产品列表
 */
@property (strong, nonatomic) NSArray *productList;
/**
 *  运费
 */
@property (assign, nonatomic) CGFloat freight;

+ (OrderDetailModel *)modelWithDic:(NSDictionary *)dic;
@end

@interface OrderDetailModelProductList : BaseModel

/**
 *  sku
 */
@property (copy, nonatomic) NSString *sku;
/**
 *  产品名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  积分价格
 */
@property (copy, nonatomic) NSString *amount;
/**
 *  产品数量
 */
@property (assign, nonatomic) NSInteger num;
@property (copy, nonatomic) NSString *image;
/**
 *  服务信息
 */
@property (copy, nonatomic) NSString *service;

+ (OrderDetailModelProductList *)modelWithDic:(NSDictionary *)dic;

@end

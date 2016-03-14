//
//  HomePageModel.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/20.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "BaseModel.h"

@interface HomePageBannerViewImageModel : BaseModel

/**
 *  app图片
 */
@property (strong, nonatomic) NSString *appPicUrl;
/**
 *  内容
 */
@property (strong, nonatomic) NSString *content;
/**
 *  id
 */
@property (strong, nonatomic) NSString *detailId;
/**
 *  点击跳转类型
 */
@property (strong, nonatomic) NSString *redirectType;

+ (HomePageBannerViewImageModel *)modelWithDic:(NSDictionary *)dic;

@end

@interface HomePageModel : BaseModel

/**
 *  app图片
 */
@property (strong, nonatomic) NSString *appPicUrl;
/**
 *  内容
 */
@property (strong, nonatomic) NSString *content;
/**
 *  id
 */
@property (strong, nonatomic) NSString *detailId;
/**
 *  点击跳转类型
 */
@property (strong, nonatomic) NSString *redirectType;


//特色馆 + 属性
@property (copy, nonatomic) NSString *sku;
@property (assign, nonatomic) NSInteger id;

+ (HomePageModel *)modelWithDic:(NSDictionary *)dic;

@end


@interface HomePageSpecialModel : BaseModel

/**
 *  显示类型
 */
@property (assign, nonatomic) NSInteger showType;
/**
 *  产品列表
 */
@property (strong, nonatomic) NSArray *list;
+ (HomePageSpecialModel *)modelWithDic:(NSDictionary *)dic;

@end


@interface HomePageChannelListModel : BaseModel

/**
 *  频道id
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  频道对应分类id
 */
@property (assign, nonatomic) NSInteger categoryD2Id;
/**
 *  频道名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  排序号
 */
@property (assign, nonatomic) NSInteger orderIndex;
/**
 *  产品列表
 */
@property (strong, nonatomic) NSArray *productList;
/**
 *  显示类型
 */
@property (assign, nonatomic) NSInteger showType;

+ (HomePageChannelListModel *)modelWithDic:(NSDictionary *)dic;

@end
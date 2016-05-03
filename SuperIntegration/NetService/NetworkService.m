//
//  NetworkService.m
//  iPolice
//
//  Created by ioswei on 15/6/7.
//  Copyright (c) 2015年 Bert. All rights reserved.
//

#import "NetworkService.h"
#import "HttpClient.h"
#import "ModelsHeader.h"
@class ProvinceModel,CityModel,DistrictModel,TownModel;

@interface NetworkService()

/** 网络请求客户端 */
@property (nonatomic, strong) HttpClient *restClient;

@end

@implementation NetworkService

/** 创建网络服务 */
+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static NetworkService *sharedInstance = nil;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark  首页
/**
 *  轮播
 */
- (void)getHomePageBannerImagesSuccess:(void (^)(NSMutableArray *))success
                               Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, homePage_BannerImages)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
                                   HomePageBannerViewImageModel *bannerViewimageModel = [HomePageBannerViewImageModel modelWithDic:dic];
                                   [mArray addObject:bannerViewimageModel];
                               }
                               success(mArray);
                           } else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  特色馆热销列表
 */
- (void)getHomePageSpecialHotListSuccess:(void (^)(NSMutableArray *))success
                                 Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, homePageSpecial_HotList)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               HomePageSpecialModel *specialModel = [HomePageSpecialModel modelWithDic:responseObject];
                               [mArray addObject:specialModel];
//                               for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
//                                   HomePageModel *specialModel = [HomePageModel modelWithDic:dic];
//                                   [mArray addObject:specialModel];
//                               }
                               success(mArray);
                           } else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}

/**
 *  首页频道列表
 */
- (void)getHomePageChannelListSuccess:(void (^)(NSMutableArray *))success
                              Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, homePageSpecial_ChannelList)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
                                   HomePageChannelListModel *channelListModel = [HomePageChannelListModel modelWithDic:dic];
                                   [mArray addObject:channelListModel];
                               }
                               success(mArray);
                           } else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  首页频道列表
 */
- (void)getGuessYouLikeListChannelId:(NSInteger)channelId
                              cityId:(NSInteger)cityId
                             Success:(void (^)(NSArray *))success
                             Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, GuessYouLike_List)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
                                   GuessYouLikeModel *model = [GuessYouLikeModel modelWithDic:dic];
                                   [mArray addObject:model];
                               }
                               success((NSArray *)mArray);
                           } else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
#pragma mark 产品
/**
 *  获得产品图片
 */
- (void)getProductDetailImagesWithProductSku:(NSString *)productSku
                                     Success:(void (^)(NSMutableArray *))success
                                     Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, productDetailPage_productImages)
                    parameters:@{@"sku":productSku}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               for (NSDictionary *dic in responseObject[@"imageList"][0][@"urls"]) {
                                   ProductDetailPageWithImagesModel *imagesModel = [ProductDetailPageWithImagesModel modelWithDic:dic];
                                   [mArray addObject:imagesModel.path];
                               }
                               success(mArray);
                           } else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  获得产品积分价格
 */
- (void)getProductDetailPriceWithProductSku:(NSString *)productSku
                                    Success:(void (^)(NSString *))success
                                    Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, productDetailPage_productPrice)
                    parameters:@{@"sku":productSku}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success(responseObject[@"amount"]);
                           } else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  获得产品详情
 */
- (void)getProductDetailWithProductSku:(NSString *)productSku
                               Success:(void (^)(NSMutableArray *))success
                               Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, productDetailPage_productData)
                    parameters:@{@"sku":productSku}
                       success:^(NSDictionary *responseObject) {
                           if ([responseObject[@"product"][@"isSuccess"] boolValue]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               ProductDetailPageModel *productDetailPageModel = [ProductDetailPageModel modelWithDic:responseObject[@"product"]];
                               [mArray addObject:productDetailPageModel];
                               success(mArray);
                           } else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:0
                                                                userInfo:@{@"errmsg":responseObject[@"product"][@"returnMsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}

#pragma mark 分类
- (void)getClassifyPageChannelListSuccess:(void (^)(NSMutableArray *))success
                                  Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, classifyPage_ChannelList)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               for (NSDictionary *dic in [responseObject objectForKey:@"channelList"]) {
                                   ClassifyPageChannelListModel *channelModel = [ClassifyPageChannelListModel modelWithDic:dic];
                                   [mArray addObject:channelModel];
                               }
                               success(mArray);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}

#pragma mark 推荐

#pragma mark 购物车
/**
 *  获得购物车列表
 */
- (void)getShoppingCartPageListSuccess:(void (^)(NSArray *))success
                               Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, shoppingCartPage_CartList)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
                                   ShoppingCartPageModel *model = [ShoppingCartPageModel modelWithDic:dic];
                                   [mArray addObject:model];
                               }
                               success((NSArray *)mArray);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  获得购物车数量
 */
- (void)getShoppingCartPageCartAmountSuccess:(void (^)(NSInteger))success
                                     Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, shoppingCartPage_CartAmount)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success((long)[[responseObject objectForKey:@"amount"] integerValue]);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  添加购物车
 */
- (void)postShoppingCartPageAddCartWithSku:(NSString *)sku
                                    Amount:(NSInteger)amount
                                   Success:(void (^)(NSInteger))success
                                   Failure:(void (^)(NSError *))failure
{
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, shoppingCartPage_AddCart)
                     parameters:@{@"sku":sku, @"amount":@(amount)}
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                success((long)[responseObject objectForKey:@"id"]);
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}

/**
 *  修改购物车
 */
- (void)putShoppingCartPageUpdateCartWithCartId:(NSInteger)cartId
                                         Amount:(NSInteger)amount
                                        Success:(void (^)())success
                                        Failure:(void (^)(NSError *))failure
{
    [HttpClient putJsonWithUrl:Send_Url(Root_Path, category_Api, shoppingCartPage_UpdateCart)
                    parameters:@{@"id":@(cartId), @"amount":@(amount)}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}

/**
 *  批量删除购物车
 */
- (void)postShoppingCartPageDeleteCartsWithIdList:(NSArray *)idList
                                          Success:(void (^)())success
                                          Failure:(void (^)(NSError *))failure
{
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, shoppingCartPage_DeleteCartArray)
                     parameters:@{@"idList":idList}
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                success();
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}
/**
 *  计算加运费
 */
- (void)getAddRoadPriceSuccess:(void (^)(NSDictionary *))success
                       Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, shoppingCartPage_addRoadPrice)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               
                               success(responseObject);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}

#pragma mark 订单
//产品库存
- (void)getProcuctInventoryWithProductSku:(NSString *)productSku
                               ProductNum:(NSInteger)productNum
                                   CityId:(NSString *)cityId
                                CountryId:(NSString *)countryId
                                  Success:(void (^)())success
                                  Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, OrderMoudle_queryInventory)
                    parameters:@{@"sku":productSku,@"num":@(productNum),@"cityId":cityId, @"countyId":countryId}
                       success:^(NSDictionary *responseObject) {
                           if ([responseObject[@"productInventory"][@"isSuccess"] boolValue]) {
//                               NSMutableArray *mArray = [NSMutableArray array];
                               if ([responseObject[@"productInventory"][@"state"] isEqualToString:@"00"]) {
                                   success();
                               } else {
                                   NSString *retutnMsg = @"";
                                   if ([responseObject[@"productInventory"][@"state"] isEqualToString:@"01"]) {
                                       retutnMsg = @"暂不销售";
                                   }
                                   if ([responseObject[@"productInventory"][@"state"] isEqualToString:@"02"]) {
                                       retutnMsg = @"库存不足";
                                   }
                                   NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                        code:0
                                                                    userInfo:@{@"errmsg":retutnMsg}];
                                   failure(error);
                               }
                              
                               
                           } else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:0
                                                                userInfo:@{@"errmsg":responseObject[@"productInventory"][@"returnMsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
//批量库存查询
- (void)getProcuctInventoryWithProductSkus:(NSArray *)productSkus
                                    CityId:(NSString *)cityId
                                   Success:(void (^)())success
                                   Failure:(void (^)(NSError *))failure
{
    NSString *str = [productSkus mj_JSONString];
    NSLog(@"批量查询%@", @{@"skus":productSkus,@"cityId":cityId});
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, OrderMoudle_queryInventoryArray)
                    parameters:@{@"cityId":cityId,@"skus":str}
                       success:^(NSDictionary *responseObject) {
                           if ([responseObject[@"productInventory"][@"isSuccess"] boolValue]) {
                               [self stateWithArray:responseObject[@"productInventory"][@"result"] Success:^{
                                
                                   success();
                               } Failure:^(NSString *state) {
                                   NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                        code:0
                                                                    userInfo:@{@"errmsg":state}];
                                   failure(error);
                               }];
                               
                               
                           } else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:0
                                                                userInfo:@{@"errmsg":responseObject[@"productInventory"][@"returnMsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
//创建订单
- (void)postOrderCreateWithAddressId:(NSInteger)addressId
                         ProductList:(NSArray *)productList
                             Success:(void (^)(NSDictionary *))success
                             Failure:(void (^)(NSError *))failure
{
    NSLog(@"%@", @{@"addressId":@(addressId), @"productList":productList});
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, OrderMoudle_CreateOrder)
                     parameters:@{@"addressId":@(addressId), @"productList":productList}
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                success(responseObject);
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}
//计算订单价格
- (void)postOrderCreateWithCityId:(NSInteger)cityId
                      ProductList:(NSArray *)productList
                          Success:(void (^)(NSDictionary *))success
                          Failure:(void (^)(NSError *))failure
{
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, OrderMoudle_getOrderPrice)
                     parameters:@{@"cityId":@(cityId), @"productList":productList}
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                success(responseObject);
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}
//订单支付
-  (void)postOrderPayWithOrderNumber:(NSString *)orderNumber
                         PayPassword:(NSString *)payPassword
                             Success:(void (^)())success
                             Failure:(void (^)(NSError *))failure
{
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, OrderMoudle_OrderPay)
                     parameters:@{@"orderNumber":orderNumber, @"payPassword":payPassword}
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                success();
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}
//全部订单
- (void)getOrderAllWithRows:(NSInteger)rows
                       Page:(NSInteger)page
                    Success:(void (^)(NSArray *))success
                    Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, OrderMoudle_AllOrder)
                    parameters:@{@"rows":@(rows), @"page":@(page)}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               for (NSDictionary *dic in responseObject[@"list"]) {
                                   OrderModel *model = [OrderModel modelWithDic:dic];
                                   [mArray addObject:model];
                               }
                               success(mArray);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
//未支付订单
- (void)getOrderUnpayWithRows:(NSInteger)rows
                         Page:(NSInteger)page
                      Success:(void (^)(NSArray *))success
                      Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, OrderMoudle_OrderUnPay)
                    parameters:@{@"rows":@(rows), @"page":@(page)}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               for (NSDictionary *dic in responseObject[@"list"]) {
                                   OrderModel *model = [OrderModel modelWithDic:dic];
                                   [mArray addObject:model];
                               }
                               success(mArray);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
//待发货订单
- (void)getOrderUnSendWithRows:(NSInteger)rows
                          Page:(NSInteger)page
                       Success:(void (^)(NSArray *))success
                       Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, OrderMoudle_OrderUnSend)
                    parameters:@{@"rows":@(rows), @"page":@(page)}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               for (NSDictionary *dic in responseObject[@"list"]) {
                                   OrderModel *model = [OrderModel modelWithDic:dic];
                                   [mArray addObject:model];
                               }
                               success(mArray);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
//订单详情
- (void)getOrderDetailWithOrderNumber:(NSString *)orderNumber
                              Success:(void (^)(NSArray *))success
                              Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, OrderMoudle_OrderDetail)
                    parameters:@{@"orderNumber":orderNumber}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               OrderDetailModel *model = [OrderDetailModel modelWithDic:responseObject[@"order"]];
                               [mArray addObject:model];
                               success(mArray);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
//订单积分
- (void)getOrderPayScoreWithOrderNumber:(NSString *)orderNumber
                                Success:(void (^)(NSDictionary *))success
                                Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, OrderMoudle_OrderSearchPayAmount)
                    parameters:@{@"orderNumber":orderNumber}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success(responseObject);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}

#pragma mark  我的
/**
 *  注册获得手机验证码
 */
- (void)getUserPhoneCodeWithPhone:(NSString *)phone
                          Success:(void (^)())success
                          Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_PhoneCode)
                    parameters:@{@"telephone":phone}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  注册验证码校验
 */
- (void)getUserValidateCodeWithPhone:(NSString *)phone
                                Code:(NSString *)code
                             Success:(void (^)())success
                             Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_CodeValidate)
                    parameters:@{@"telephone":phone, @"code":code}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  忘记密码获得验证码
 */
- (void)getForgetPasswordUserPhoneCodeWithPhone:(NSString *)phone
                                        Success:(void (^)())success
                                        Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_ForgetPasswordCode)
                    parameters:@{@"telephone":phone}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  忘记密码验证码校验
 */
- (void)getForgetPasswordUserValidateCodeWithPhone:(NSString *)phone
                                              Code:(NSString *)code
                                           Success:(void (^)())success
                                           Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_ForgetPasswordCodeValidate)
                    parameters:@{@"telephone":phone, @"code":code}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  忘记密码重置
 */
- (void)postForgetPasswordResetWithPassword:(NSString *)password
                                    Success:(void (^)())success
                                    Failure:(void (^)(NSError *))failure
{
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, myPage_ForgetPasswordReset)
                     parameters:@{@"password":password}
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                success();
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}
/**
 *  支付密码获得验证码
 */
- (void)getPayUserPhoneCodeWithPhone:(NSString *)phone
                             Success:(void (^)())success
                             Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_PayPhoneCode)
                    parameters:@{@"telephone":phone}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  支付密码验证码校验
 */
- (void)getPayUserValidateCodeWithPhone:(NSString *)phone
                                   Code:(NSString *)code
                                Success:(void (^)())success
                                Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_PayCodeValidate)
                    parameters:@{@"telephone":phone, @"code":code}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}

/**
 *  注册
 */
- (void)postUserRegisterInformationWithPhone:(NSString *)phone
                                    RealName:(NSString *)realName
                                         Sex:(NSInteger)sex
                                       Email:(NSString *)email
                                    Password:(NSString *)password
                                     Success:(void (^)())success
                                     Failure:(void (^)(NSError *))failure
{
    NSDictionary *params = @{@"telephone":phone, @"realname":realName, @"sex":@(sex), @"email":email, @"password":password};
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, myPage_UserRegister)
                     parameters:params
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                
                                DLog(@"注册responseObject = %@", responseObject);
                                SetObjectUserDefault(phone, @"username");
                                SetObjectUserDefault(@(1), @"isLogin");
                                
                                //获取用户信息
                                [self getUserInformationWithUserId:[responseObject objectForKey:@"id"] Success:^{
                                    success();
                                } Failure:^(NSError *error) {
                                    DLog(@"%@", error.description);
                                }];
                                
                                success();
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}
/**
 *  登录
 */
- (void)postUserLoginWithUsername:(NSString *)username
                         Password:(NSString *)password
                          Success:(void (^)())success
                          Failure:(void (^)(NSError *))failure
{
    NSDictionary *params = @{@"username":username, @"password":password};
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, myPage_UserLogin)
                     parameters:params
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                
                                DLog(@"登录成功responseObject = %@", responseObject);

                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
                                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",[[responseObject objectForKey:@"id"] integerValue]] forKey:@"userId"];
                                
                                
                                //当请求成共后调用如下代码, 保存Cookie
                                NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:Send_Url(Root_Path, category_Api, myPage_UserLogin)]];
                                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
                                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                NSLog(@"%@", str);
                                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"myCookies"];
                                
                                //获取用户信息
                                [self getUserInformationWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] Success:^{
                                    DLog(@"获取用户信息成功");
                                    
                                } Failure:^(NSError *error) {
                                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                }];
                                success();
                                
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}
/**
 *  获取用户信息
 */
- (void)getUserInformationWithUserId:(NSString *)userId
                             Success:(void (^)())success
                             Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_UserInformation)
                    parameters:@{@"userId":userId}
                       success:^(NSDictionary *responseObject) {
//                           DLog(@"获取用户信息%@",@{@"userId":userId});
                           if ([self isSucceed:responseObject]) {
                               if (STR_IS_NIL([responseObject objectForKey:@"nickname"])) {
                                   SetObjectUserDefault(@"用户名", @"nickname");
                               } else {
                                   SetObjectUserDefault([responseObject objectForKey:@"nickname"], @"nickname");
                               }
                               SetObjectUserDefault([responseObject objectForKey:@"sex"], @"sex");

                               //用户信息转换成模型
                               UserModel *model = [ModelManager getUserModel];
                               [model mj_setKeyValues:responseObject];
                               //[ModelManager saveUserInfoWithDic:responseObject];
                               
                               //获得该用户的购物车数量
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"cartAmount" object:nil];
                               
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  修改用户密码
 */
- (void)putUserChangePasswordWithOldPassword:(NSString *)oldPassword
                                 NewPassword:(NSString *)newPassword
                                     Success:(void (^)())success
                                     Failure:(void (^)(NSError *))failure
{
    [HttpClient putJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_UserChangePassword)
                    parameters:@{@"oldPassword":oldPassword, @"newPassword":newPassword}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  修改用户信息
 */
- (void)putUserChangeInformationWithRealName:(NSString *)realName
                                    NickName:(NSString *)nickName
                                         Sex:(NSInteger)sex
                                     Success:(void (^)())success
                                     Failure:(void (^)(NSError *))failure
{
    if (STR_IS_NIL(realName)) {
        realName = @"";
    }
    if (STR_IS_NIL(nickName)) {
        nickName = @"";
    }
    [HttpClient putJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_UserChangeInformation)
                    parameters:@{@"realname":realName, @"nickname":nickName, @"sex":@(sex)}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  修改手机号
 */
- (void)putUserChangePhoneWithTelephone:(NSString *)telephone
                                   Code:(NSString *)code
                                Success:(void (^)())success
                                Failure:(void (^)(NSError *))failure
{
    [HttpClient putJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_UserChangePhone)
                    parameters:@{@"telephone":telephone, @"code":code}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  修改邮箱
 */
- (void)putUserChangeEmailWithEmail:(NSString *)email
                            Success:(void (^)())success
                            Failure:(void (^)(NSError *))failure
{
    [HttpClient putJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_UserChangeEmail)
                    parameters:@{@"email":email}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success();
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  获取地址列表
 */
- (void)getUserAddressListSuccess:(void (^)(NSArray *))success
                          Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_AddressList)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               
                               success([responseObject objectForKey:@"addressList"]);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  添加地址
 */
- (void)postUserAddAddressWithTelephone:(NSString *)telephone
                                Contact:(NSString *)contact
                             ProvinceId:(NSString *)provinceId
                                 CityId:(NSString *)cityId
                               CountyId:(NSString *)countyId
                                 TownId:(NSString *)townId
                                   Name:(NSString *)name
                                  Email:(NSString *)email
                          AddressDetail:(NSString *)addressDetail
                                  Phone:(NSString *)phone
                           provinceName:(NSString *)provinceName
                               cityName:(NSString *)cityName
                             countyName:(NSString*)countyName
                               townName:(NSString*)townName
                                Success:(void (^)())success
                                Failure:(void (^)(NSError *))failure
{
    [HttpClient postJSONWithUrl:Send_Url(Root_Path , category_Api, myPage_AddAddress)
                     parameters:@{@"telephone":telephone, @"contact":contact, @"provinceId":provinceId, @"cityId":cityId, @"countyId":countyId, @"townId":townId, @"name":name, @"email":email, @"addressDetail":addressDetail, @"phone":phone,@"provinceName":provinceName,@"cityName":cityName,@"countyName":countyName,@"townName":townName}
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                success();
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                        code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}
/**
 *  删除地址
 */
- (void)deleteUserAddressWithAddressId:(NSInteger)addressId
                               Success:(void (^)())success
                               Failure:(void (^)(NSError *))failure
{
    DLog(@"addressId %ld",(long)addressId);
    NSLog(@"%@", Send_Url(Root_Path, category_Api, myPage_DeleteAddress));
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, myPage_DeleteAddress)
                     parameters:@{@"id":@(addressId)}
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                success();
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}

/**
 *  查询用户积分
 */
- (void)getUserQueryIntegralSuccess:(void (^)(NSString *))success
                            Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_QueryIntrgral)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success([responseObject objectForKey:@"amount"]);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  我的足迹
 */
- (void)getUserTraceListWithRows:(NSInteger)rows
                            Page:(NSInteger)page
                         Success:(void (^)(BOOL, NSArray *, NSArray *))success
                         Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_MyTraceList)
                    parameters:@{@"rows":@(rows), @"page":@(page)}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               
                               if ([responseObject[@"total"] integerValue] != 0) {
                                   //数据处理
                                   NSArray *allKeys = [[responseObject objectForKey:@"list"] allKeys];
                                   //数组排序
                                   allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                                       
                                       NSString *str1 = obj1;
                                       NSString *str2 = obj2;
                                       if ([str1 compare:str2 options:NSDiacriticInsensitiveSearch] == NSOrderedAscending) {
                                           return (NSComparisonResult)NSOrderedDescending;
                                       }
                                       if ([str1 compare:str2 options:NSDiacriticInsensitiveSearch] == NSOrderedDescending) {
                                           return (NSComparisonResult)NSOrderedAscending;
                                       }
                                       return (NSComparisonResult)NSOrderedSame;
                                       
                                   }];
//                                   NSMutableArray *allKeysMArray = [NSMutableArray arrayWithCapacity:allKeys.count];
//                                   for (NSString *str in allKeys) {
//                                       NSString *key = [str stringByReplacingOccurrencesOfString:@"-" withString:@"."];
//                                       [allKeysMArray addObject:key];
//                                   }
                                   NSLog(@"%@", allKeys);
                                   NSMutableArray *tmpArray1 = [NSMutableArray array];
                                   for (NSString *key in allKeys) {
                                       NSDictionary *dic = [[[responseObject objectForKey:@"list"] objectForKey:key] objectForKey:@"list"];
                                       NSArray *subAllKeys = [dic allKeys];
                                       NSMutableArray *subTmpArray = [NSMutableArray array];
                                       for (NSString *subKey in subAllKeys) {
                                           NSDictionary *subDic = [[[[responseObject objectForKey:@"list"] objectForKey:key] objectForKey:@"list"] objectForKey:subKey];
                                           SearchResultModel *footPrintModel = [SearchResultModel modelWithDic:subDic];
                                           [subTmpArray addObject:footPrintModel];
                                       }
                                       //                                   NSDictionary *dictory = @{@"time":key, @"productList":subTmpArray};
                                       [tmpArray1 addObject:subTmpArray];
                                   }
                                   
                                   success(YES,allKeys, (NSArray *)tmpArray1);
                               } else {
                                   success(NO,@[], @[]);
                               }
                               
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}

- (void)getUserTraceListCountSuccess:(void (^)(NSString *))success
                             Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_MyTraceListCount)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success([responseObject objectForKey:@"total"]);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}

- (void)getUserFavoriteListCountSuccess:(void (^)(NSString *))success
                                Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_MyFavoriteListCount)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success([responseObject objectForKey:@"total"]);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}

#pragma mark  积分充值
//获取充值金额
- (void)getRMBWithAmount:(NSInteger)amount
                 Success:(void (^)(NSString *))success
                 Failure:(void (^)(NSError *))failure
{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, myPage_GetRMB)
                    parameters:@{@"amount":@(amount)}
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               success([responseObject objectForKey:@"price"]);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
    
}
//充值积分
- (void)postRechargeWithAmount:(NSInteger)amount
                       Success:(void (^)(NSString *))success
                       Failure:(void (^)(NSError *))failure
{
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, myPage_IntegralRecharge)
                     parameters:@{@"amount":@(amount)}
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                NSDictionary *dic = [responseObject objectForKey:@"payUrl"];
                                NSLog(@"%@", [dic objectForKey:@"sessionid"]);
                                success([dic objectForKey:@"sessionid"]);
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}

#pragma mark 搜索
- (void)getSearchResultWithKeyWords:(NSString *)keyWords
                               Rows:(NSInteger)rows
                               Page:(NSInteger)page
                         CategoryId:(NSInteger)categoryId
                               Sort:(NSString *)sort
                              Order:(NSString *)order
                            Success:(void (^)(NSArray *))success
                            Failure:(void (^)(NSError *))failure
{
    NSDictionary *paramters = [NSDictionary dictionary];
    if (STR_IS_NIL(keyWords)) {
        keyWords = @"";
    }
    if (STR_IS_NIL(sort)) {
        sort = @"";
    }
    if (STR_IS_NIL(order)) {
        order = @"";
    }
    if (categoryId == 0) {
        paramters = @{@"keyword":keyWords, @"rows":@(rows), @"page":@(page), @"sort":sort, @"order":order};
    } else {
        paramters = @{@"keyword":keyWords, @"rows":@(rows), @"page":@(page), @"categoryId":@(categoryId), @"sort":sort, @"order":order};
    }
    NSLog(@"%@", paramters);
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, searchPage_Result)
                    parameters:paramters
                       success:^(NSDictionary *responseObject) {
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *mArray = [NSMutableArray array];
                               for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
                                   SearchResultModel *searchModel = [SearchResultModel modelWithDic:dic];
                                   [mArray addObject:searchModel];
                               }
                               success((NSArray *)mArray);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                       }];
}
/**
 *  搜索价格列表
 */
- (void)postSearchResultPriceListWithSkuList:(NSArray *)skuList
                                      CityId:(NSString *)cityId
                                     Success:(void (^)(NSArray *))success
                                     Failure:(void (^)(NSError *))failure
{
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, searchPage_ResultPriceList)
                     parameters:@{@"skuList":skuList, @"cityId":cityId}
                        success:^(NSDictionary *responseObject) {
                            if ([self isSucceed:responseObject]) {
                                success(responseObject[@"priceList"]);
                            }else{
                                NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                     code:[responseObject[@"errno"] integerValue]
                                                                 userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                failure(error);
                            }
                        } fail:^(NSError *error) {
                            NSError *err = [NSError errorWithDomain:@"网络错误"
                                                               code:0
                                                           userInfo:@{@"errmsg":@"网络异常"}];
                            failure(err);
                        }];
}

#pragma mark - 验证
-(BOOL)isSucceed:(NSDictionary *)dict{
    if ([dict[@"errno"]integerValue] == 0) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 地区列表

- (void)getProvinceDataSuccess:(void (^)(NSArray *))success Failure:(void (^)(NSError *))failure{
    
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, province) parameters:nil success:^(NSDictionary *responseObject) {
        
        if ([self isSucceed:responseObject]) {
            success(responseObject[@"province"]);
        }else{
            NSError *error = [NSError errorWithDomain:@"请求错误"
                                                 code:[responseObject[@"errno"] integerValue]
                                             userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
            failure(error);
        }

        
        
    } fail:^(NSError *error) {
        NSError *err = [NSError errorWithDomain:@"网络错误"
                                           code:0
                                       userInfo:@{@"errmsg":@"网络异常"}];
        failure(err);
        
    }];
}

- (void)getCityDataWithProvId:(NSString *)provId Success:(void (^)(NSArray *))success Failure:(void (^)(NSError *))failure{
    NSDictionary *dic = [NSDictionary dictionary];
    if (!STR_IS_NIL(provId)) {
        dic = @{
                              @"provinceId":provId
                              };
    }
    
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, city) parameters:dic success:^(NSDictionary *responseObject) {
        
        if ([self isSucceed:responseObject]) {
            
            success(responseObject[@"city"]);
            
        }else{
            NSError *error = [NSError errorWithDomain:@"请求错误"
                                                 code:[responseObject[@"errno"] integerValue]
                                             userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
            failure(error);
        }

        
    } fail:^(NSError *error) {
        NSError *err = [NSError errorWithDomain:@"网络错误"
                                           code:0
                                       userInfo:@{@"errmsg":@"网络异常"}];
        failure(err);
        
    }];
}

- (void)getDistrictDataWithCityId:(NSString *)cityId Success:(void (^)(NSArray *))success Failure:(void (^)(NSError *))failure{
    
    NSDictionary *dic = @{
                          @"cityId":cityId
                          };
    
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, district) parameters:dic success:^(NSDictionary *responseObject) {
        
        if ([self isSucceed:responseObject]) {
            
            success(responseObject[@"district"]);
            
        }else{
            NSError *error = [NSError errorWithDomain:@"请求错误"
                                                 code:[responseObject[@"errno"] integerValue]
                                             userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
            failure(error);
        }
        
    } fail:^(NSError *error) {
        NSError *err = [NSError errorWithDomain:@"网络错误"
                                           code:0
                                       userInfo:@{@"errmsg":@"网络异常"}];
        failure(err);
        
    }];
}

- (void)getTownDataWithCityId:(NSString *)cityId countyId:(NSString *)countyId Success:(void (^)(NSArray *))success Failure:(void (^)(NSError *))failure{
    
    NSDictionary *dic = @{
                          @"cityId":cityId,
                          @"countyId":countyId
                          };
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, town) parameters:dic success:^(NSDictionary *responseObject) {
        if ([self isSucceed:responseObject]) {
            
            success(responseObject[@"town"]);
            
        }else{
            NSError *error = [NSError errorWithDomain:@"请求错误"
                                                 code:[responseObject[@"errno"] integerValue]
                                             userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
            failure(error);
        }
        
        
    } fail:^(NSError *error) {
        
        NSError *err = [NSError errorWithDomain:@"网络错误"
                                           code:0
                                       userInfo:@{@"errmsg":@"网络异常"}];
        failure(err);
    }];
}

/**
 *  设置默认地址
 */
- (void)postAddressDefaultAddressId:(NSString *)addressId Success:(void (^)())success Failure:(void (^)(NSError *))failure{
    
    
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, addressDefault) parameters:@{@"id":@([addressId integerValue])} success:^(NSDictionary *responseObject) {
        
        if ([self isSucceed:responseObject]) {
            
            success();
        }else{
            
            NSError *error = [NSError errorWithDomain:@"请求错误"
                                                 code:[responseObject[@"errno"] integerValue]
                                             userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
            failure(error);
            
        }
        
        
    } fail:^(NSError *error) {
        NSError *err = [NSError errorWithDomain:@"网络错误"
                                           code:0
                                       userInfo:@{@"errmsg":@"网络异常"}];
        failure(err);
    }];
}

/**
 *
 *
 *  8.1 添加关注
 *
 *  @param sku 产品
 *  @param success   成功
 *  @param failure   失败
 */
- (void)favouriteCreate:(NSString *)sku
                Success:(void(^)())success
                Failure:(void(^)(NSError *error))failure{
    
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, favouriteCreate) parameters:@{@"sku":sku} success:^(NSDictionary *responseObject) {
        
        if ([self isSucceed:responseObject]) {
            
            success();
        }else{
            
            NSError *error = [NSError errorWithDomain:@"请求错误"
                                                 code:[responseObject[@"errno"] integerValue]
                                             userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
            failure(error);
            
        }
        
        
    } fail:^(NSError *error) {
        NSError *err = [NSError errorWithDomain:@"网络错误"
                                           code:0
                                       userInfo:@{@"errmsg":@"网络异常"}];
        failure(err);
    }];
}

/**
 *
 *
 *  8.2 删除关注
 *
 *  @param id 产品
 *  @param success   成功
 *  @param failure   失败
 */
- (void)favouriteDelete:(NSInteger)favoriteId
                Success:(void(^)())success
                Failure:(void(^)(NSError *error))failure{
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, favouriteDelete) parameters:@{@"id":@(favoriteId)} success:^(NSDictionary *responseObject) {
        
        if ([self isSucceed:responseObject]) {
            
            success();
        }else{
            
            NSError *error = [NSError errorWithDomain:@"请求错误"
                                                 code:[responseObject[@"errno"] integerValue]
                                             userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
            failure(error);
            
        }
        
        
    } fail:^(NSError *error) {
        NSError *err = [NSError errorWithDomain:@"网络错误"
                                           code:0
                                       userInfo:@{@"errmsg":@"网络异常"}];
        failure(err);
    }];
}

/**
 *
 *
 *  8.3 获取关注列表
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getFavouriteListSuccess:(void(^)(NSArray *responseObject))success
                        Failure:(void(^)(NSError *error))failure{
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, favouriteList)
                    parameters:nil
                       success:^(NSDictionary *responseObject) {
                           
                           if ([self isSucceed:responseObject]) {
                               NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:[responseObject[@"list"] count]];
                               for (NSDictionary *dic in responseObject[@"list"]) {
                                   SearchResultModel *followModel = [SearchResultModel modelWithDic:dic];
                                   [tmpArray addObject:followModel];
                               }
                               
                               success((NSArray *)tmpArray);
                           }else{
                               NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                    code:[responseObject[@"errno"] integerValue]
                                                                userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                               failure(error);
                           }
                           
                           
                           
                       } fail:^(NSError *error) {
                           NSError *err = [NSError errorWithDomain:@"网络错误"
                                                              code:0
                                                          userInfo:@{@"errmsg":@"网络异常"}];
                           failure(err);
                           
                       }];

}
//设置支付密码
- (void)postPayPasswordWith:(NSString *)password Success:(void (^)())success Failure:(void (^)(NSError *))failure{
    
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, payPassword) parameters:@{
                                                                                            @"payPassword":password
                                                                                            } success:^(NSDictionary *responseObject) {
                                                                                                
                                                                                                
                                                                                                if ([self isSucceed:responseObject]) {
                                                                                                    
                                                                                                    success();
                                                                                                }else{
                                                                                                    NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                                                                                         code:[responseObject[@"errno"] integerValue]
                                                                                                                                     userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                                                                                    failure(error);
                                                                                                }
                                                                                                
                                                                                                
                                                                                                
                                                                                            } fail:^(NSError *error) {
                                                                                                NSError *err = [NSError errorWithDomain:@"网络错误"
                                                                                                                                   code:0
                                                                                                                               userInfo:@{@"errmsg":@"网络异常"}];
                                                                                                failure(err);
                                                                                                
                                                                                            }];
    
    
}
//修改地址
- (void)putChangeAddressWithId:(NSInteger)id1
                     telephone:(NSString *)telephone
                       contact:(NSString *)contact
                    provinceId:(NSString *)provinceId
                        cityId:(NSString *)cityId
                      countyId:(NSString *)countyId
                        townId:(NSString *)townId
                          name:(NSString *)name
                         Email:(NSString *)email
                 addressDetail:(NSString *)addressDetail
                         Phone:(NSString *)phone
                  provinceName:(NSString *)provinceName
                      cityName:(NSString *)cityName
                    countyName:(NSString*)countyName
                      townName:(NSString*)townName
                       Success:(void (^)())success Failure:(void (^)(NSError *))failure{
    
    
    [HttpClient putJsonWithUrl:Send_Url(Root_Path, category_Api, ChangeAddress) parameters:@{@"id":@(id1),
                                                                                             @"telephone":telephone, @"contact":contact, @"provinceId":provinceId, @"cityId":cityId, @"countyId":countyId, @"townId":townId,
                                                        @"name":name,
                                                                                             @"email":email,                              @"addressDetail":addressDetail,
                                                                                             @"phone":phone,
                                                                                             @"provinceName":provinceName,
                                                                                             @"cityName":cityName,
                                                                                             @"countyName":countyName,
                                                                                             @"townName":townName
                                                                                             }success:^(NSDictionary *responseObject) {
                                                                                       
                                                                                                 if ([self isSucceed:responseObject]) {
                                                                                                     success();
                                                                                                 }else{
                                                                                                     NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                                                                                          code:[responseObject[@"errno"] integerValue]
                                                                                                                                      userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                                                                                     failure(error);
                                                                                                 }
                                                                                                 
                                                                                                 
                                                                                                 
                                                                                             } fail:^(NSError *error) {
                                                                                                
                                                                                                 NSError *err = [NSError errorWithDomain:@"网络错误"
                                                                                                                                    code:0
                                                                                                                                userInfo:@{@"errmsg":@"网络异常"}];
                                                                                                 failure(err);
                                                                                                 
                                                                                                 
                                                                                             }];
    
    
    
}

- (void)stateWithArray:(NSArray *)array Success:(void(^)())success Failure:(void(^)(NSString *state))failure{
    NSMutableArray *unProductSkuArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        if ([dic[@"state"] integerValue] != 0) {
            [unProductSkuArray addObject:dic[@"skuId"]];
        }
    }
    if (ARRAY_IS_NIL(unProductSkuArray)) {
        success();
    } else {
        failure(@"商品库存为0!");
    }
}

//邮箱校验
- (void)postCheckEmailWithEmail:(NSString *)email Success:(void (^)())success Failure:(void (^)(NSError *))failure {
    
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, checkEmail)
                     parameters:@{
                                    @"email":email
                                                                                           }
                        success:^(NSDictionary *responseObject) {
                                                                                               
                                                                                               if ([self isSucceed:responseObject]) {
                                                                                                   
                                                                                                   success();
                                                                                               }else{
                                                                                                   NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                                                                                        code:[responseObject[@"errno"] integerValue]
                                                                                                                                    userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                                                                                   failure(error);
                                                                                               }
                                                                                               
                                                                                               
                                                                                               
                                                                                           } fail:^(NSError *error) {
                                                                                              
                                                                                               NSError *err = [NSError errorWithDomain:@"网络错误"
                                                                                                                                  code:0
                                                                                                                              userInfo:@{@"errmsg":@"网络异常"}];
                                                                                               failure(err);
                                                                                               
                                                                                               
                                                                                           }];
    
}

//手机校验
- (void)postCheckTelephoneWithTelephone:(NSString *)telephone Success:(void (^)())success Failure:(void (^)(NSError *))failure {
    [HttpClient postJSONWithUrl:Send_Url(Root_Path, category_Api, checkTelephone)
                     parameters:@{@"telephone":telephone} success:^(NSDictionary *responseObject) {
                        
                         if ([self isSucceed:responseObject]) {
                             
                             success();
                         }else{
                             NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                  code:[responseObject[@"errno"] integerValue]
                                                              userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                             failure(error);
                         }
                         
                         
                     } fail:^(NSError *error) {
                         
                         
                         NSError *err = [NSError errorWithDomain:@"网络错误"
                                                            code:0
                                                        userInfo:@{@"errmsg":@"网络异常"}];
                         failure(err);
                         
                     }];
}


// 修改邮箱验证码
- (void)getChangeEmailCodeWithTelephone:(NSString *)telephone Success:(void (^)())success Failure:(void (^)(NSError *))failure {
    
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, emailCode)
                    parameters:@{@"telephone":telephone} success:^(NSDictionary *responseObject) {
                        
                        if ([self isSucceed:responseObject]) {
                            
                            success();
                        }else{
                            NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                 code:[responseObject[@"errno"] integerValue]
                                                             userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                            failure(error);
                        }
                        
                        
                        
                    } fail:^(NSError *error) {
                        
                        NSError *err = [NSError errorWithDomain:@"网络错误"
                                                           code:0
                                                       userInfo:@{@"errmsg":@"网络异常"}];
                        failure(err);
                        
                        
                    }];
    
    
}


//修改手机号验证码
- (void)getChangeTelephoneCodeWithTelephone:(NSString *)telephone Success:(void (^)())success Failure:(void (^)(NSError *))failure {
    
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, telephoneCode)
                    parameters:@{@"telephone":telephone} success:^(NSDictionary *responseObject) {
                        
                        if ([self isSucceed:responseObject]) {
                            
                            success();
                        }else{
                            NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                 code:[responseObject[@"errno"] integerValue]
                                                             userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                            failure(error);
                        }
                        
                        
                        
                    } fail:^(NSError *error) {
                        
                        NSError *err = [NSError errorWithDomain:@"网络错误"
                                                           code:0
                                                       userInfo:@{@"errmsg":@"网络异常"}];
                        failure(err);
                    }];

}

//修改邮箱验证码校验
- (void)getCheckEmailCodelWithCode:(NSString *)code telephone:(NSString *)phone Success:(void (^)())success Failure:(void (^)(NSError *))failure {
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, checkTelephoneCode)
                    parameters:@{
                                 @"telephone":phone,
                                 @"code":code
                                 }success:^(NSDictionary *responseObject) {
                                     
                                     if ([self isSucceed:responseObject]) {
                                         
                                         success();
                                     }else{
                                         NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                              code:[responseObject[@"errno"] integerValue]
                                                                          userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                         failure(error);
                                     }
 
                                     
                                     
                                 } fail:^(NSError *error) {
                                    
                                     NSError *err = [NSError errorWithDomain:@"网络错误"
                                                                        code:0
                                                                    userInfo:@{@"errmsg":@"网络异常"}];
                                     failure(err);
                                 }];
}

//修改手机号验证码校验
- (void)getCheckTelephoneCodelWithCode:(NSString *)code telephone:(NSString *)phone Success:(void (^)())success Failure:(void (^)(NSError *))failure {
    
    
    [HttpClient getJsonWithUrl:Send_Url(Root_Path, category_Api, checkTelephoneCode)
                    parameters:@{
                                 @"telephone":phone,
                                 @"code":code
                                 }success:^(NSDictionary *responseObject) {
                                     
                                     if ([self isSucceed:responseObject]) {
                                         
                                         success();
                                     }else{
                                         NSError *error = [NSError errorWithDomain:@"请求错误"
                                                                              code:[responseObject[@"errno"] integerValue]
                                                                          userInfo:@{@"errmsg":responseObject[@"errmsg"]}];
                                         failure(error);
                                     }
                                     
                                 } fail:^(NSError *error) {
                                     
                                     NSError *err = [NSError errorWithDomain:@"网络错误"
                                                                        code:0
                                                                    userInfo:@{@"errmsg":@"网络异常"}];
                                     failure(err);
                                     
                                 }];
    
    
}


@end

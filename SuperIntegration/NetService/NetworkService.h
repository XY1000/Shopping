//
//  NetworkService.h
//  iPolice
//
//  Created by ioswei on 15/6/7.
//  Copyright (c) 2015年 Bert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetAPIHeader.h"
@interface NetworkService : NSObject

/**
 *  创建网络服务
 *
 *  @return 网络服务(单例)
 */
+(instancetype)sharedInstance;

#pragma mark 首页
/**
 *  首页轮播广告
 *
 *  @param success 返回数组
 *  @param failure 返回错误信息
 */
- (void)getHomePageBannerImagesSuccess:(void(^)(NSMutableArray *responseObject))success
                               Failure:(void(^)(NSError *error))failure;

/**
 *  首页特色馆
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getHomePageSpecialHotListSuccess:(void(^)(NSMutableArray *responseObject))success
                                 Failure:(void(^)(NSError *error))failure;

/**
 *  首页频道列表
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getHomePageChannelListSuccess:(void(^)(NSMutableArray *responseObject))success
                              Failure:(void(^)(NSError *error))failure;

/**
 *  猜你喜欢列表
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getGuessYouLikeListChannelId:(NSInteger)channelId
                              cityId:(NSInteger)cityId
                             Success:(void(^)(NSArray *responseObject))success
                           Failure:(void(^)(NSError *error))failure;
#pragma mark 产品
/**
 *  获得产品图片
 *
 *  @param productSku 产品sku
 *  @param success    图片数组
 *  @param failure    失败
 */
- (void)getProductDetailImagesWithProductSku:(NSString *)productSku
                                     Success:(void(^)(NSMutableArray *responseObject))success
                                     Failure:(void(^)(NSError *error))failure;
/**
 *  获得产品积分价格
 *
 *  @param productSku 产品sku
 *  @param success    价格
 *  @param failure    失败
 */
- (void)getProductDetailPriceWithProductSku:(NSString *)productSku
                                     Success:(void(^)(NSString *responseObject))success
                                     Failure:(void(^)(NSError *error))failure;
/**
 *  获得产品详情
 *
 *  @param productSku 产品sku
 *  @param success    成功
 *  @param failure    失败
 */
- (void)getProductDetailWithProductSku:(NSString *)productSku
                               Success:(void(^)(NSMutableArray *responseObject))success
                               Failure:(void(^)(NSError *error))failure;


#pragma mark 分类
/**
 *  分类页面各个分类
 *
 *  @param success 返回数组
 *  @param failure 返回错误信息
 */
- (void)getClassifyPageChannelListSuccess:(void(^)(NSMutableArray *responseObject))success
                                  Failure:(void(^)(NSError *error))failure;


#pragma mark 推荐

#pragma mark 购物车
/**
 *  获得购物车列表
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getShoppingCartPageListSuccess:(void(^)(NSArray *responseObject))success
                               Failure:(void(^)(NSError *error))failure;

/**
 *  获得购物车数量
 *
 *  @param success 成功返回数量
 *  @param failure 失败
 */
- (void)getShoppingCartPageCartAmountSuccess:(void(^)(NSInteger responseObject))success
                                     Failure:(void(^)(NSError *error))failure;

/**
 *  添加购物车
 *
 *  @param sku     sku
 *  @param amount  数量
 *  @param success 成功返回购物车id
 *  @param failure 失败
 */
- (void)postShoppingCartPageAddCartWithSku:(NSString *)sku
                                    Amount:(NSInteger)amount
                                   Success:(void(^)(NSInteger responseObject))success
                                   Failure:(void(^)(NSError *error))failure;

/**
 *  修改购物车
 *
 *  @param cartId  购物车id
 *  @param amount  数量
 *  @param success 成功
 *  @param failure 失败
 */
- (void)putShoppingCartPageUpdateCartWithCartId:(NSInteger)cartId
                                         Amount:(NSInteger)amount
                                        Success:(void(^)())success
                                        Failure:(void(^)(NSError *error))failure;

/**
 *  批量删除购物车
 *
 *  @param idList  购物车id数组
 *  @param success 成功
 *  @param failure 失败
 */
- (void)postShoppingCartPageDeleteCartsWithIdList:(NSArray *)idList
                                          Success:(void(^)())success
                                          Failure:(void(^)(NSError *error))failure;

/**
 *  计算加运费
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getAddRoadPriceSuccess:(void(^)(NSDictionary *responseObject))success
                       Failure:(void(^)(NSError *error))failure;

#pragma mark 订单
/**
 *   查询商品库存
 *
 *  @param productSku sku
 *  @param productNum 数量
 *  @param cityId     城市id
 *  @param countryId  区id
 *  @param success    成功
 *  @param failure    失败
 */
- (void)getProcuctInventoryWithProductSku:(NSString *)productSku
                               ProductNum:(NSInteger)productNum
                                   CityId:(NSString *)cityId
                                CountryId:(NSString *)countryId
                                  Success:(void(^)())success
                                  Failure:(void(^)(NSError *error))failure;

/**
 *  批量库存查询
 *
 *  @param productSkus sku数组
 *  @param cityId      城市id
 *  @param success     成功
 *  @param failure     失败
 */
- (void)getProcuctInventoryWithProductSkus:(NSArray *)productSkus
                                    CityId:(NSString *)cityId
                                   Success:(void(^)())success
                                   Failure:(void(^)(NSError *error))failure;

/**
 *  创建订单
 *
 *  @param addressId   地址id
 *  @param productList 产品数组
 *  @param success     成功
 *  @param failure     失败
 */
- (void)postOrderCreateWithAddressId:(NSInteger)addressId
                         ProductList:(NSArray *)productList
                             Success:(void(^)(NSDictionary *responseObject))success
                             Failure:(void(^)(NSError *error))failure;

/**
 *  计算订单价格
 *
 *  @param cityId      城市id
 *  @param productList 商品数组
 *  @param success     成功
 *  @param failure     失败
 */
- (void)postOrderCreateWithCityId:(NSInteger)cityId
                         ProductList:(NSArray *)productList
                             Success:(void(^)(NSDictionary *responseObject))success
                             Failure:(void(^)(NSError *error))failure;
/**
 *  订单支付
 *
 *  @param orderNumber 订单编号
 *  @param payPassword 支付密码
 *  @param success     成功
 *  @param failure     失败
 */
- (void)postOrderPayWithOrderNumber:(NSString *)orderNumber
                        PayPassword:(NSString *)payPassword
                            Success:(void(^)())success
                            Failure:(void(^)(NSError *error))failure;

/**
 *  全部订单
 *
 *  @param rows    分页行数
 *  @param page    分页页数
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getOrderAllWithRows:(NSInteger)rows
                       Page:(NSInteger)page
                    Success:(void(^)(NSArray *responseObject))success
                    Failure:(void(^)(NSError *error))failure;

/**
 *  未支付订单
 *
 *  @param rows    分页行数
 *  @param page    分页页数
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getOrderUnpayWithRows:(NSInteger)rows
                         Page:(NSInteger)page
                      Success:(void(^)(NSArray *responseObject))success
                      Failure:(void(^)(NSError *error))failure;

/**
 *  待发货订单
 *
 *  @param rows    分页行数
 *  @param page    分页页数
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getOrderUnSendWithRows:(NSInteger)rows
                          Page:(NSInteger)page
                       Success:(void(^)(NSArray *responseObject))success
                       Failure:(void(^)(NSError *error))failure;


/**
 *  订单详情
 *
 *  @param orderNumber 订单编号
 *  @param success     成功
 *  @param failure     失败
 */
- (void)getOrderDetailWithOrderNumber:(NSString *)orderNumber
                              Success:(void(^)(NSArray *responseObject))success
                              Failure:(void(^)(NSError *error))failure;

/**
 *  查询订单积分
 *
 *  @param orderNumber 订单编号
 *  @param success     成功
 *  @param failure     失败
 */
- (void)getOrderPayScoreWithOrderNumber:(NSString *)orderNumber
                                Success:(void(^)(NSDictionary *responseObject))success
                                Failure:(void(^)(NSError *error))failure;

#pragma mark 我的
/**
 *  注册获得手机验证码
 *
 *  @param phone   手机号
 *  @param success 返回正确
 *  @param failure 返回错误信息
 */
- (void)getUserPhoneCodeWithPhone:(NSString *)phone
                          Success:(void(^)())success
                          Failure:(void(^)(NSError *error))failure;
/**
 *  注册手机验证码校验
 *
 *  @param phone   手机号
 *  @param code    验证码
 *  @param success 返回正确
 *  @param failure 返回错误信息
 */
- (void)getUserValidateCodeWithPhone:(NSString *)phone
                                Code:(NSString *)code
                             Success:(void(^)())success
                             Failure:(void(^)(NSError *error))failure;
/**
 *  忘记密码获得手机验证码
 *
 *  @param phone   手机号
 *  @param success 返回正确
 *  @param failure 返回错误信息
 */
- (void)getForgetPasswordUserPhoneCodeWithPhone:(NSString *)phone
                                        Success:(void(^)())success
                                        Failure:(void(^)(NSError *error))failure;
/**
 *  忘记密码手机验证码校验
 *
 *  @param phone   手机号
 *  @param code    验证码
 *  @param success 返回正确
 *  @param failure 返回错误信息
 */
- (void)getForgetPasswordUserValidateCodeWithPhone:(NSString *)phone
                                              Code:(NSString *)code
                                           Success:(void(^)())success
                                           Failure:(void(^)(NSError *error))failure;

/**
 *  忘记密码重置
 *
 *  @param password 密码
 *  @param success  成功
 *  @param failure  失败
 */
- (void)postForgetPasswordResetWithPassword:(NSString *)password
                                    Success:(void(^)())success
                                    Failure:(void(^)(NSError *error))failure;

/**
 *  支付密码获得手机验证码
 *
 *  @param phone   手机号
 *  @param success 返回正确
 *  @param failure 返回错误信息
 */
- (void)getPayUserPhoneCodeWithPhone:(NSString *)phone
                                        Success:(void(^)())success
                                        Failure:(void(^)(NSError *error))failure;
/**
 *  支付密码手机验证码校验
 *
 *  @param phone   手机号
 *  @param code    验证码
 *  @param success 返回正确
 *  @param failure 返回错误信息
 */
- (void)getPayUserValidateCodeWithPhone:(NSString *)phone
                                              Code:(NSString *)code
                                           Success:(void(^)())success
                                           Failure:(void(^)(NSError *error))failure;
/**
 *  注册
 *
 *  @param phone    手机号
 *  @param realName 真实姓名
 *  @param sex      性别
 *  @param email    邮箱
 *  @param password 密码
 *  @param success  成功
 *  @param failure  失败
 */
- (void)postUserRegisterInformationWithPhone:(NSString *)phone
                                    RealName:(NSString *)realName
                                         Sex:(NSInteger)sex
                                       Email:(NSString *)email
                                    Password:(NSString *)password
                                     Success:(void(^)())success
                                     Failure:(void(^)(NSError *error))failure;

/**
 *  登录
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param success  成功
 *  @param failure  失败
 */
- (void)postUserLoginWithUsername:(NSString *)username
                         Password:(NSString *)password
                          Success:(void(^)())success
                          Failure:(void(^)(NSError *error))failure;

/**
 *  获取用户信息
 *
 *  @param userId  用户id
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getUserInformationWithUserId:(NSString *)userId
                             Success:(void(^)())success
                             Failure:(void(^)(NSError *error))failure;

/**
 *  修改用户密码
 *
 *  @param oldPassword 旧密码
 *  @param newPassword 新密码
 *  @param success     成功
 *  @param failure     失败
 */
- (void)putUserChangePasswordWithOldPassword:(NSString *)oldPassword
                                 NewPassword:(NSString *)newPassword
                                     Success:(void(^)())success
                                     Failure:(void(^)(NSError *error))failure;

/**
 *  修改用户信息
 *
 *  @param realName 真实姓名
 *  @param nickName 昵称
 *  @param sex      性别
 *  @param success  成功
 *  @param failure  失败
 */
- (void)putUserChangeInformationWithRealName:(NSString *)realName
                                    NickName:(NSString *)nickName
                                         Sex:(NSInteger )sex
                                     Success:(void(^)())success
                                     Failure:(void(^)(NSError *error))failure;

/**
 *  修改手机号
 *
 *  @param telephone 手机号
 *  @param code      验证码
 *  @param success   成功
 *  @param failure   失败
 */
- (void)putUserChangePhoneWithTelephone:(NSString *)telephone
                                   Code:(NSString *)code
                                Success:(void(^)())success
                                Failure:(void(^)(NSError *error))failure;

/**
 *  修改邮箱
 *
 *  @param email   邮箱
 *  @param success 成功
 *  @param failure 失败
 */
- (void)putUserChangeEmailWithEmail:(NSString *)email
                            Success:(void(^)())success
                            Failure:(void(^)(NSError *error))failure;

/**
 *  获取地址列表
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getUserAddressListSuccess:(void(^)(NSArray *responseObject))success
                          Failure:(void(^)(NSError *error))failure;

/**
 *  @author hxy
 *
 *  添加地址
 *
 *  @param telephone     手机号
 *  @param contact       联系人姓名
 *  @param provinceId    省份id
 *  @param cityId        城市id
 *  @param countyId      区id
 *  @param townId        乡镇id
 *  @param name          地址标签(家..公司)
 *  @param email         email地址
 *  @param addressDetail 地址详情
 *  @param phone         家庭电话
 *  @param provinceName  省份名称
 *  @param cityName      城市名称
 *  @param countyName    区名称
 *  @param townName      乡镇名称
 *  @param success       成功
 *  @param failure       失败
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
                                Success:(void(^)())success
                                Failure:(void(^)(NSError *error))failure;


/**
 *  删除地址
 *
 *  @param addressId 地址id
 *  @param success   成功
 *  @param failure   失败 
 */
- (void)deleteUserAddressWithAddressId:(NSInteger)addressId
                               Success:(void(^)())success
                               Failure:(void(^)(NSError *error))failure;

/**
 *  获得用户积分
 *
 *  @param success 成功返回积分
 *  @param failure 失败
 */
- (void)getUserQueryIntegralSuccess:(void(^)(NSString *integral))success
                       Failure:(void(^)(NSError *error))failure;


/**
 *  获得用户足迹
 *
 *  @param rows    分页行数
 *  @param page    分页页数
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getUserTraceListWithRows:(NSInteger)rows
                            Page:(NSInteger)page
                         Success:(void(^)(BOOL isHas, NSArray *timeArray, NSArray *productArray))success
                         Failure:(void(^)(NSError *error))failure;

/**
 *  获取用户足迹个数
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getUserTraceListCountSuccess:(void(^)(NSString *responseObject))success
                             Failure:(void(^)(NSError *error))failure;

/**
 *  获取用户关注个数
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getUserFavoriteListCountSuccess:(void(^)(NSString *responseObject))success
                             Failure:(void(^)(NSError *error))failure;

#pragma mark  积分充值
/**
 *  获取充值金额
 *
 *  @param amount  充值的积分
 *  @param success 成功返回金额
 *  @param failure 失败
 */
- (void)getRMBWithAmount:(NSInteger)amount
                 Success:(void(^)(NSString *RMB))success
                 Failure:(void(^)(NSError *error))failure;

/**
 *  充值积分
 *
 *  @param amount  充值的积分
 *  @param success 成功返回sessionId
 *  @param failure 失败
 */
- (void)postRechargeWithAmount:(NSInteger)amount
                       Success:(void(^)(NSString *sessionId))success
                       Failure:(void(^)(NSError *error))failure;

#pragma mark 搜索
/**
 *  搜索结果
 *
 *  @param keyWords 关键字
 *  @param success  成功
 *  @param failure  失败
 */
- (void)getSearchResultWithKeyWords:(NSString *)keyWords
                               Rows:(NSInteger)rows
                               Page:(NSInteger)page
                         CategoryId:(NSInteger)categoryId
                               Sort:(NSString *)sort
                              Order:(NSString *)order
                            Success:(void(^)(NSArray *responseObject))success
                            Failure:(void(^)(NSError *error))failure;

/**
 *  搜索结果价格列表
 *
 *  @param skuList sku数组
 *  @param cityId  城市id
 *  @param success 成功
 *  @param failure 失败
 */
- (void)postSearchResultPriceListWithSkuList:(NSArray *)skuList
                                      CityId:(NSString *)cityId
                                     Success:(void(^)(NSArray *responseObject))success
                                     Failure:(void(^)(NSError *error))failure;

#pragma mark 地区信息
/**
 *  @author hxy
 *
 *  获取省份列表
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getProvinceDataSuccess:(void(^)(NSArray *responseObject))success
                       Failure:(void(^)(NSError *error))failure;

/**
 *  @author hxy
 *
 *  获取城市列表
 *
 *  @param provId  省份编码
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getCityDataWithProvId:(NSString *)provId
                      Success:(void(^)(NSArray *responseObject))success
                      Failure:(void(^)(NSError *error))failure;
/**
 *  @author hxy
 *
 *  获取区列表
 *
 *  @param cityId  城市编码
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getDistrictDataWithCityId:(NSString *)cityId
                          Success:(void(^)(NSArray *responseObject))success
                          Failure:(void(^)(NSError *error))failure;

/**
 *  @author hxy
 *
 *  获取乡镇列表
 *
 *  @param cityId   城市编码
 *  @param countyId 区编码
 *  @param success  成功
 *  @param failure  失败
 */
- (void)getTownDataWithCityId:(NSString *)cityId
                     countyId:(NSString *)countyId
                      Success:(void(^)(NSArray *responseObject))success
                      Failure:(void(^)(NSError *error))failure;


/**
 *  @author hxy
 *
 *  设置默认地址
 *
 *  @param addressId 地址ID
 *  @param success   成功
 *  @param failure   失败
 */
- (void)postAddressDefaultAddressId:(NSString *)addressId
                            Success:(void(^)())success
                            Failure:(void(^)(NSError *error))failure;

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
                Failure:(void(^)(NSError *error))failure;

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
                Failure:(void(^)(NSError *error))failure;

/**
 *
 *
 *  8.3 获取关注列表
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getFavouriteListSuccess:(void(^)(NSArray *responseObject))success
                        Failure:(void(^)(NSError *error))failure;

/**
 *  @author hxy
 *
 *  设置支付密码
 *
 *  @param password 支付密码
 *  @param success  成功
 *  @param failure  失败
 */
- (void)postPayPasswordWith:(NSString *)password
                    Success:(void(^)())success
                    Failure:(void(^)(NSError *error))failure;
/**
 *  @author hxy
 *
 *  修改地址
 *
 *  @param id1           地址
 *  @param telephone     手机号
 *  @param contact       联系人姓名
 *  @param provinceId    省份id
 *  @param cityId        城市id
 *  @param countyId      区id
 *  @param townId        乡镇id
 *  @param name          地址标签
 *  @param email         Email地址
 *  @param addressDetail 地址详情
 *  @param phone         家庭电话
 *  @param success       成功
 *  @param failure       失败
 */
- (void)putChangeAddressWithId:(NSInteger)id1
                     telephone:(NSString*)telephone
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
                       Success:(void(^)())success
                       Failure:(void(^)(NSError *error))failure;

/**
 *  @author HXY
 *
 *  手机号校验
 *
 *  @param telephone 手机号
 *  @param success   成功
 *  @param failure   失败
 */
- (void)postCheckTelephoneWithTelephone:(NSString *)telephone
                                Success:(void(^)())success
                                Failure:(void(^)(NSError *error))failure;

/**
 *  @author HXY
 *
 *  邮箱校验
 *
 *  @param email   邮箱
 *  @param success 成功
 *  @param failure 失败
 */
- (void)postCheckEmailWithEmail:(NSString *)email
                        Success:(void(^)())success
                        Failure:(void(^)(NSError *error))failure;

/**
 *  @author HXY
 *
 *  修改邮箱验证码
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getChangeEmailCodeWithTelephone:(NSString *)telephone
                                Success:(void(^)())success
                   Failure:(void(^)(NSError *error))failure;
/**
 *  @author HXY
 *
 *  修改手机号验证码
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getChangeTelephoneCodeWithTelephone:(NSString *)telephone
                                Success:(void(^)())success
                          Failure:(void(^)(NSError *error))failure;

/**
 *  @author HXY
 *
 *  修改邮箱验证码校验
 *
 *  @param code    验证码
 *  @param phone   手机号
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getCheckEmailCodelWithCode:(NSString *)code
                         telephone:(NSString*)phone
                           Success:(void(^)())success
                           Failure:(void(^)(NSError *error))failure;
/**
 *  @author HXY
 *
 *  修改手机验证码校验
 *
 *  @param code    验证码
 *  @param phone   手机号
 *  @param success 成功
 *  @param failure 失败
 */
- (void)getCheckTelephoneCodelWithCode:(NSString *)code
                         telephone:(NSString*)phone
                           Success:(void(^)())success
                           Failure:(void(^)(NSError *error))failure;

@end


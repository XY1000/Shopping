//
//  NetAPIHeader.h
//  Projectflow
//
//  Created by Bert on 11/30/15.
//  Copyright © 2015 Mirror. All rights reserved.
//

#ifndef NetAPIHeader_h
#define NetAPIHeader_h

#define Root_Path  @"http://115.29.43.27:8004"
#define Send_Url(rootPath, api, path) [NSString stringWithFormat:@"%@/%@/%@", rootPath, api, path]
//方法api
static NSString * const category_Api         = @"api";


#pragma mark 首页
//首页轮播图片
static NSString * const homePage_BannerImages                   = @"circle/list";
//特色馆热销列表
static NSString * const homePageSpecial_HotList                 = @"special/selling/list";
//首页频道列表
static NSString * const homePageSpecial_ChannelList             = @"channel/main/list/app";
//猜你喜欢列表
static NSString * const GuessYouLike_List                       = @"guess/list";
#pragma mark 产品
//产品图片
static NSString * const productDetailPage_productImages         = @"product/image";
//产品积分价格
static NSString * const productDetailPage_productPrice          = @"product/score/price";
//产品详情
static NSString * const productDetailPage_productData           = @"product/retrieve";

#pragma mark 分类
static NSString * const classifyPage_ChannelList                = @"category/main/list";


#pragma mark 推荐

#pragma mark 购物车
//购物车列表
static NSString * const shoppingCartPage_CartList               = @"cart/list";
//购物车数量
static NSString * const shoppingCartPage_CartAmount             = @"cart/amount";
//添加购物车
static NSString * const shoppingCartPage_AddCart                = @"cart/create";
//修改购物车
static NSString * const shoppingCartPage_UpdateCart             = @"cart/update";
//批量删除购物车
static NSString * const shoppingCartPage_DeleteCartArray        = @"cart/delete/array";

#pragma mark 订单
//查询库存
static NSString * const OrderMoudle_queryInventory              = @"product/inventory";
//查询批量库存
static NSString * const OrderMoudle_queryInventoryArray         = @"product/inventory/array";
//全部订单
static NSString * const OrderMoudle_AllOrder                    = @"order/all/list";
//创建订单
static NSString * const OrderMoudle_CreateOrder                 = @"order/create";
//订单支付
static NSString * const OrderMoudle_OrderPay                    = @"order/pay";
//未支付订单
static NSString * const OrderMoudle_OrderUnPay                  = @"order/unpay/list";
//待发货订单
static NSString * const OrderMoudle_OrderUnSend                 = @"order/unsend/list";
//订单详情
static NSString * const OrderMoudle_OrderDetail                 = @"order/retrieve";
//查询订单积分
static NSString * const OrderMoudle_OrderSearchPayAmount        = @"order/check/score";

#pragma mark 我的
//注册手机验证码
static NSString * const myPage_PhoneCode                        = @"user/code";
//注册验证码校验
static NSString * const myPage_CodeValidate                     = @"user/code/check";
//忘记密码手机验证码
static NSString * const myPage_ForgetPasswordCode               = @"user/forget/code";
//忘记密码验证码校验
static NSString * const myPage_ForgetPasswordCodeValidate       = @"user/forget/code/check";
//忘记密码重置
static NSString * const myPage_ForgetPasswordReset              = @"user/forget/password";
//支付密码手机验证码
static NSString * const myPage_PayPhoneCode                     = @"user/change/pay/code";
//支付密码验证码校验
static NSString * const myPage_PayCodeValidate                  = @"user/change/pay/code/check";
//注册
static NSString * const myPage_UserRegister                     = @"user/create";
//登录
static NSString * const myPage_UserLogin                        = @"user/login";
//用户信息
static NSString * const myPage_UserInformation                  = @"user/retrieve";
//修改密码
static NSString * const myPage_UserChangePassword               = @"user/password/change";
//修改信息
static NSString * const myPage_UserChangeInformation            = @"user/update";
//修改手机号
static NSString * const myPage_UserChangePhone                  = @"telephone/change";
//修改邮箱
static NSString * const myPage_UserChangeEmail                  = @"email/change";
//地址列表
static NSString * const myPage_AddressList                      = @"address/list";
//添加地址
static NSString * const myPage_AddAddress                       = @"address/create";
//删除地址
static NSString * const myPage_DeleteAddress                    = @"address/delete";
//查询积分
static NSString * const myPage_QueryIntrgral                    = @"user/get/score";

#pragma mark 充值
//获取充值金额
static NSString * const myPage_GetRMB                           = @"recharge/count/price";
//积分充值
static NSString * const myPage_IntegralRecharge                 = @"recharge/create";


#pragma mark 搜索
static NSString * const searchPage_Result                       = @"product/search";

#pragma 地区信息
//省份列表
static NSString * const province                                =
    @"province";
//城市
static NSString * const city                                    =
    @"city";
//区
static NSString * const district                                =
    @"district";
//乡镇
static NSString * const town                                    =
    @"town";

//设置默认地址
static NSString * const addressDefault                          = @"address/setDefault";
//添加关注
static NSString * const favouriteCreate                         = @"favourite/create";
//删除关注
static NSString * const favouriteDelete                         = @"favourite/delete";
//关注列表
static NSString * const favouriteList                           = @"favourite/list";

//设置支付密码
static NSString *const payPassword                              = @"user/payPassword";

//修改地址
static NSString *const ChangeAddress                            = @"address/update";


#endif /* NetAPIHeader_h */

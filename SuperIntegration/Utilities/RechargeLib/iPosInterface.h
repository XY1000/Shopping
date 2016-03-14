//
//  iPosInterface.h
//  iPosLib
//
//  Created by Jerrium on 4/15/14.
//  Copyright (c) 2014 Jerrium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPosBankInfoData.h"

// 订单捡起类型
typedef enum
{
    PICKUP_TYPE_ORDER_NO = 0,      //0：订单号捡起
    PICKUP_TYPE_SESSION_ID         //1：sessionid捡起
}PICKUP_TYPE;


// 支付方式类型
// 前置的订单类型包括：
// (1)和聚宝
typedef enum
{
    PAY_SELECT_FRONT = 0,      //0：支付方式前置
    PAY_SELECT_BACK           //1：支付方式后置
}PAY_SELECT;

// 订单类型
// 转账应用：包括3(收付款)和6(付款到银行)
// 转账到和包账户:ORDER_TYPE_COLLECT_PAY(3)
// 转账到银行卡:ORDER_TYPE_PAY_TO_BANK(6)
typedef enum
{
    ORDER_TYPE_CLIENT = 0,      //0：商户客户端发起的订单(sesionid(需要补录)，如：交通罚款；或订单号，如：生活缴费：水电等)
    ORDER_TYPE_CMPAY,           //1：cmpay直接支付订单(订单号)
    ORDER_TYPE_MOBILE_FEE,      //2：缴话费订单（包括和聚宝充值）
    ORDER_TYPE_COLLECT_PAY,     //3：收付款(转账到和包账号)
    ORDER_TYPE_HE_WALLET,       //4：和聚宝
    ORDER_TYPE_ECOUPON,         //5：电子券
    ORDER_TYPE_PAY_TO_BANK,     //6：转账到银行卡
    ORDER_TYPE_PROV_NET_MOBILE_FEE, // 7：省网厅缴话费模式(sesionid代替订单号)
    ORDER_TYPE_GROUP_NET_MOBILE_FEE  // 8：集团网厅缴话费模式(sesionid代替订单号)
}ORDER_TYPE;

@protocol iPosInterfaceDelegate <NSObject>

-(void)iPosInterfaceDidFinish:(UIViewController*)vc
                     WithData:(NSDictionary*)dictData;

@end

@interface iPosInterface : NSObject
@property(nonatomic, retain)id<iPosInterfaceDelegate> delegate;

// 支付接口
-(void)InitiPosLib:(UIViewController *)vc OrderInfo:(NSMutableDictionary *)mdOrderInfo;

// 前置支付专用接口
-(void)InitiPosLib:(UIViewController *)vc OrderInfo:(NSMutableDictionary *)mdOrderInfo WithPreBankInfo:(iPosBankInfoData *)bankInfo;

@end

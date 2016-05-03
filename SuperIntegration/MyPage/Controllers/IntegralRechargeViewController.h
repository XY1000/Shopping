//
//  IntegralRechargeViewController.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/3.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    zhifubao = 1,
    hebaobao
}ZhifuType;


@interface IntegralRechargeViewController : UIViewController

@property (copy, nonatomic) NSString *myIntegral;
@property (assign, nonatomic) ZhifuType zhifuType;

//0 充值进入 1支付订单时进入
@property (assign, nonatomic) NSInteger presentType;

@end

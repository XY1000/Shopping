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

@property (assign, nonatomic) NSInteger myIntegral;
@property (assign, nonatomic) ZhifuType zhifuType;

@end

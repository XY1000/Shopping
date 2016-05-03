//
//  OrderPaySuccessViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/23.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderPaySuccessViewController.h"
#import "BaseTabbarViewController.h"
#import "OrderDetailTableViewController.h"
@interface OrderPaySuccessViewController ()

@property (weak, nonatomic) IBOutlet UIButton *priceLabel;
@end

@implementation OrderPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.priceLabel setTitle:[NSString stringWithFormat:@"%@分",self.price] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//查看订单
- (IBAction)lookOrderClicked:(id)sender {
    
    OrderDetailTableViewController *orderDetailCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"OrderDetailTableViewController"];
    orderDetailCon.orderNumber = self.orderNumber;
    orderDetailCon.orderState = @"待发货";
    orderDetailCon.orderPaidAmount = self.price;
    [self.navigationController pushViewController:orderDetailCon animated:YES];
}
//回首页
- (IBAction)backHomePageClicked:(id)sender {
    BaseTabbarViewController *tabCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"BaseTabbarViewController"];
    WINDOW.rootViewController = tabCon;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

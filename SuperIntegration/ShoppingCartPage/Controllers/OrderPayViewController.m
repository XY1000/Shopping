//
//  OrderPayViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/23.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderPayViewController.h"
#import "OrderPaySuccessViewController.h"
#import "OrderPayPasswordView.h"
#import "ChangePassVerPhoneTableViewController.h"
#import "IntegralRechargeViewController.h"
@interface OrderPayViewController ()
{
    NSString *_pwdString;
}
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPayAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;


@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UIView *chargeView;

@property (weak, nonatomic) IBOutlet OrderPayPasswordView *pwdView;

@end

@implementation OrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.orderDic);
    self.orderNumberLabel.text = [NSString stringWithFormat:@"%ld", [self.orderDic[@"orderNumber"] integerValue]];
    self.orderPayAmountLabel.text = [NSString stringWithFormat:@"%.2f分", [self.orderDic[@"price"] floatValue]];
    
    [self.pwdView setFrame:CGRectMake(0, 0, self.pwdView.frame.size.width, self.pwdView.frame.size.height)];
    [self.pwdView drawView];
    [self.pwdView.pwdTextField becomeFirstResponder];
    self.pwdView.completeHandle = ^(NSString *inputPwd) {
        NSLog(@"%@", inputPwd);
        _pwdString = inputPwd;
    };
    
    self.navigationItem.leftBarButtonItem = nil;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = nil;
    UIBarButtonItem *drawerBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索结果页_检索展开演示3_03"] style:UIBarButtonItemStylePlain target:self action:@selector(settingBtnClick)];
    [drawerBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem =drawerBarButtonItem;
    [self queryUserIntrgral];
}

- (void)settingBtnClick {
    UIAlertController *alertController = [[UIAlertController alloc]
                                          initAlertWithTitle:@"提示"
                                          message:@"是否取消支付?"
                                          preferredStyle:UIAlertControllerStyleAlert
                                          antionTitle:@"取消"
                                          actionStyle:UIAlertActionStyleDestructive
                                          actionHandle:^{
                                              return ;
                                          }
                                          otherActionTitle:@"确定"
                                          otherActionStyle:UIAlertActionStyleDestructive
                                          otherActionHandle:^{
                                              [self.navigationController popToRootViewControllerAnimated:YES];
                                          }];
    
    [alertController alertShowForViewController:self completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//查询用户积分
- (void)queryUserIntrgral {
    [[NetworkService sharedInstance] getUserQueryIntegralSuccess:^(NSString *integral) {
        self.jifenLabel.text = [NSString stringWithFormat:@"%@分",integral];
        if ([integral integerValue] < [self.orderPayAmountLabel.text integerValue]) {
            self.chargeView.hidden = NO;
            self.payView.hidden = YES;
        } else {
            self.chargeView.hidden = YES;
            self.payView.hidden = NO;
        }
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}

//积分充值
- (IBAction)chargeClicked:(id)sender {
    NSLog(@"和包充值");
    IntegralRechargeViewController *integralCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"IntegralRechargeViewController"];
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:integralCon];
    navCon.navigationBar.barTintColor = [UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f];
    navCon.navigationBar.translucent = NO;
    integralCon.myIntegral = self.orderPayAmountLabel.text;
    integralCon.zhifuType = hebaobao;
    integralCon.presentType = 1;
    //            [self.navigationController pushViewController:integralCon animated:YES];
    [self presentViewController:navCon animated:YES completion:^{
        
    }];
}

//确认支付
- (IBAction)determineClicked:(id)sender {
    if (_pwdString.length == 6) {
        [[NetworkService sharedInstance] postOrderPayWithOrderNumber:self.orderNumberLabel.text
                                                         PayPassword:_pwdString
                                                             Success:^{
                                                                 OrderPaySuccessViewController *paySuccessCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"OrderPaySuccessViewController"];
                                                                 paySuccessCon.orderNumber = self.orderNumberLabel.text;
                                                                 paySuccessCon.price = self.orderPayAmountLabel.text;
                                                                 [self.navigationController pushViewController:paySuccessCon animated:YES];
                                                             } Failure:^(NSError *error) {
                                                                 [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                             }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请输入正确密码!"];
    }
}

//忘记密码
- (IBAction)forgetClicked:(id)sender {
    ChangePassVerPhoneTableViewController *payPasswordCon = [STOARYBOARD(@"User") instantiateViewControllerWithIdentifier:@"ChangePassVerPhoneTableViewController"];
    [self.navigationController pushViewController:payPasswordCon animated:YES];
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

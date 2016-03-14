//
//  IntegralRechargeViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/3.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "IntegralRechargeViewController.h"
#import "iPosInterface.h"

@interface IntegralRechargeViewController ()<UITextFieldDelegate,iPosInterfaceDelegate>

@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UILabel *RMBLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *zhifubaoButton;
@property (weak, nonatomic) IBOutlet UIButton *hebaobaoButton;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;

@end

@implementation IntegralRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backItem.tintColor = [UIColor whiteColor];
    
    if (self.zhifuType == zhifubao) {
        [self.hebaobaoButton setHidden:YES];
        [self.zhifubaoButton setHidden:NO];
    }
    if (self.zhifuType == hebaobao) {
        [self.hebaobaoButton setHidden:NO];
        [self.zhifubaoButton setHidden:YES];
    }
    
    self.integralLabel.text = [NSString stringWithFormat:@"%lu分", (long)self.myIntegral];
    self.textField.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (IBAction)backItemClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (IBAction)zhifubaoClicked:(id)sender {
    [self rechargeIntegral];
}
- (IBAction)hebaobaoClicked:(id)sender {
    [self rechargeIntegral];
}

#pragma mark <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [[NetworkService sharedInstance] getRMBWithAmount:self.textField.text.integerValue
                                              Success:^(CGFloat RMB) {
                                                  self.RMBLabel.text = [NSString stringWithFormat:@"%.2f元", RMB];
                                              } Failure:^(NSError *error) {
                                                  [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                              }];
    
    [textField resignFirstResponder];
    return YES;
}

//充值积分
- (void)rechargeIntegral {
    [[NetworkService sharedInstance] postRechargeWithAmount:self.textField.text.integerValue
                                                    Success:^(NSString *sessionId) {
                                                        NSLog(@"sessionId = %@", sessionId);
                                                        
                                                        
                                                        // PAY_SELECT_FRONT是前置标识，10008100000000036986是和包选中的银行卡协议号
                                                        // PickupType用来区分订单号或sessionid
                                                        NSMutableDictionary *mdOrderInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                            [NSNumber numberWithInt:ORDER_TYPE_CLIENT], @"OrderType",
                                                                                            sessionId, @"OrderNo",
                                                                                            [NSNumber numberWithInt:PAY_SELECT_BACK], @"PaySelect",
                                                                                            
                                                                                            @"",
                                                                                            @"MobileNo",  //支付手机号码
                                                                                            
                                                                                            //[NSNumber numberWithInt:PICKUP_TYPE_ORDER_NO], @"PickupType",//平台内部订单号
                                                                                            [NSNumber numberWithInt:PICKUP_TYPE_SESSION_ID], @"PickupType",//sessionId
                                                                                            [NSNumber numberWithBool:YES], @"NotPopToMain",
                                                                                            nil];
                                                        iPosInterface *ipos = [[iPosInterface alloc]init];
                                                        
                                                        // 这里的delegate就是回调的地方
                                                        ipos.delegate = self;
                                                        
                                                        // 这里的self.vcBase就是支付成功后你想去的主界面
                                                        [ipos InitiPosLib:self OrderInfo:mdOrderInfo];
                                                        
                                                    } Failure:^(NSError *error) {
                                                        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                    }];
}

#pragma mark iPos Delegate
// vc为插件在支付时的最后一个页面
// dictData包含了成功后的一些数据
-(void)iPosInterfaceDidFinish:(UIViewController*)vc
                     WithData:(NSDictionary*)dictData
{
    
    // 用户直接放弃支付后，如点击返回按钮
    // 这里你可以加一些放弃支付后的处理逻辑
    // 这里可以做push和pop操作
    if (dictData == nil)
    {
        NSLog(@"User returned");
        //因为"NotPopToMain"参数设置了YES，所以这里需要主调方自己把插件Pop掉
        [self.navigationController popViewControllerAnimated:YES];
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
    }
    // 支付成功后
    // 这里你可以加一些支付成功后的处理逻辑
    // 如果前面设置了入口参数：
    // [NSNumber numberWithBool:YES], @"NotPopToMain"
    // 那么这里可以追加自己的push和pop
    else
    {
        NSLog(@"支付成功");
        // push 你的vc页面,如：成功页面
        // 在成功页面里pop到你想返回的页面
        
        //因为"NotPopToMain"参数设置了YES，所以这里需要主调方自己把插件Pop掉
        [self.navigationController popViewControllerAnimated:YES];
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
    }
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

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
@interface OrderPayViewController ()
{
    NSString *_pwdString;
}
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPayAmountLabel;

@property (weak, nonatomic) IBOutlet OrderPayPasswordView *pwdView;

@end

@implementation OrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderNumberLabel.text = [NSString stringWithFormat:@"%d", [self.orderDic[@"orderNumber"] integerValue]];
    self.orderPayAmountLabel.text = [NSString stringWithFormat:@"%d", [self.orderDic[@"price"] integerValue]];
    
    [self.pwdView setFrame:CGRectMake(0, 0, self.pwdView.frame.size.width, self.pwdView.frame.size.height)];
    [self.pwdView drawView];
    [self.pwdView.pwdTextField becomeFirstResponder];
    self.pwdView.completeHandle = ^(NSString *inputPwd) {
        NSLog(@"%@", inputPwd);
        _pwdString = inputPwd;
    };
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

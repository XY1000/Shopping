//
//  MyPageForgetPasswordResetViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/2.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "MyPageForgetPasswordResetViewController.h"
#import "MyPageForgetPsswordResetSuccessViewController.h"

@interface MyPageForgetPasswordResetViewController()

@property (weak, nonatomic) IBOutlet UITextField *txt_NewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txt_DeterminePassword;


@end

@implementation MyPageForgetPasswordResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//完成
- (IBAction)btn_CompleteClicked:(id)sender {
    if (STR_IS_NIL(self.txt_NewPassword.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    if (STR_IS_NIL(self.txt_DeterminePassword.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入确认密码"];
        return;
    }
    if (![self.txt_NewPassword.text isEqualToString:self.txt_DeterminePassword.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        return;
    }
    if (![Utility evaluateWithPassword:self.txt_DeterminePassword.text]) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-20位字母和数字的组合"];
        return;
    }
    
    [[NetworkService sharedInstance] postForgetPasswordResetWithPassword:self.txt_DeterminePassword.text
                                                                 Success:^{
                                                                     DLog(@"resetSuccess");
                                                                     MyPageForgetPsswordResetSuccessViewController *successCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"MyPageForgetPsswordResetSuccessViewController"];
                                                                     [self.navigationController pushViewController:successCon animated:YES];
                                                                 } Failure:^(NSError *error) {
                                                                     [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                                                 }];
    
}
@end

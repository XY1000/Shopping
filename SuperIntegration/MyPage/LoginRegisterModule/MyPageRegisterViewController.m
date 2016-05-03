//
//  RegisterViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#define CodeButtonWidth SCREEN_WIDTH * 200 / (375 * 2)

#import "MyPageRegisterViewController.h"
#import "ConfirmRegisterViewController.h"

@interface MyPageRegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeButtonWidthLayoutConstraint;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation MyPageRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.codeButtonWidthLayoutConstraint setConstant:CodeButtonWidth];
    
    [self.phoneTextField becomeFirstResponder];
    self.phoneTextField.delegate = self;
    self.codeTextField.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.phoneTextField]) {
        if (range.location <= 10) {
            return YES;
        }
    }
    if ([textField isEqual:self.codeTextField]) {
        if (range.location <= 5) {
            return YES;
        }
    }
    return NO;
}

#pragma mark 获取验证码
- (IBAction)getCodeClicked:(id)sender {
    if (STR_IS_NIL(self.phoneTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请填写手机号码"];
        return;
    }
    if (![Utility checkUserTelNumber:self.phoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    [self.codeButton startWithTime:60 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f] countColor:[UIColor lightGrayColor]];
    [[NetworkService sharedInstance] getUserPhoneCodeWithPhone:self.phoneTextField.text
                                                       Success:^{
                                                           DLog(@"getCodeSuccess");
                                                       } Failure:^(NSError *error) {
                                                           [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                                       }];
}
#pragma mark 确认验证
- (IBAction)validateClicked:(id)sender {
    if (STR_IS_NIL(self.phoneTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请填写手机号码"];
        return;
    }
    if (![Utility checkUserTelNumber:self.phoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    if (STR_IS_NIL(self.codeTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    [[NetworkService sharedInstance] getUserValidateCodeWithPhone:self.phoneTextField.text
                                                             Code:self.codeTextField.text
                                                          Success:^{
                                                              DLog(@"validateCodeSuccess");
                                                              ConfirmRegisterViewController *confirmRegisterCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"ConfirmRegisterViewController"];
                                                              confirmRegisterCon.phone = self.phoneTextField.text;
                                                              [self.navigationController pushViewController:confirmRegisterCon animated:YES];
                                                          } Failure:^(NSError *error) {
                                                              [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                                          }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

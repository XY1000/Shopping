//
//  MyPageForgetPasswordViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/2.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "MyPageForgetPasswordViewController.h"
#import "MyPageForgetPasswordResetViewController.h"
@interface MyPageForgetPasswordViewController()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeButtonWidthLayoutConstraint;

@end

@implementation MyPageForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.codeButtonWidthLayoutConstraint setConstant:SCREEN_WIDTH * 200 / (375 * 2)];
    
    [self.phoneTextField becomeFirstResponder];
    self.phoneTextField.delegate = self;
    self.codeTextField.delegate = self;
    
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//获得验证码
- (IBAction)btn_FP_GetCodeClicked:(id)sender {
    if (STR_IS_NIL(self.phoneTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请填写手机号码"];
        return;
    }
    if (![Utility checkUserTelNumber:self.phoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    [self.codeButton startWithTime:60 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f] countColor:[UIColor lightGrayColor]];
    [[NetworkService sharedInstance] getForgetPasswordUserPhoneCodeWithPhone:self.phoneTextField.text
                                                                     Success:^{
                                                                          DLog(@"getCodeSuccess");
                                                                         
                                                                     } Failure:^(NSError *error) {
                                                                         [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                                                     }];
}

//下一步
- (IBAction)btn_FPClicked:(id)sender {
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
    [[NetworkService sharedInstance] getForgetPasswordUserValidateCodeWithPhone:self.phoneTextField.text
                                                                           Code:self.codeTextField.text
                                                                        Success:^{
                                                                            DLog(@"validateCodeSuccess");
                                                                            MyPageForgetPasswordResetViewController *resetCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"MyPageForgetPasswordResetViewController"];
                                                                            [self.navigationController pushViewController:resetCon animated:YES];
                                                                        } Failure:^(NSError *error) {
                                                                            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                                                        }];
}

@end

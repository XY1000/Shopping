//
//  ConfirmRegisterViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/21.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ConfirmRegisterViewController.h"
#import "DropDownView.h"
@interface ConfirmRegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *realNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailboxTextField;

@property (weak, nonatomic) IBOutlet UIButton *btn_Sex;
@property (strong, nonatomic) DropDownView *dropView;
@end

@implementation ConfirmRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accountNumberTextField.delegate = self;
    self.realNameTextField.delegate = self;
    self.sexTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    self.mailboxTextField.delegate = self;
    
    // Do any additional setup after loading the view.
}
#pragma mark 确认注册
- (IBAction)confirmRegisterClicked:(id)sender {
    if (STR_IS_NIL(self.accountNumberTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }
    if (STR_IS_NIL(self.passwordTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    if (STR_IS_NIL(self.confirmPasswordTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入确认密码"];
        return;
    }
    if (((self.passwordTextField.text.length < 6) || (self.passwordTextField.text.length > 20)) || ((self.confirmPasswordTextField.text.length < 6) || (self.confirmPasswordTextField.text.length > 20))) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-20位字母和数字的组合"];
        return;
    }
    if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        return;
    }
    [[NetworkService sharedInstance] postUserRegisterInformationWithPhone:self.accountNumberTextField.text
                                                                 RealName:self.realNameTextField.text
                                                                      Sex:[self.sexTextField.text integerValue]
                                                                    Email:self.mailboxTextField.text
                                                                 Password:self.passwordTextField.text
                                                                  Success:^{
                                                                      DLog(@"registerSuccess");
                                                                      
                                                                      //注册成功自动返回进入登录界面的界面
                                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"backLastPage" object:nil];
                                                                      
                                                                  } Failure:^(NSError *error) {
                                                                      [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                                                  }];
}

- (IBAction)btn_SexClicked:(id)sender {
    [self txt_resignFirstResponder];
    if (self.btn_Sex.selected == NO) {
        [self.btn_Sex setSelected:YES];
        if (self.dropView == nil) {
            self.dropView = [[DropDownView alloc] init];
            [self.dropView showDropDown:sender height:120 array:@[@"男",@"女",@"保密"]];
            [self.view addSubview:self.dropView];
            
            __weak ConfirmRegisterViewController *weakSelf = self;
            self.dropView.block_DidSelect = ^(NSString *sex) {
                weakSelf.sexTextField.text = sex;
            };
        }
    } else {
        [self.btn_Sex setSelected:NO];
        [self.dropView hideDropDown:sender];
        self.dropView = nil;
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.btn_Sex setSelected:NO];
    [self.dropView hideDropDown:self.btn_Sex];
    self.dropView = nil;
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self txt_resignFirstResponder];
}

- (void)txt_resignFirstResponder {
    [self.accountNumberTextField resignFirstResponder];
    [self.realNameTextField resignFirstResponder];
    [self.sexTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmPasswordTextField resignFirstResponder];
    [self.mailboxTextField resignFirstResponder];
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

//
//  LoginViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "MyPageLoginViewController.h"
#import "MyPageRegisterViewController.h"

@interface MyPageLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *btn_AutomaticLogin;
@end

@implementation MyPageLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.accountNumberTextField becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backLastPage) name:@"backLastPage" object:nil];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"automicLogin"]) {
        [self.btn_AutomaticLogin setSelected:YES];
        self.accountNumberTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        self.passwordTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    } else {
        [self.btn_AutomaticLogin setSelected:NO];
    }
    
    // Do any additional setup after loading the view.
}

#pragma mark Method
//textField resignFirstResponder
- (void)textFieldResignFirstResponder {
    [self.accountNumberTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
//dismissView
- (void)backLastPage {
    [self textFieldResignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        //获得购物车数量
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"cartAmount" object:nil];
    }];
}
//取消
- (IBAction)cancelClicked:(id)sender {
    [self textFieldResignFirstResponder];
    [self backLastPage];
}
//自动登录
- (IBAction)btn_AutomicLoginClicked:(id)sender {
    if (self.btn_AutomaticLogin.selected) {
        [self.btn_AutomaticLogin setSelected:NO];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"automicLogin"];
        NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"myCookies"];
        if([cookiesdata length]) {
            NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
            NSHTTPCookie *cookie;
            for (cookie in cookies) {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            }
        }
    } else {
        [self.btn_AutomaticLogin setSelected:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"automicLogin"];
    }
}

#pragma mark 登录
- (IBAction)loginClicked:(id)sender {
    if (STR_IS_NIL(self.accountNumberTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }
    if (STR_IS_NIL(self.passwordTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.accountNumberTextField.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"password"];
    [[NetworkService sharedInstance] postUserLoginWithUsername:self.accountNumberTextField.text
                                                      Password:self.passwordTextField.text
                                                       Success:^{
                                                           DLog(@"loginSuccess");
                                                           
                                                           [self backLastPage];
                                                           
                                                       } Failure:^(NSError *error) {
                                                           [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                                       }];
}
#pragma mark 注册
- (IBAction)registerClicked:(id)sender {
    MyPageRegisterViewController *registerCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"MyPageRegisterViewController"];
    [self.navigationController pushViewController:registerCon animated:YES];
}
#pragma mark 忘记密码
- (IBAction)forgetPasswordClicked:(id)sender {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self textFieldResignFirstResponder];
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

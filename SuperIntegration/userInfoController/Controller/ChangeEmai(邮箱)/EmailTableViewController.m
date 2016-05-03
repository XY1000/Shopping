//
//  EmailTableViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/4/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "EmailTableViewController.h"

@interface EmailTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentEmailLb;

@property (weak, nonatomic) IBOutlet UITextField *emailAddressTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;

@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation EmailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改绑定邮箱";
    
    UserModel *model = [ModelManager getUserModel];
    
    
    if (!STR_IS_NIL(model.email)) {
        
        self.currentEmailLb.text = model.email;
        
    }else {
        
        self.currentEmailLb.text = @"-----";
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)codeBtnClick:(UIButton *)sender {
    
     [self.codeBtn startWithTime:60 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f] countColor:[UIColor lightGrayColor]];
    
    [[NetworkService sharedInstance] getChangeEmailCodeWithTelephone:self.phoneNumTF.text Success:^{
       
        [SVProgressHUD showSuccessWithStatus:@"验证码已下发"];
    
    } Failure:^(NSError *error) {
        
        
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
        
    }];
    
    
}

- (IBAction)saveBtn:(UIButton *)sender {
    
    if (STR_IS_NIL(self.emailAddressTF.text)) {
        
        [SVProgressHUD showErrorWithStatus:@"新邮箱地址不能为空"];
        return;
    }
    
    
    if (STR_IS_NIL(self.phoneNumTF.text)) {
        
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        return;
    }
    
    
    
    if (STR_IS_NIL(self.codeTF.text)) {
        
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
        return;
    }
    
    if (![Utility validateEmail:self.emailAddressTF.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"邮箱无效"];
        return;
    }
    
    
    [[NetworkService sharedInstance] getCheckEmailCodelWithCode:self.codeTF.text telephone:self.phoneNumTF.text Success:^{

        
        [[NetworkService sharedInstance] postCheckEmailWithEmail:self.emailAddressTF.text Success:^{
            
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            UserModel *model = [ModelManager getUserModel];
            model.email = self.emailAddressTF.text;
            model.emailStatus = YES;
            
        } Failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
        }];
        
        
        
    } Failure:^(NSError *error) {
       
        
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
        
    }];
    
    
}

@end

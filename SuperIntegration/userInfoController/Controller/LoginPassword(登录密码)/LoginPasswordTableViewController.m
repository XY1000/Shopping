//
//  LoginPasswordTableViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/4/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "LoginPasswordTableViewController.h"

@interface LoginPasswordTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLb;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *firstPasswordTF;

@property (weak, nonatomic) IBOutlet UITextField *secondPasswordTF;

@end

@implementation LoginPasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改登录密码";
    
    UserModel *model = [ModelManager getUserModel];
    
    NSString *str = model.telephone;
    NSString *fistStr = [str substringToIndex:3];
    NSString *lastStr = [str substringFromIndex:7];
  
    self.phoneNumLb.text = [NSString stringWithFormat:@"%@****%@",fistStr,lastStr];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveClick:(UIButton *)sender {
    
    if (STR_IS_NIL(self.oldPasswordTF.text)) {
        
        [SVProgressHUD showErrorWithStatus:@"旧密码不能为空"];
        
        return;
    }
    
    if (STR_IS_NIL(self.firstPasswordTF.text)) {
        
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空"];
        return;
    }
    
    if (STR_IS_NIL(self.secondPasswordTF.text)) {
        
        [SVProgressHUD showErrorWithStatus:@"请确认密码"];
        return;
    }
    
    if (![self.firstPasswordTF.text isEqualToString:self.secondPasswordTF.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"密码确认失败"];
        return;
    }
    
    if (![Utility evaluateWithPassword:self.firstPasswordTF.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入符合要求的密码"];
        return;
    }
    
    
    [[NetworkService sharedInstance] putUserChangePasswordWithOldPassword:self.oldPasswordTF.text NewPassword:self.secondPasswordTF.text Success:^{
        
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        
        SetObjectUserDefault(self.firstPasswordTF.text, @"password");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } Failure:^(NSError *error) {
       
        
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
        
    }];
    
    
    
}


@end

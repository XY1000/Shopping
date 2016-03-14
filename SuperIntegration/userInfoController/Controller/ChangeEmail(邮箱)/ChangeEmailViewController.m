//
//  ChangeEmailViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/3/7.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ChangeEmailViewController.h"

@interface ChangeEmailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt_password;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;
@end

@implementation ChangeEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.widthLayout.constant  = btnWidth;
    self.heightLayout.constant = btnHeight;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)confirmBtnClick:(id)sender {
    
    if (STR_IS_NIL(self.txt_password.text)) {
        
        [SVProgressHUD showErrorWithStatus:@"输入不可为空"];
        
        return;
    }
    
    if (![Utility validateEmail:self.txt_password.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱"];
        
        return ;
    }
    
    [self sendEmailNet];
    
    
    
}

#pragma mark - 发送网络请求

- (void)sendEmailNet {
    
    UserModel *model = [ModelManager getUserModel];
    
    [[NetworkService sharedInstance] putUserChangeEmailWithEmail:self.txt_password.text Success:^{
    
        model.emailStatus = YES;
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } Failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
        
    }];
    
}



@end

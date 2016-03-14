//
//  ChangePassVerPhoneTableViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/1/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ChangePassVerPhoneTableViewController.h"
#import "PayPassTableViewController.h"

@interface ChangePassVerPhoneTableViewController ()<UITextFieldDelegate>
//手机号
@property (weak, nonatomic) IBOutlet UILabel *lb_phone;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *txt_verNum;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;

@end

@implementation ChangePassVerPhoneTableViewController
{
    NSString *str;//手机号
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.widthLayout.constant = btnWidth;

    self.heightLayout.constant = btnHeight;
    
//    self.txt_Phone.userInteractionEnabled = NO;
//    self.txt_Phone.delegate = self;
    self.txt_verNum.delegate = self;
    
    [self initView];
}

//初始化视图
- (void)initView{
    
    self.navigationItem.title = @"修改支付密码验证手机";
    
    str = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    //str = [ModelManager getUserModel].telephone;
    DLog(@"model = %@",str);
    NSString *fistStr = [str substringToIndex:3];
    NSString *lastStr = [str substringFromIndex:7];
    DLog(@"%@,%@",fistStr,lastStr);
    
    self.lb_phone.text = [NSString stringWithFormat:@"%@****%@",fistStr,lastStr];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取验证码
- (IBAction)getVerNum:(UIButton *)sender {
    
    if (STR_IS_NIL(self.lb_phone.text)) {
        [SVProgressHUD showErrorWithStatus:@"手机号码获取失败"];
        return;
    }
    
    
    [self getPhoneVer];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if ([textField isEqual:self.txt_Phone]) {
//        if (range.location <= 10) {
//            return YES;
//        }
//    }
    if ([textField isEqual:self.txt_verNum]) {
        if (range.location <= 5) {
            return YES;
        }
    }
    return NO;
}

//获取手机验证码
- (void)getPhoneVer{
    
    [self.codeBtn startWithTime:60 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f] countColor:[UIColor lightGrayColor]];
    
    DLog(@"手机号 = %@",str);
    [[NetworkService sharedInstance] getPayUserPhoneCodeWithPhone:str Success:^{
        DLog(@"获取支付密码验证码成功");
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
    
}


#pragma mark - 下一步

- (IBAction)Next:(id)sender {
    
    if (STR_IS_NIL(self.txt_verNum.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    [[NetworkService sharedInstance] getPayUserValidateCodeWithPhone:str Code:self.txt_verNum.text Success:^{
        PayPassTableViewController *payPassCon = [STOARYBOARD(@"User") instantiateViewControllerWithIdentifier:@"PayPassTableViewController"];
        [self.navigationController pushViewController:payPassCon animated:YES];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];

}


@end

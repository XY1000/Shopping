//
//  ChangeUserNameController.m
//  SuperIntegration
//
//  Created by tmp on 16/3/7.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ChangeUserNameController.h"

@interface ChangeUserNameController ()

@property (weak, nonatomic) IBOutlet UITextField *txt_name;
@end

@implementation ChangeUserNameController
{
    UserModel *_model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改用户名";
    
    _model = [ModelManager getUserModel];
    
    [self addRightBtnItem];
    
    self.txt_name.text = _model.realname;
    
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:236/255.0 alpha:1];
}
//右侧 确定按钮
- (void)addRightBtnItem{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBtnClick:)];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@" " style:(UIBarButtonItemStylePlain) target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[item,item1];
    
    
}
- (void)rightBtnClick:(UIButton *)sender{
    
    if (self.txt_name.text.length >= 1&& self.txt_name.text.length <= 5) {
        
        
        
        DLog(@"realName = %@",_model.realname);
        
        
        [[NetworkService sharedInstance] putUserChangeInformationWithRealName:self.txt_name.text  NickName:_model.nickname Sex:_model.sex Success:^{
            
            _model.realname = self.txt_name.text;
            [self.navigationController popViewControllerAnimated:YES];
            
        } Failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
            
        }];
        
        
        
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"请输入1 - 5位"];
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(UIButton *)sender {
    self.txt_name.text = @"";
}

#pragma mark -UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    NSString *str = @"1-5个字符";
    
    return str;
    
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    
    view.tintColor = self.view.backgroundColor;
    
    UITableViewHeaderFooterView *foot = (UITableViewHeaderFooterView *)view;
    foot.textLabel.textColor = [UIColor lightGrayColor];
    
    
}

@end

//
//  AccountSecurityTableViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/1/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "AccountSecurityTableViewController.h"

@interface AccountSecurityTableViewController ()
//是否邮箱验证
@property (weak, nonatomic) IBOutlet UILabel *lb_email;
//手机
@property (weak, nonatomic) IBOutlet UILabel *lb_phone;
//安全程度
@property (weak, nonatomic) IBOutlet UILabel *lb_security;


@end

@implementation AccountSecurityTableViewController
{
    UserModel *_model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账户安全";
    
    [self initList];
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//初始化数据
- (void)initList{
    
    _model = [ModelManager getUserModel];
    
    if (STR_IS_NIL(_model.telephone)) {
        
        self.lb_phone.text = @"";
        
        return;
    }
    
    NSString *str = _model.telephone;
  
    NSString *fistStr = [str substringToIndex:3];
    NSString *lastStr = [str substringFromIndex:7];
    DLog(@"%@,%@",fistStr,lastStr);
        
    self.lb_phone.text = [NSString stringWithFormat:@"%@****%@",fistStr,lastStr];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    self.lb_email.text = _model.emailStatus ? @"未验证":@"已验证";
}


#pragma mark - UITableViewDelegate/datasource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != 3) {
        [SVProgressHUD showErrorWithStatus:@"该功能暂未实现"];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end

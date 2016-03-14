//
//  ChangeNickNameTableViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/2/25.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ChangeNickNameTableViewController.h"

@interface ChangeNickNameTableViewController ()
//昵称
@property (weak, nonatomic) IBOutlet UITextField *txt_nick;
//清空
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;

@end

@implementation ChangeNickNameTableViewController
{
    UserModel *_model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改昵称";
    
    _model = [ModelManager getUserModel];
    
    [self addRightBtnItem];
    
    self.txt_nick.text = _model.nickname;
   
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:236/255.0 alpha:1];
    
}

//右侧 确定按钮
- (void)addRightBtnItem{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBtnClick:)];
     UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@" " style:(UIBarButtonItemStylePlain) target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[item,item1];
    
    
}

- (void)rightBtnClick:(UIButton *)sender{
    
    if (self.txt_nick.text.length >= 2 && self.txt_nick.text.length <= 10) {
        
        
        
        DLog(@"nickName = %@",_model.nickname);
        
        
        
        
        [[NetworkService sharedInstance] putUserChangeInformationWithRealName:_model.realname NickName:self.txt_nick.text Sex:_model.sex Success:^{
            
            _model.nickname = self.txt_nick.text;
            [self.navigationController popViewControllerAnimated:YES];
            
        } Failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
            
        }];
        
        
        
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"请输入2 - 10位"];
        
    }
    
    
    
}
//清空
- (IBAction)removeAll:(UIButton *)sender {
    
    self.txt_nick.text = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    NSString *str = @"2-10个字符";
    
    return str;
    
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    
    view.tintColor = self.view.backgroundColor;
    
    UITableViewHeaderFooterView *foot = (UITableViewHeaderFooterView *)view;
    foot.textLabel.textColor = [UIColor lightGrayColor];
    

}






@end

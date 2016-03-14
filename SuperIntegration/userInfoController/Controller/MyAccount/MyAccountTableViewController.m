//
//  MyAccountTableViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/1/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "MyAccountTableViewController.h"
#import "PostImageView.h"

@interface MyAccountTableViewController ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *lb_userName;

//昵称
@property (weak, nonatomic) IBOutlet UILabel *lb_nickName;
//性别
@property (weak, nonatomic) IBOutlet UILabel *lb_sex;

@end

@implementation MyAccountTableViewController
{
    
    UserModel *_model;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的账户";
    
    [self initUserInfo];
}

- (void)initUserInfo{
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    NSLog(@"userid = %@",str);
    
    [HXYTool userNotLogin:self login:^{
       
        
        [[NetworkService sharedInstance] getUserInformationWithUserId:str  Success:^{
        
       
        [self initNameAndSex];
        
    } Failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    
    }];

        
    }];
        

    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //刷新昵称，性别(减少网络消耗)
    [self initNameAndSex];
    
}

- (void)initNameAndSex{
    
    _model = [ModelManager getUserModel];
    self.lb_nickName.text = STR_IS_NIL(_model.nickname) ? @"":_model.nickname;
    self.lb_userName.text = STR_IS_NIL(_model.realname) ? @"":_model.realname;
    NSUInteger num = _model.sex;
    switch (num) {
        case 0:
            self.lb_sex.text = @"保密";
            break;
        case 1:
            self.lb_sex.text = @"男";
            break;
        case 2:
            self.lb_sex.text = @"女";
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        [[PostImageView sharedPostImageView] createActionSheetViewWithViewController:self title:nil andMethod:^(UIImage *image, NSString *imagePath, NSData *imageData) {
            self.img_icon.image = image;
           // [SVProgressHUD showWithStatus:@"正在上传..." maskType:SVProgressHUDMaskTypeClear];
//            [[NetworkService sharedInstance] uploadFile:imagePath data:imageData Success:^(NSDictionary *responseObject) {
//                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
//                _fileId = responseObject[@"fileId"];
//                
//                [[NetworkService sharedInstance] userEditInfo:@{@"gender":_model.gender,
//                                                                @"nickname":_model.nickname,
//                                                                @"fileId":_fileId} Success:^(NSDictionary *responseObject) {
//                                                                } fail:^(NSError *error) {
//                                                                    
//                                                                }];
//                
//            } fail:^(NSError *error) {
//                [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
//            }];
            DLog(@"imagepath %@" ,imagePath);
        }];
    }
    
    
}

@end

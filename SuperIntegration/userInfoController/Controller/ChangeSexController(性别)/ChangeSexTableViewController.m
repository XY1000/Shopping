//
//  ChangeSexTableViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/2/25.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ChangeSexTableViewController.h"
#import "ChangeSexTableViewCell.h"

@interface ChangeSexTableViewController ()

@end

@implementation ChangeSexTableViewController
{
    UserModel *_model;
    UIButton *_tmpCellBtn;
    NSInteger _tmpSex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改性别";
    _model = [ModelManager getUserModel];
    self.tableView.tableFooterView = [UIView new];
    _tmpSex = _model.sex;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangeSexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:changeSex_Cell forIndexPath:indexPath];
    
    //cell.selectionStyle =
    
    switch (indexPath.row) {
        case 0:{
            cell.name.text = @"男";//1
        
            if (_model.sex == 1) {
                
                cell.button.selected = YES;
                _tmpCellBtn = cell.button;
            }
            
            break;
        }
        case 1:{
            
        
            cell.name.text = @"女";//2
            if (_model.sex == 2) {
                
                cell.button.selected = YES;
                _tmpCellBtn = cell.button;

            }
            
            break;
        }
        case 2:
        {
            cell.name.text = @"保密";//0
            if (_model.sex == 0) {
                
                cell.button.selected = YES;
                _tmpCellBtn = cell.button;

            }
            break;
        }
        default:
            break;
    }
    
  
    
   
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ChangeSexTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     if (indexPath.row == 0) {
        _model.sex = 1;
    }else if (indexPath.row == 1){
        _model.sex = 2;
    }else{
        _model.sex = 0;
    }
    
     _tmpCellBtn.selected = NO;
    cell.button.selected = YES;
    
    [[NetworkService sharedInstance] putUserChangeInformationWithRealName:_model.realname NickName:_model.nickname Sex:_model.sex Success:^{
        
   
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
        
        _tmpSex = _model.sex;
        
    } Failure:^(NSError *error) {
        
    [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    
        _model.sex = _tmpSex;
        
    }];
    
   
    
   
    
    _tmpCellBtn = cell.button;
}



@end

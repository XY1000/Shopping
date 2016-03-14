//
//  AddressViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/1/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "AddressViewController.h"
#import "CreatAddressTableViewController.h"
#import "AddressTableViewCell.h"
#import "AddressModel.h"
#import "EditAddressController.h"

@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , copy)NSMutableArray *allAddresss;

@end

@implementation AddressViewController
{
    
    UIAlertController *_alert;
    void (^deletBlock)();
    UIButton *_tmpBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationItem.title = @"地址管理";
    self.tableView.tableFooterView = [UIView new];
    
    [self initAlertDel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getAddressData];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.allAddresss = nil;
    
}

- (void)getAddressData{
    
    
    [HXYTool userNotLogin:self login:^{
        
        [[NetworkService sharedInstance] getUserAddressListSuccess:^(NSArray *responseObject) {
            
            //字典转模型
            for (NSDictionary *dic in responseObject) {
                
                AddresslistModel *model = [AddresslistModel new];
                
                [model mj_setKeyValues:dic];

                [self.allAddresss addObject:model];
            }
                        
            [self.tableView reloadData];
            
        } Failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];

        }];
        
        
    }];
    
    
    
    
    
}



- (void)initAlertDel{
    _alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //执行删除
        
        deletBlock();
        
    }];
    
    UIAlertAction * action5 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [_alert addAction:action1];
    [_alert addAction:action5];
    
}



//删除
- (IBAction)deletClick:(UIButton *)sender {
    
    DLog(@"删除");
    [self presentViewController:_alert animated:YES completion:nil];
    
    
    
    AddressTableViewCell *cell = (AddressTableViewCell *)sender.superview.superview;
    
    __weak typeof(self) mySelf = self;
    
    deletBlock = ^{
    [[NetworkService sharedInstance] deleteUserAddressWithAddressId:cell.listModel.id1 Success:^{
        
        if (sender.tag == 100) {
            
            [mySelf.allAddresss removeObjectAtIndex:0];
            
        }else{
            
        [mySelf.allAddresss removeObjectAtIndex:sender.tag -100];
            
        }
        
        
        [mySelf.tableView reloadData];
            
            
            
        } Failure:^(NSError *error) {
            
            
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];

            
        }];
    
        
   
    };
    
}

//设置默认
- (IBAction)moRenClick:(UIButton *)sender {
    DLog(@"moren");
    
    
   
    AddressTableViewCell *cell = (AddressTableViewCell *)sender.superview.superview;

    [[NetworkService sharedInstance] postAddressDefaultAddressId:[NSString stringWithFormat:@"%ld",(long)cell.listModel.id1] Success:^{
        
        DLog(@"设置default成功");
        
        _tmpBtn.selected = NO;
         sender.selected = !sender.selected;
        
        _tmpBtn = sender;
        
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
         
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 新建地址按钮

- (IBAction)ClickBtn:(UIButton *)sender {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:StoryBoard_User bundle:nil];
    
    CreatAddressTableViewController *vc = [story instantiateViewControllerWithIdentifier:CreatAddressController];
    
    
    [self.navigationController showViewController:vc sender:self];
}

#pragma mark - UITableViewDelegate/dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.allAddresss.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:address_Cell forIndexPath:indexPath];
    
    AddresslistModel *model = self.allAddresss[indexPath.section];
    cell.tag = indexPath.section + 100;
    cell.listModel = model;
    
    if (cell.listModel.isDefault) {
        
        _tmpBtn = cell.defaultBtn;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


- (NSMutableArray *)allAddresss {
	if(_allAddresss == nil) {
		_allAddresss = [[NSMutableArray alloc] init];
	}
	return _allAddresss;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
    
}


#pragma mark - 跳转准备
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:Segue_editAddress]) {
        
        EditAddressController *vc = (EditAddressController *)segue.destinationViewController;
        UIButton *btn = (UIButton *)sender;
        AddressTableViewCell *cell = (AddressTableViewCell *)btn.superview.superview;
        vc.model = cell.listModel;
    }
    
}


@end

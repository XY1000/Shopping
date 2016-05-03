//
//  OrderAddressManagerTableViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/8.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderAddressManagerTableViewController.h"
#import "OrderAddressTableViewCell.h"
#import "AddressModel.h"
#import "CreatAddressTableViewController.h"
@interface OrderAddressManagerTableViewController ()

@property (strong, nonatomic) NSMutableArray *mArray_AddressList;
@property (strong, nonatomic) UIView *view_BottomView;

@end

@implementation OrderAddressManagerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mArray_AddressList = [NSMutableArray array];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, SCREEN_WIDTH);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getAddressList];
    
    self.view_BottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    self.view_BottomView.backgroundColor = [UIColor whiteColor];
    [WINDOW addSubview:self.view_BottomView];
    
    UIButton *btn_CreateAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_CreateAddress setFrame:CGRectMake((SCREEN_WIDTH - 180) / 2, (self.view_BottomView.frame.size.height - 35) / 2, 180, 35)];
    btn_CreateAddress.backgroundColor = RGB(204, 10, 42);
    [btn_CreateAddress setTitle:@"+ 新建地址" forState:UIControlStateNormal];
    [btn_CreateAddress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_CreateAddress addTarget:self action:@selector(btn_CreateAddressClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view_BottomView addSubview:btn_CreateAddress];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view_BottomView removeFromSuperview];
    self.view_BottomView = nil;
}

- (void)btn_CreateAddressClicked {
    CreatAddressTableViewController *createAddressCon = [STOARYBOARD(@"User") instantiateViewControllerWithIdentifier:@"CreatAddressTableViewController"];
    [self.navigationController pushViewController:createAddressCon animated:YES];
}

- (void)getAddressList {
    
    [self.mArray_AddressList removeAllObjects];
    
    [[NetworkService sharedInstance] getUserAddressListSuccess:^(NSArray *responseObject) {
        //字典转模型
        for (NSDictionary *dic in responseObject) {
            
            AddresslistModel *model = [AddresslistModel new];
            
            [model mj_setKeyValues:dic];
            
            [self.mArray_AddressList addObject:model];
        }
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (ARRAY_IS_NIL(self.mArray_AddressList)) {
        return 0;
    }
    return self.mArray_AddressList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [Utility setTableFooterViewZero:tableView];
    OrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderAddressTableViewCell" forIndexPath:indexPath];
    
    [cell cellWithModel:self.mArray_AddressList[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderAddressTableViewCell *cell = (OrderAddressTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.block_DidSelectAddress(cell.model_Address);
    [self.navigationController popViewControllerAnimated:YES];
}

@end

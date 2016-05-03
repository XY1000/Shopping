//
//  OrderDetailTableViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderDetailTableViewController.h"
//cells
#import "OrderDetailStateTableViewCell.h"
#import "OrderAddressTableViewCell.h"
#import "OrderProductTableViewCell.h"
#import "OrderPayTypeTableViewCell.h"
#import "OrderDetailDateTableViewCell.h"
#import "OrderPayAmountTableViewCell.h"
#import "OrderDetailPaidAmountTableViewCell.h"
//model
#import "OrderModel.h"
//view
#import "OrderDetailBottomView.h"
//controller
#import "ProductDetailPageViewController.h"

@interface OrderDetailTableViewController ()
{
    NSArray *_orderDetailArray;
}

@property (strong, nonatomic) OrderDetailBottomView *bottomView;

@end

@implementation OrderDetailTableViewController

static NSString * const reusableStateCellIdentifier                     = @"OrderDetailStateTableViewCell";
static NSString * const reusableAddressCellIdentifier                   = @"OrderAddressTableViewCell";
static NSString * const reusableProductCellIdentifier                   = @"OrderProductTableViewCell";
static NSString * const reusableTypeCellIdentifier                      = @"OrderPayTypeTableViewCell";
static NSString * const reusableDateCellIdentifier                      = @"OrderDetailDateTableViewCell";
static NSString * const reusablePayAmountCellIdentifier                 = @"OrderPayAmountTableViewCell";
static NSString * const reusablePaidAmountCellIdentifier                = @"OrderDetailPaidAmountTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, SCREEN_WIDTH);
    

    [self createBottomView];
    [self getOrderDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.bottomView.superview == nil) {
        [WINDOW addSubview:self.bottomView];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.bottomView removeFromSuperview];
}

#pragma mark 创建底部视图
- (void)createBottomView {
    self.bottomView = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailBottomView" owner:nil options:nil] lastObject];
    [self.bottomView setFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    
    //删除订单
    self.bottomView.deleteOrderClickedBlock = ^() {
        
    };
    //申请售后
    self.bottomView.customerServiceClickedBlock = ^() {
        
    };
    //再次购买
    self.bottomView.againBuyClickedBlock = ^() {
        
    };
}

#pragma mark 请求数据
- (void)getOrderDetail {
    [[NetworkService sharedInstance] getOrderDetailWithOrderNumber:self.orderNumber
                                                           Success:^(NSArray *responseObject) {
                                                               _orderDetailArray = responseObject;
                                                               
                                                               [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 6)] withRowAnimation:UITableViewRowAnimationNone];
                                                           } Failure:^(NSError *error) {
                                                               [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                           }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        if (ARRAY_IS_NIL(_orderDetailArray)) {
            return 1;
        }
        OrderDetailModel *model = _orderDetailArray[0];
        NSArray *productListArray = model.productList;
        return productListArray.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        OrderDetailStateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableStateCellIdentifier forIndexPath:indexPath];
        [cell cellWithNumber:self.orderNumber State:self.orderState];
        return cell;
    }
    if (indexPath.section == 1) {
        OrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableAddressCellIdentifier forIndexPath:indexPath];
        OrderDetailModel *model = _orderDetailArray[0];
        [cell cellWithOrderDetailModel:model];
        return cell;
    }
    if (indexPath.section == 2) {
        OrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableProductCellIdentifier forIndexPath:indexPath];
        OrderDetailModel *model = _orderDetailArray[0];
        NSArray *productListArray = model.productList;
        [cell cellWithOrderDetailModel:productListArray[indexPath.row]];
        return cell;
    }
    if (indexPath.section == 3) {
        OrderPayTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableTypeCellIdentifier forIndexPath:indexPath];
        [cell cellWithOrderDetailModel:_orderDetailArray[0]];
        return cell;
    }
    if (indexPath.section == 4) {
        OrderDetailDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableDateCellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    if (indexPath.section == 5) {
        OrderPayAmountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusablePayAmountCellIdentifier forIndexPath:indexPath];
        OrderDetailModel *model = _orderDetailArray[0];
        [cell cellWithProductPrice:self.orderPaidAmount roadPrice:model.freight];
        return cell;
    }
    if (indexPath.section == 6) {
        OrderDetailPaidAmountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusablePaidAmountCellIdentifier forIndexPath:indexPath];
        [cell cellWithPaidAmount:self.orderPaidAmount];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 30;
    }
    if (indexPath.section == 2) {
        return PublicZeroCellHeight;
    }
    if ((indexPath.section == 4) || (indexPath.section == 6)) {
        return 40;
    }
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    backView.backgroundColor = RGB(245, 246, 247);
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 5) {
        return 1;
    }
    if (section == 6) {
        return 49;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        OrderDetailModel *model = _orderDetailArray[0];
        NSArray *productListArray = model.productList;
        OrderDetailModelProductList *productModel = productListArray[indexPath.row];
        ProductDetailPageViewController *productDetailCon = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageViewController"];
        productDetailCon.productDetailId = productModel.sku;
        [self.navigationController pushViewController:productDetailCon animated:YES];
    }
}

@end

//
//  OrderFillInTableViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderFillInTableViewController.h"
//cells
#import "OrderAddressTableViewCell.h"
#import "OrderProductTableViewCell.h"
#import "OrderPayTypeTableViewCell.h"
#import "OrderPayAmountTableViewCell.h"
//models
#import "ShoppingCartPageModel.h"
#import "AddressModel.h"
//views
#import "OrderCommitView.h"
//controllers
#import "OrderPayViewController.h"
#import "ProductDetailPageViewController.h"
#import "OrderAddressManagerTableViewController.h"

@interface OrderFillInTableViewController ()
{
    //默认地址的model
    AddresslistModel    *_defaultAddressModel;
}
@property (weak, nonatomic) OrderCommitView *commitView;
@property (strong, nonatomic) NSMutableArray *productListArray;
//订单总价
@property (copy, nonatomic) NSString *totalAmount;
//运费
@property (assign, nonatomic) CGFloat freightPrice;
//订单价格
@property (copy, nonatomic) NSString *amountPrice;
@end

@implementation OrderFillInTableViewController

#pragma mark 注册需要的Identifier
static NSString * const reusableOrderAddressIdentifier              = @"OrderAddressTableViewCell";
static NSString * const reusableOrderProductIdentifier              = @"OrderProductTableViewCell";
static NSString * const reusableOrderPayTypeIdentifier              = @"OrderPayTypeTableViewCell";
static NSString * const reusableOrderPayAmountIdentifier            = @"OrderPayAmountTableViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, SCREEN_WIDTH);
    
//    __weak OrderFillInTableViewController *weakSelf = self;
    
//    [WINDOW addSubview:_commitView];
    _totalAmount = @"";
    _freightPrice = 0.0;
    _amountPrice = @"";
    _productListArray = [NSMutableArray array];
    for (ShoppingCartPageModel *cartModel in self.productsArray) {
        NSDictionary *dic = @{@"sku":cartModel.sku, @"num":@(cartModel.amount)};
        [_productListArray addObject:dic];
    }

#pragma mark 请求数据
    [self getDefaultAddress];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#pragma mark 底部提交订单视图
    _commitView = [[[NSBundle mainBundle] loadNibNamed:@"OrderCommitView" owner:nil options:nil] lastObject];
    [_commitView setFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    
    //提交订单
    _commitView.commitClickedBlock = ^() {
        
        if (_defaultAddressModel == nil) {
            [SVProgressHUD showErrorWithStatus:@"请完善地址"];
            return ;
        }
        
        [SVProgressHUD showWithStatus:@"正在创建订单..."];
        if (!(OBJ_IS_NULL(_defaultAddressModel) || (_defaultAddressModel.id1 == 0))) {
            /**
             *  批量库存查询
             */
            NSMutableArray *productSkusArray = [NSMutableArray array];
            for (ShoppingCartPageModel *cartModel in self.productsArray) {
                [productSkusArray addObject:cartModel.sku];
            }
            [[NetworkService sharedInstance] getProcuctInventoryWithProductSkus:(NSArray *)productSkusArray
                                                                         CityId:_defaultAddressModel.cityId
                                                                        Success:^() {
                                                                            
                                                                            /**
                                                                             *  创建订单
                                                                             */
                                                                            
                                                                            [[NetworkService sharedInstance] postOrderCreateWithAddressId:_defaultAddressModel.id1 ProductList:self.productListArray
                                                                                                                                  Success:^(NSDictionary *responseObject) {
                                                                                                                                      NSLog(@"createOrderSuccess");
                                                                                                                                      
                                                                                                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"cartAmount" object:nil];
                                                                                                                                      
                                                                                                                                    
                                                                                                                                      [SVProgressHUD dismiss];
                                                                                                                                      OrderPayViewController *orderPayCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"OrderPayViewController"];
                                                                                                                                      orderPayCon.orderDic = responseObject;
                                                                                                    
                                                                                                                                      _commitView.btn_commitOrder.enabled = YES;
                                                                                                                                      [self.navigationController pushViewController:orderPayCon animated:YES];
                                                                                                                                      
                                                                                                                                  } Failure:^(NSError *error) {
                                                                                                                                      [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                                                                                                      _commitView.btn_commitOrder.enabled = YES;
                                                                                                                                  }];
                                                                            
                                                                        } Failure:^(NSError *error) {
                                                                            [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                                            _commitView.btn_commitOrder.enabled = YES;
                                                                        }];
        }
        
        
    };
    [WINDOW addSubview:_commitView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_commitView removeFromSuperview];
}

#pragma mark  请求数据
//获得默认地址
- (void)getDefaultAddress {
    
    [[NetworkService sharedInstance] getUserAddressListSuccess:^(NSArray *responseObject) {
        //字典转模型
        for (NSDictionary *dic in responseObject) {
            
            AddresslistModel *model = [AddresslistModel new];
            
            [model mj_setKeyValues:dic];
            
            _defaultAddressModel = model;
            if (model.isDefault == 1) {
                _defaultAddressModel = model;

                [self getOrderPrice];
                return ;
            }
        }

        [self getOrderPrice];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
//计算订单价格
- (void)getOrderPrice {
    [[NetworkService sharedInstance] postOrderCreateWithCityId:_defaultAddressModel.cityId.integerValue ProductList:self.productListArray Success:^(NSDictionary *responseObject) {
        if (DIC_CONTAIN_STR(responseObject, @"totalAmount")) {
            self.totalAmount = [NSString stringWithFormat:@"%.2f", [responseObject[@"totalAmount"] floatValue]];
        }
        if (DIC_CONTAIN_STR(responseObject, @"amount")) {
            self.amountPrice = [NSString stringWithFormat:@"%.2f", [responseObject[@"amount"] floatValue]];
        }
        if (DIC_CONTAIN_STR(responseObject, @"freight")) {
            self.freightPrice = [responseObject[@"freight"] floatValue];
        }
        _commitView.allPriceLabel.text = [NSString stringWithFormat:@"%@分", self.totalAmount];
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.productsArray.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [Utility setTableFooterViewZero:tableView];
    if (indexPath.section == 0) {
        OrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableOrderAddressIdentifier forIndexPath:indexPath];
//        cell.userInteractionEnabled = NO;
        if (_defaultAddressModel != nil) {
            [cell cellWithModel:_defaultAddressModel];
//            cell.userInteractionEnabled = YES;
        }
        
        return cell;
    }
    if (indexPath.section == 1) {
        OrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableOrderProductIdentifier forIndexPath:indexPath];
        ShoppingCartPageModel *model = self.productsArray[indexPath.row];
        [cell cellWithModel:model];
        return cell;
    }
    if (indexPath.section == 2) {
        OrderPayTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableOrderPayTypeIdentifier forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section == 3) {
        OrderPayAmountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableOrderPayAmountIdentifier forIndexPath:indexPath];

        [cell cellWithProductPrice:self.amountPrice roadPrice:self.freightPrice];
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    backView.backgroundColor = RGB(245, 246, 247);
    return backView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    backView.backgroundColor = RGB(245, 246, 247);
    return backView;
}

#pragma mark <tablViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return PublicZeroCellHeight;
    }
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 59;
    }
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        OrderAddressManagerTableViewController *managerCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"OrderAddressManagerTableViewController"];
        managerCon.block_DidSelectAddress = ^(AddresslistModel *model) {
            _defaultAddressModel = model;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            [self getOrderPrice];
        };
        [self.navigationController pushViewController:managerCon animated:YES];
    }
    if (indexPath.section == 1) {
        ShoppingCartPageModel *model = self.productsArray[indexPath.row];
        ProductDetailPageViewController *productDetailCon = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageViewController"];
        productDetailCon.productDetailId = model.sku;
        [self.navigationController pushViewController:productDetailCon animated:YES];
    }
}


@end

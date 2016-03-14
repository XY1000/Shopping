//
//  OrderAllListCollectionViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderAllListCollectionViewController.h"
//models
#import "OrderModel.h"
//cells
#import "PublicZeroCollectionViewCell.h"
//views
#import "OrderAllListHeaderCollectionReusableView.h"
#import "OrderAllListFooterCollectionReusableView.h"
//controller
#import "OrderDetailTableViewController.h"
#import "ProductDetailPageCollectionViewController.h"

@interface OrderAllListCollectionViewController ()<UICollectionViewDelegateFlowLayout>
{
    NSArray *_orderListArray;
}

@end

@implementation OrderAllListCollectionViewController

static NSString * const reusableCellIdentifier              = @"PublicZeroCollectionViewCell";
static NSString * const reusableHeaderViewIdentifier        = @"OrderAllListHeaderCollectionReusableView";
static NSString * const reusableFooterViewIdentifier        = @"OrderAllListFooterCollectionReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:reusableCellIdentifier bundle:nil] forCellWithReuseIdentifier:reusableCellIdentifier];
    
    if (self.orderType == allOrderList) {
        self.title = @"全部订单";
        [self getAllOrderList];
    }
    if (self.orderType == unPayOrderList) {
        self.title = @"未支付订单";
        [self getUnPayOrderList];
    }
    if (self.orderType == unSendOrderList) {
        self.title = @"待发货订单";
        [self getUnSendOrderList];
    }
    if (self.orderType == unReceiveOrderList) {
        self.title = @"待收货订单";
        [self getUnReceiveOrderList];
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 请求数据
//全部订单
- (void)getAllOrderList {
    [[NetworkService sharedInstance] getOrderAllWithRows:50 Page:1 Success:^(NSArray *responseObject) {
        _orderListArray = responseObject;
        [self.collectionView reloadData];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
//未支付订单
- (void)getUnPayOrderList {
    [[NetworkService sharedInstance] getOrderUnpayWithRows:50 Page:1 Success:^(NSArray *responseObject) {
        _orderListArray = responseObject;
        [self.collectionView reloadData];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
//待发货订单
- (void)getUnSendOrderList {
    [[NetworkService sharedInstance] getOrderUnSendWithRows:50 Page:1 Success:^(NSArray *responseObject) {
        _orderListArray = responseObject;
        [self.collectionView reloadData];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
//待收货订单
- (void)getUnReceiveOrderList {

}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (ARRAY_IS_NIL(_orderListArray)) {
        return 0;
    }
    return _orderListArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (ARRAY_IS_NIL(_orderListArray)) {
        return 0;
    }
    OrderModel *model = _orderListArray[section];
    NSArray *productListArray = model.productList;
    return productListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PublicZeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableCellIdentifier forIndexPath:indexPath];
    
    OrderModel *model = _orderListArray[indexPath.section];
    NSArray *array = model.productList;
    [cell cellWithOrderModel:array[indexPath.item]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        OrderAllListHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableHeaderViewIdentifier forIndexPath:indexPath];
        
        if (!ARRAY_IS_NIL(_orderListArray)) {
            [headerView viewWithModel:_orderListArray[indexPath.section]];
        }
        /**
         *  进入订单详情
         */
        headerView.goDetailButtonClicked = ^(NSString *orderNumber, NSString *orderState) {
            OrderDetailTableViewController *orderDetailCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"OrderDetailTableViewController"];
            orderDetailCon.orderNumber = orderNumber;
            orderDetailCon.orderState = orderState;
            OrderModel *model = _orderListArray[indexPath.section];
            orderDetailCon.orderPaidAmount = [NSString stringWithFormat:@"%ld",(long)model.orderAmount];
            [self.navigationController pushViewController:orderDetailCon animated:YES];
        };
        
        return headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        OrderAllListFooterCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableFooterViewIdentifier forIndexPath:indexPath];
        
        if (!ARRAY_IS_NIL(_orderListArray)) {
            [footerView viewWithModel:_orderListArray[indexPath.section]];
        }
        
        return footerView;
    }
    return nil;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 0, 1, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, PublicZeroCellHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, OrderAllList_CellHeaderViewHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, OrderAllList_HeaderViewHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *model = _orderListArray[indexPath.section];
    NSArray *productListArray = model.productList;
    OrderModelProductList *productModel = productListArray[indexPath.item];
    ProductDetailPageCollectionViewController *productDetailCon = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageCollectionViewController"];
    productDetailCon.productDetailId = productModel.sku;
    [self.navigationController pushViewController:productDetailCon animated:YES];
}
@end

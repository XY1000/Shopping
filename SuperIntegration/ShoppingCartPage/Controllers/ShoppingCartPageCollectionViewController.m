//
//  ShoppingCartPageCollectionViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ShoppingCartPageCollectionViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>//
//models
#import "ShoppingCartPageModel.h"
//cells
#import "ShoppingCartPageCartEmptyCollectionViewCell.h"
#import "ShoppingCartPageCartCollectionViewCell.h"
//controllers
#import "BaseNavViewController.h"
//views
#import "ShoppingCartPageCompeleteView.h"
#import "ShoppingCartPageEditView.h"
#import "ShoppingCartPageHeaderCollectionReusableView.h"
#import "ShoppingCartPageFooterCollectionReusableView.h"
//controller
#import "OrderFillInTableViewController.h"
#import "ProductDetailPageViewController.h"

@interface ShoppingCartPageCollectionViewController()<UICollectionViewDelegateFlowLayout>
{
    //购物车列表(默认全选)
    NSMutableArray *_shoppingCartMArray;
    NSString       *_freight;
    NSInteger      _freightLine;
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightItem;
@property (weak, nonatomic) IBOutlet UIButton *rightItemButton;

@property (strong, nonatomic) ShoppingCartPageCompeleteView *completeView;
@property (strong, nonatomic) ShoppingCartPageEditView *editView;

//cell的类型
@property (assign, nonatomic) CellType cellType;

@end

@implementation ShoppingCartPageCollectionViewController

#pragma mark 注册需要的Identifier
static NSString * const reusableEmptyCartCellIdentifier         = @"ShoppingCartPageCartEmptyCollectionViewCell";
static NSString * const reusableCartCellIdentifier              = @"ShoppingCartPageCartCollectionViewCell";
static NSString * const reusableCartHeaderViewIdentifier        = @"ShoppingCartPageHeaderCollectionReusableView";
static NSString * const reusableCartFooterViewIdentifier        = @"ShoppingCartPageFooterCollectionReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ShoppingCartManager sharedInstance].completeSelectedMArray = [NSMutableArray array];
    [ShoppingCartManager sharedInstance].editSelectMArray = [NSMutableArray array];
    
#pragma mark 添加上拉下拉刷新
    //添加下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.collectionView.mj_header beginRefreshing];
        _cellType = compelteCell;
        
        //获得购物车列表
        [self getCartList];
        
    }];
#pragma mark   创建底部编辑视图
    [self createCompleteView];
    [self createEditView];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
#pragma mark   定位导航栏右侧按钮位置
    [self.rightItemButton setHidden:YES];
    [self.rightItemButton setSelected:NO];
    [self.navigationItem setCustomRightBarButtonItem:self.rightItem ToRightValue:-2];

    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        _cellType = compelteCell;
        [self getAddRoadPrice];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Method
//获得购物车列表
- (void)getCartList {
    
    [[ShoppingCartManager sharedInstance].completeSelectedMArray removeAllObjects];
    [[ShoppingCartManager sharedInstance].editSelectMArray removeAllObjects];
    [JFLoadingView JF_Loading];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        [_shoppingCartMArray removeAllObjects];
        [[NetworkService sharedInstance] getShoppingCartPageListSuccess:^(NSArray *responseObject) {
            DLog(@"购物车列表 = %lu", (long)responseObject.count);
            _shoppingCartMArray = [NSMutableArray arrayWithArray:responseObject];
            
            if (!ARRAY_IS_NIL(_shoppingCartMArray)) {
                if (_cellType == compelteCell) {
                    if (!OBJ_IS_NULL(self.completeView.superview)) {
                        [self.view addSubview:self.completeView];
                    }
                }
                if (_cellType == editCell) {
                    if (!OBJ_IS_NULL(self.editView.superview)) {
                        [self.view addSubview:self.editView];
                    }
                }
            } else {
                [self.completeView removeFromSuperview];
                [self.editView removeFromSuperview];
            }
            
            [ShoppingCartManager sharedInstance].allMArray = _shoppingCartMArray;
            
            for (ShoppingCartPageModel *model in _shoppingCartMArray) {
                [[ShoppingCartManager sharedInstance].completeSelectedMArray addObject:model];
            }
            for (ShoppingCartPageModel *model in _shoppingCartMArray) {
                [[ShoppingCartManager sharedInstance].editSelectMArray addObject:model];
            }
            [self.completeView completeViewContentWithArray:[ShoppingCartManager sharedInstance].completeSelectedMArray];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cartAmount" object:nil];
            [self.collectionView reloadData];
            [JFLoadingView JF_LoadSuccess];
            [self.collectionView.mj_header endRefreshing];
        } Failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
            [JFLoadingView JF_LoadSuccess];
        }];
    } else {
        [JFLoadingView JF_LoadSuccess];
        [self.collectionView.mj_header endRefreshing];
        [_shoppingCartMArray removeAllObjects];
        [self.completeView removeFromSuperview];
        [self.editView removeFromSuperview];
        [self.collectionView reloadData];
        [SVProgressHUD showErrorWithStatus:@"请登录"];
    }
}

- (void)getAddRoadPrice {
    [[NetworkService sharedInstance] getAddRoadPriceSuccess:^(NSDictionary *responseObject) {
        _freight = responseObject[@"freight"];
        _freightLine = [responseObject[@"freightLine"] integerValue];
        //获得购物车列表
        [self getCartList];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}

- (IBAction)rightItemClicked:(id)sender {
    if (self.rightItemButton.selected) {
        [self.rightItemButton setSelected:NO];
        _cellType = compelteCell;
        [self.view addSubview:self.completeView];
        [self.editView removeFromSuperview];
    } else {
        [self.rightItemButton setSelected:YES];
        [self.completeView removeFromSuperview];
        _cellType = editCell;
        [self.view addSubview:self.editView];
    }
    [self.collectionView reloadData];
}

#pragma mark createView
- (void)createCompleteView {
    
    self.completeView = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCartPageCompeleteView" owner:nil options:nil] lastObject];
    [self.completeView setFrame:CGRectMake(0, SCREEN_HEIGHT - 49 - 64 - 50, SCREEN_WIDTH, 50)];
    
    //是否全选
    __weak ShoppingCartPageCollectionViewController *weakSelf = self;
    __block __weak NSMutableArray *tmpShoppingCartMArray = [NSMutableArray array];
    self.completeView.allSelectedClickedBlock = ^(BOOL isAllSelect) {
        tmpShoppingCartMArray = _shoppingCartMArray;
        [[ShoppingCartManager sharedInstance].completeSelectedMArray removeAllObjects];
        if (isAllSelect) {
            for (ShoppingCartPageModel *model in tmpShoppingCartMArray) {
                [[ShoppingCartManager sharedInstance].completeSelectedMArray addObject:model];
            }
            [weakSelf.completeView completeViewContentWithArray:[ShoppingCartManager sharedInstance].allMArray];
        }
        [weakSelf.completeView completeViewContentWithArray:[ShoppingCartManager sharedInstance].completeSelectedMArray];
        [weakSelf.collectionView reloadData];
    };
    
    //去结算
    self.completeView.completedBlock = ^() {
        OrderFillInTableViewController *orderCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"OrderFillInTableViewController"];
//        orderCon.allPrice = weakSelf.completeView.totalLabel.text;
        orderCon.productsArray = (NSArray *)[ShoppingCartManager sharedInstance].completeSelectedMArray;
        [weakSelf.navigationController pushViewController:orderCon animated:YES];
    };
    
}

- (void)createEditView {
    
    self.editView = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCartPageEditView" owner:nil options:nil] lastObject];
    [self.editView setFrame:CGRectMake(0, SCREEN_HEIGHT - 49 - 64 - 50, SCREEN_WIDTH, 50)];
    //是否全选
    __weak ShoppingCartPageCollectionViewController *weakSelf = self;
    __block __weak NSMutableArray *tmpShoppingCartMArray = [NSMutableArray array];
    self.editView.allSelectedClickedBlock = ^(BOOL isAllSelect) {
        tmpShoppingCartMArray = _shoppingCartMArray;
        [[ShoppingCartManager sharedInstance].editSelectMArray removeAllObjects];
        if (isAllSelect) {
            for (ShoppingCartPageModel *model in tmpShoppingCartMArray) {
                [[ShoppingCartManager sharedInstance].editSelectMArray addObject:model];
            }
        }
        [weakSelf.collectionView reloadData];
    };
    
    //批量删除
    self.editView.deleteClickedBlock = ^() {
        UIAlertController *alertController = [[UIAlertController alloc]
                                              initAlertWithTitle:@"提示"
                                              message:@"确定删除此商品吗?"
                                              preferredStyle:UIAlertControllerStyleAlert
                                              antionTitle:@"取消"
                                              actionStyle:UIAlertActionStyleDestructive
                                              actionHandle:^{
                                                  return ;
                                              }
                                              otherActionTitle:@"确定"
                                              otherActionStyle:UIAlertActionStyleDestructive
                                              otherActionHandle:^{
                                                  NSMutableArray *deleteArray = [NSMutableArray array];
                                                  for (ShoppingCartPageModel *model in [ShoppingCartManager sharedInstance].editSelectMArray) {
                                                      [deleteArray addObject:@(model.id)];
                                                  }
                                                  [[NetworkService sharedInstance] postShoppingCartPageDeleteCartsWithIdList:(NSArray *)deleteArray Success:^{
                                                      NSLog(@"批量删除成功");
                                                      [weakSelf getCartList];
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"cartAmount" object:nil];
                                                  } Failure:^(NSError *error) {
                                                      [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                  }];
                                              }];
        
        [alertController alertShowForViewController:weakSelf completion:^{
            
        }];
        
    };
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (ARRAY_IS_NIL(_shoppingCartMArray)) {
        return 1;
    }
    return _shoppingCartMArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (ARRAY_IS_NIL(_shoppingCartMArray)) {
        [self.rightItemButton setHidden:YES];
        ShoppingCartPageCartEmptyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableEmptyCartCellIdentifier forIndexPath:indexPath];
        [cell isHiddenLoginButtonSuperView];
        //登录
        cell.loginClickedBlock = ^() {
            BaseNavViewController *loginCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"BaseNavLoginViewController"];
            [self presentViewController:loginCon animated:YES completion:^{
                
            }];
        };
        //去逛逛
        cell.goShoppingClickedBlock = ^() {
            NSLog(@"去逛逛");
//            [SVProgressHUD showErrorWithStatus:@"该功能暂未实现"];
            self.tabBarController.selectedIndex = 0;
        };
        return cell;
    } else {
        
        self.rightItemButton.hidden = NO;
        
        ShoppingCartPageCartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableCartCellIdentifier forIndexPath:indexPath];
        
        ShoppingCartPageModel *model = _shoppingCartMArray[indexPath.item];
        
        [cell cellWithModel:model andCellType:_cellType];
        
        //编辑状态下不能操作
        if (_cellType == editCell) {
            cell.textField.userInteractionEnabled = NO;
        } else {
            cell.textField.userInteractionEnabled = YES;
        }
        
        /**
         *  更改底部视图选中状态
         */
        if (_shoppingCartMArray.count == [ShoppingCartManager sharedInstance].completeSelectedMArray.count) {
            [self.completeView.allButton setSelected:YES];
        } else {
            [self.completeView.allButton setSelected:NO];
        }
        if (_shoppingCartMArray.count == [ShoppingCartManager sharedInstance].editSelectMArray.count) {
            [self.editView.allButton setSelected:YES];
        } else {
            [self.editView.allButton setSelected:NO];
        }
        
        //修改购物车
        cell.updateClickedBlock = ^(NSInteger cartId, NSInteger nowAmount) {
            NSLog(@"修改购物车   %lu %lu", (long)cartId, (long)nowAmount);
            [[NetworkService sharedInstance] putShoppingCartPageUpdateCartWithCartId:cartId Amount:nowAmount Success:^{
                NSLog(@"修改成功");
//                [self getCartList];
                [self.completeView completeViewContentWithArray:[ShoppingCartManager sharedInstance].completeSelectedMArray];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cartAmount" object:nil];
            } Failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
            }];
        };
        //选择购物车
        cell.selectedClickedBlock = ^(NSInteger selectedMArrayCount) {
            if (_cellType == compelteCell) {
                [self.completeView completeViewContentWithArray:[ShoppingCartManager sharedInstance].completeSelectedMArray];
                if (selectedMArrayCount != _shoppingCartMArray.count) {
                    [self.completeView.allButton setSelected:NO];
                } else {
                    [self.completeView.allButton setSelected:YES];
                }
            }
            if (_cellType == editCell) {
                if (selectedMArrayCount != _shoppingCartMArray.count) {
                    [self.editView.allButton setSelected:NO];
                } else {
                    [self.editView.allButton setSelected:YES];
                }
                if (selectedMArrayCount == 0) {
                    self.editView.deleteButton.userInteractionEnabled = NO;
                    self.editView.deleteButton.backgroundColor = [UIColor lightGrayColor];
                } else {
                    self.editView.deleteButton.userInteractionEnabled = YES;
                    self.editView.deleteButton.backgroundColor = RGB(204, 10, 42);
                }
            }
        };
        
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        ShoppingCartPageHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableCartHeaderViewIdentifier forIndexPath:indexPath];
        headerView.label_AddRoadPrice.text = [NSString stringWithFormat:@"%ld分以下需加收多%@分运费", (long)_freightLine, _freight];
        headerView.freeOfChargeClickedBlock = ^() {
            NSLog(@"凑单免运费");
            [SVProgressHUD showErrorWithStatus:@"该功能暂未实现"];
        };
        return headerView;
    } else {
        ShoppingCartPageFooterCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableCartFooterViewIdentifier forIndexPath:indexPath];
        
        return footerView;
    }
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (ARRAY_IS_NIL(_shoppingCartMArray)) {
        return CGSizeMake(SCREEN_WIDTH, ShoppingCartPageDefine_EmptyCellHeight);
    }
    return CGSizeMake(SCREEN_WIDTH, PublicZeroCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        if (!ARRAY_IS_NIL(_shoppingCartMArray)) {
            return CGSizeMake(SCREEN_WIDTH, 40);
        }
    } else {
        return CGSizeMake(SCREEN_WIDTH, 0);
    }
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        if (!ARRAY_IS_NIL(_shoppingCartMArray)) {
            return CGSizeMake(SCREEN_WIDTH, 50);
        }
    } else {
        return CGSizeMake(SCREEN_WIDTH, 0);
    }
    return CGSizeMake(0, 0);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellType == editCell) {
        return;
    }
    if (!ARRAY_IS_NIL(_shoppingCartMArray)) {
        ShoppingCartPageModel *model = _shoppingCartMArray[indexPath.item];
        ProductDetailPageViewController *productDetailCon = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageViewController"];
        productDetailCon.productDetailId = model.sku;
        [self.navigationController pushViewController:productDetailCon animated:YES];
    }
}



@end

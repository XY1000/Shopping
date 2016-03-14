//
//  MineCollectionViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "MineCollectionViewController.h"
//headerView
#import "MineHeaderCollectionReusableView.h"
//cells
#import "MineSectionZeroCollectionViewCell.h"
#import "MineSectionOneCollectionViewCell.h"
#import "MineSectionTwoCollectionViewCell.h"
#import "MineSectionThreeCollectionViewCell.h"
//presentController
#import "BaseNavViewController.h"
//#import "LoginViewController.h"
//controller
#import "MyAccountTableViewController.h"
#import "IntegralRechargeViewController.h"
#import "OrderAllListCollectionViewController.h"
#import "AddressViewController.h"
#import "MyPageSetViewController.h"

@interface MineCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation MineCollectionViewController{
    //section == 0时里面各个item的起始点坐标
    CGFloat         originXForSection0;
    CGFloat         originYForSection0;
    
    //section1的图片和title
    NSArray         *_sectionOneImageArray;
    NSArray         *_sectionOneTitleArray;
    
    //查询到的用户积分
    NSInteger       _userIntegral;
}

//headerViewIdentifier
static NSString * const reusableHeaderViewsIdentifier     = @"MineHeaderCollectionReusableView";
//cellIdentifier
static NSString * const reusableSectionZeroIdentifier = @"MineSectionZeroCollectionViewCell";
static NSString * const reusableSectionOneIdentifier = @"MineSectionOneCollectionViewCell";
static NSString * const reusableSectionTwoIdentifier = @"MineSectionTwoCollectionViewCell";
static NSString * const reusableSectionThreeIdentifier = @"MineSectionThreeCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sectionOneImageArray = @[@"我的页面_21", @"我的页面_27", @"我的页面_18", @"我的页面_24"];
    _sectionOneTitleArray = @[@"待支付", @"待发货", @"待收货", @"退款/售后"];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
#pragma mark 注册section的headerView
    // Register header classes
    [self.collectionView registerNib:[UINib nibWithNibName:reusableHeaderViewsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableHeaderViewsIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        [self queryUserIntrgral];
    }
    _userIntegral = 0;
    [self.collectionView reloadData];
}

#pragma mark 请求数据
//查询用户积分
- (void)queryUserIntrgral {
    [[NetworkService sharedInstance] getUserQueryIntegralSuccess:^(NSInteger integral) {
        _userIntegral = integral;
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}

#pragma mark Method
//设置
- (IBAction)setUpClicked:(id)sender {
    MyPageSetViewController *setCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"MyPageSetViewController"];
    [self.navigationController pushViewController:setCon animated:YES];
}
//消息
- (IBAction)newsClicked:(id)sender {
    NSLog(@"消息");
}
//进入订单页
- (void)pushOrderConWithType:(NSInteger)type {
    OrderAllListCollectionViewController *orderAllListCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"OrderAllListCollectionViewController"];
    if (type == 1) {
        orderAllListCon.orderType = allOrderList;
    }
    if (type == 2) {
        orderAllListCon.orderType = unPayOrderList;
    }
    if (type == 3) {
        orderAllListCon.orderType = unSendOrderList;
    }
    if (type == 4) {
        orderAllListCon.orderType = unReceiveOrderList;
    }
    [self.navigationController pushViewController:orderAllListCon animated:YES];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return 4;
    }
    if (section == 3) {
        return 2;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MineSectionZeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableSectionZeroIdentifier forIndexPath:indexPath];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
            cell.userNickname.text = GetObjectUserDefault(@"nickname");
        } else {
            cell.userNickname.text = @"登录/注册";
        }
        
        return cell;
    }
    if (indexPath.section == 1) {
        MineSectionOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableSectionOneIdentifier forIndexPath:indexPath];
        
        [cell cellWithImageStr:_sectionOneImageArray[indexPath.item] Title:_sectionOneTitleArray[indexPath.item]];
        
//        //重新定位cell的位置 (消除其中两个cell之间的像素差)
//        originYForSection0 = cell.frame.origin.y;
//        [cell setFrame:CGRectMake(originXForSection0, originYForSection0, MineSectionOneCellWith, MineSectionOneCellHeight)];
//        originXForSection0 = cell.frame.origin.x + cell.frame.size.width;
//        NSLog(@"%f", originXForSection0);
//        
//        if (indexPath.item == 3) {
//            originXForSection0 = 0;
//            originYForSection0 = 0;
//        }
        
        return cell;
    }
    if (indexPath.section == 2) {
        MineSectionTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableSectionTwoIdentifier forIndexPath:indexPath];
        
        cell.integralLabel.text = [NSString stringWithFormat:@"%lu", (long)_userIntegral];
        /**
         *  支付宝充值
         */
        cell.zhifubaoClickedBlock = ^() {
            [self judgeIsLoginYes:^{
                [SVProgressHUD showErrorWithStatus:@"该功能暂未实现!"];
            }];
        };
        /**
         *  和包充值
         */
        cell.hebaoClickedBlock = ^() {
            [self judgeIsLoginYes:^{
                NSLog(@"和包充值");
                IntegralRechargeViewController *integralCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"IntegralRechargeViewController"];
                UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:integralCon];
                navCon.navigationBar.barTintColor = [UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f];
                navCon.navigationBar.translucent = NO;
                integralCon.myIntegral = _userIntegral;
                integralCon.zhifuType = hebaobao;
                //            [self.navigationController pushViewController:integralCon animated:YES];
                [self presentViewController:navCon animated:YES completion:^{
                    
                }];
            }];
        };
        /**
         *  积分兑换
         */
        cell.integralExchangeClickedBlock = ^() {
            [self judgeIsLoginYes:^{
                NSLog(@"积分兑换");
                [SVProgressHUD showErrorWithStatus:@"该功能暂未实现!"];
            }];
        };
        /**
         *  转账
         */
        cell.transactionClickedBlock = ^() {
            [self judgeIsLoginYes:^{
                NSLog(@"转账");
                [SVProgressHUD showErrorWithStatus:@"该功能暂未实现!"];
            }];
        };
        
        return cell;
    }
    if (indexPath.section == 3) {
        MineSectionThreeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableSectionThreeIdentifier forIndexPath:indexPath];
        
        if (indexPath.item == 0) {
            cell.titleLabel.text = @"账户管理,收货地址";
        }
        if (indexPath.item == 1) {
            cell.titleLabel.text = @"服务与反馈";
        }
        
        return cell;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == 1) || (indexPath.section == 2)) {
        MineHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableHeaderViewsIdentifier forIndexPath:indexPath];
        [headerView headerViewWithIndexPath:indexPath];
        
        //查看全部订单
        headerView.buttonClicked = ^() {
            NSLog(@"查看全部订单");
            [self judgeIsLoginYes:^{
                [self pushOrderConWithType:1];
            }];
        };
        
        return headerView;
    }
    return nil;
}

#pragma mark <UICollectionViewDelegate>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if (section == 3) {
        return UIEdgeInsetsMake(MineSectionThreeCellHeaderViewHeight, 0, 0, 0);
    }
    return UIEdgeInsetsMake(1, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, MineSectionZeroHeight);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(MineSectionOneCellWith, MineSectionOneCellHeight);
    }
    if (indexPath.section == 2) {
        return CGSizeMake(SCREEN_WIDTH, MineSectionTwoCellHeight);
    }
    if (indexPath.section == 3) {
        return CGSizeMake(SCREEN_WIDTH, MineSectionThreeCellHeight);
    }
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(0, 0);
    }
    if (section == 3) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(SCREEN_WIDTH, HeaderViewsHieght);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 3) {
        return 1.0;
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        [self judgeIsLoginYes:^{
            MyAccountTableViewController *vc = [STOARYBOARD(@"User") instantiateViewControllerWithIdentifier:@"MyAccountTableViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            
            return ;
        }];
        
    }
    if (indexPath.section == 1) {
        [self judgeIsLoginYes:^{
            [self pushOrderConWithType:indexPath.item + 2];
        }];
    }
    if (indexPath.section == 3) {
        if (indexPath.item == 0) {
            [self judgeIsLoginYes:^{
                AddressViewController *adddressViewController = [STOARYBOARD(@"User") instantiateViewControllerWithIdentifier:@"AddressViewController"];
                [self.navigationController pushViewController:adddressViewController animated:YES];
            }];
        } else {
            [self judgeIsLoginYes:^{
                [SVProgressHUD showErrorWithStatus:@"该功能暂未实现!"];
            }];
        }
        
    }
}

/**
 *  判断是否登录
 */
- (void)judgeIsLoginYes:(void(^)())yes {
    //已登录
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        yes();
    } else {
        //未登录
        BaseNavViewController *loginCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"BaseNavLoginViewController"];
        [self presentViewController:loginCon animated:YES completion:^{
            
        }];
    }
    
}


@end

//
//  FootPrintAllListCollectionViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "FootPrintAllListCollectionViewController.h"
//cells
#import "PublicZeroCollectionViewCell.h"
#import "FootPrintAllListCollectionReusableView.h"
//model
#import "SearchResultModel.h"
#import "ProductDetailPageViewController.h"

@interface FootPrintAllListCollectionViewController ()

@end

@implementation FootPrintAllListCollectionViewController
{
    NSMutableArray *_timeArray;
    NSMutableArray *_productArray;
    NSInteger _page;
    NSInteger _rows;
}

#pragma mark 注册需要的Identifier
static NSString * const reusablePublicZeroCellIdentifier        = @"PublicZeroCollectionViewCell";
static NSString * const reusableHeaderViewIdentifier            = @"FootPrintAllListCollectionReusableView";
static NSString * const reusableFooterViewIdentifier            = @"UICollectionReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];

#pragma mark 注册cell
    [self.collectionView registerClass:[PublicZeroCollectionViewCell class] forCellWithReuseIdentifier:reusablePublicZeroCellIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
#pragma mark 添加上拉下拉刷新
    _page = 1;
    _rows = 10;
    //添加下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.collectionView.mj_footer resetNoMoreData];
        _page = 1;
        [self.collectionView.mj_header beginRefreshing];
        [self getFootPrintListWithRows:_rows Page:_page];
        
    }];
    //添加上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page += 1;
        [self.collectionView.mj_footer beginRefreshing];
        [self getFootPrintListWithRows:_rows Page:_page];
    }];
    self.collectionView.mj_footer.automaticallyHidden = YES;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getFootPrintListWithRows:_rows Page:_page];
}

- (void)getFootPrintListWithRows:(NSInteger)rows Page:(NSInteger)page{
    [[NetworkService sharedInstance] getUserTraceListWithRows:rows Page:page Success:^(BOOL isHas, NSArray *timeArray, NSArray *productArray) {
        if (isHas) {
            NSArray *tmpArray = nil;
            NSArray *array_TmpPro = nil;
            if (_page == 1) {
                _timeArray = [NSMutableArray arrayWithArray:timeArray];
                _productArray = [NSMutableArray arrayWithArray:productArray];
            } else{
                tmpArray = [NSArray arrayWithArray:_timeArray];
                array_TmpPro = [NSArray arrayWithArray:_productArray];
                for (int i = 0; i < timeArray.count; i++) {
                    NSString *timeKey = timeArray[i];
                    BOOL isEqual = NO;
                    for (int j = 0; j < tmpArray.count; j++) {
                        if ([timeKey isEqualToString:tmpArray[j]]) {
                            for (SearchResultModel *model in productArray[i]) {
                                [_productArray[j] addObject:model];
                            }
                            isEqual = YES;
                        }
                    }
                    if (!isEqual) {//都不同才加
                        [_timeArray addObject:timeKey];
                        [_productArray addObject:productArray[i]];
                    }
                }
//                NSMutableIndexSet *set = [[NSMutableIndexSet alloc] init];
//                NSMutableArray *mArray_IndexPath = [NSMutableArray array];
//                for (NSInteger section = tmpArray.count; section < _timeArray.count; section++) {
//                    [set addIndex:section];
//                    for (NSInteger item = [array_TmpPro[section] count]; item < [_productArray[section] count]; item++) {
//                        NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
//                        [mArray_IndexPath addObject:tmpIndexPath];
//                    }
//                }
//                [self.collectionView insertItemsAtIndexPaths:mArray_IndexPath];
//                [self.collectionView insertSections:set];
            }
            [self.collectionView reloadData];
            
            
            
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
        } else {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return _timeArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = _productArray[section];
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = _productArray[indexPath.section];
    SearchResultModel *footPrintModel = array[indexPath.item];
    PublicZeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusablePublicZeroCellIdentifier forIndexPath:indexPath];
    [cell cellWithModel:footPrintModel];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        FootPrintAllListCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableHeaderViewIdentifier forIndexPath:indexPath];
        headerView.label_Time.text = _timeArray[indexPath.section];
        return headerView;
    } else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableFooterViewIdentifier forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor clearColor];
        return footerView;
    }
    
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 0, 1, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, PublicZeroCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, SearchResultHeaderViewHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 10);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = _productArray[indexPath.section];
    SearchResultModel *footPrintModel = array[indexPath.item];
    ProductDetailPageViewController *productDetailCon = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageViewController"];
    productDetailCon.productDetailId = footPrintModel.sku;
    [self.navigationController pushViewController:productDetailCon animated:YES];
}

@end

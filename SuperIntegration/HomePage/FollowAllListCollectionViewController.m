//
//  FollowAllListCollectionViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "FollowAllListCollectionViewController.h"
//cells
#import "PublicZeroCollectionViewCell.h"
//model
#import "SearchResultModel.h"
//searchView
#import "SearchView.h"
#import "SearchResultCollectionViewController.h"
#import "ProductDetailPageViewController.h"

@interface FollowAllListCollectionViewController ()<LeftSlipEditViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
/**
 *  它将存储当前已被打开的 Cell 的列表
 */
@property (nonatomic, strong) NSMutableSet *cellsCurrentlyEditing;
@end

@implementation FollowAllListCollectionViewController
{
    NSMutableArray *_followArray;
}

#pragma mark 注册需要的Identifier
static NSString * const reusablePublicZeroCellIdentifier        = @"PublicZeroCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellsCurrentlyEditing = [NSMutableSet new];
#pragma mark    searchButton
    [self.searchButton setFrame:CGRectMake(SearchResultButtonToLeftValue, SearchResultButtonToTopValue, SearchResultButtonWidth, 30)];
    self.searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, SearchResultButtonImageInsets, 0, 0);
    self.searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, -SearchResultButtonTitleInsets, 0, 0);
    
#pragma mark 注册cell
    [self.collectionView registerClass:[PublicZeroCollectionViewCell class] forCellWithReuseIdentifier:reusablePublicZeroCellIdentifier];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getFollowAllList];
}

- (void)getFollowAllList {
    [[NetworkService sharedInstance] getFavouriteListSuccess:^(NSArray *responseObject) {
        _followArray = [NSMutableArray arrayWithArray:responseObject];
        [self.collectionView reloadData];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}

//查询商品库存
- (void)inventoryProductWithSku:(NSString *)Sku num:(NSInteger)Num success:(void(^)())Success Failure:(void(^)())failure{
    [[NetworkService sharedInstance] getProcuctInventoryWithProductSku:Sku
                                                            ProductNum:Num
                                                                CityId:@"010"
                                                             CountryId:@"01"
                                                               Success:^{
                                                                   Success();
                                                               } Failure:^(NSError *error) {
                                                                   [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                                   failure();
                                                               }];
}

//创建搜索视图
- (IBAction)searchClicked:(id)sender {
    SearchView *searchView = [[[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:nil options:nil] firstObject];
    searchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [WINDOW addSubview:searchView];
    
    __weak SearchView *weakSearchViewSelf = searchView;
    //取消
    searchView.searchViewCancelClickedBlock = ^() {
        [weakSearchViewSelf removeFromSuperview];
    };
    //return
    searchView.searchViewReturnClickedBlock = ^(NSInteger keyWordsCateforyId, NSString *keyWords) {
        [weakSearchViewSelf removeFromSuperview];
        
        SearchResultCollectionViewController *searchResultCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"SearchResultCollectionViewController"];
        searchResultCon.keyWords = keyWords;
        searchResultCon.searchWords = keyWords;
        searchResultCon.keyWordsCategoryId = keyWordsCateforyId;
        [self.navigationController pushViewController:searchResultCon animated:YES];
    };
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (ARRAY_IS_NIL(_followArray)) {
        return 0;
    }
    return _followArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchResultModel *followModel = _followArray[indexPath.item];
    PublicZeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusablePublicZeroCellIdentifier forIndexPath:indexPath];
    
    cell.slipView.isPan = YES;
    [cell cellWithModel:followModel];
    cell.slipView.button2.selected = YES;
    cell.slipView.PublicDelegate = self;
    if ([self.cellsCurrentlyEditing containsObject:indexPath]) {
        [cell.slipView openCell];
    }
    
    return cell;
}

#pragma mark  <PublicZeroCollectionViewCellDelegate>
- (void)cellDidOpen:(UICollectionViewCell *)cell {
    NSIndexPath *lastIndexPath = nil;
    lastIndexPath = [self.cellsCurrentlyEditing anyObject];
    PublicZeroCollectionViewCell *myCell = (PublicZeroCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:lastIndexPath];
    if (self.cellsCurrentlyEditing.count != 0) {
        [self.cellsCurrentlyEditing removeObject:lastIndexPath];
        [myCell.slipView closeCell];
    }
    NSIndexPath *currentEditingIndexPath = [self.collectionView indexPathForCell:cell];
    [self.cellsCurrentlyEditing addObject:currentEditingIndexPath];
}

- (void)cellDidClose:(UICollectionViewCell *)cell {
    [self.cellsCurrentlyEditing removeObject:[self.collectionView indexPathForCell:cell]];
}

- (void)addShopping:(UICollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    SearchResultModel *followModel = _followArray[indexPath.item];
    [self inventoryProductWithSku:followModel.sku num:1 success:^{
        [[NetworkService sharedInstance] postShoppingCartPageAddCartWithSku:followModel.sku
                                                                     Amount:1 Success:^(NSInteger responseObject) {
                                                                         NSLog(@"addCartSuccess");
                                                                         
                                                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"cartAmount" object:nil];
                                                                         [SVProgressHUD showSuccessWithStatus:@"购物车添加成功"];
                                                                     } Failure:^(NSError *error) {
                                                                         [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                                     }];
    } Failure:^{
        
    }];
}
- (void)addFavorite:(UICollectionViewCell *)cell isFavorite:(BOOL)IsFavorite{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    SearchResultModel *followModel = _followArray[indexPath.item];
    NSLog(@"移除关注");
    [[NetworkService sharedInstance] favouriteDelete:followModel.id
                                             Success:^{
                                                 [SVProgressHUD showSuccessWithStatus:@"取消关注"];
                                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"removeCache" object:nil];
                                                 [_followArray removeObjectAtIndex:indexPath.item];
                                                 [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
                                             } Failure:^(NSError *error) {
                                                 [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                             }];
    
    
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, PublicZeroCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchResultModel *followModel = _followArray[indexPath.item];
    ProductDetailPageViewController *productDetailCon = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageViewController"];
    productDetailCon.productDetailId = followModel.sku;
    [self.navigationController pushViewController:productDetailCon animated:YES];
}

@end

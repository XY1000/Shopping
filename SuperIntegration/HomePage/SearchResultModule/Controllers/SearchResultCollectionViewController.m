//
//  SearchResultCollectionViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "SearchResultCollectionViewController.h"
//cells
#import "PublicZeroCollectionViewCell.h"
#import "PublicOneCollectionViewCell.h"
//model
#import "SearchResultModel.h"
//searchView
#import "SearchView.h"
//headerView
#import "SearchResultHeaderReusableView.h"
//controller
#import "SearchSelectedTableViewController.h"
#import "ProductDetailPageViewController.h"
#import "LeftSlipEditView.h"

@interface SearchResultCollectionViewController ()<UICollectionViewDelegateFlowLayout,LeftSlipEditViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
/**
 *  筛选视图
 */
@property (nonatomic, strong) UIWindow *window;
/**
 *  蒙版view
 */
@property (strong, nonatomic) UIView *maskView;

@property (strong, nonatomic) NSMutableArray *searchResultList;

/**
 *  它将存储当前已被打开的 Cell 的列表
 */
@property (nonatomic, strong) NSMutableSet *cellsCurrentlyEditing;
@end

@implementation SearchResultCollectionViewController
{
    NSInteger   _page;
    NSInteger   _rows;
    NSString   *_sort;
    NSString   *_order;
    NSMutableArray *_tmpArray;
    //关注列表
    NSArray    *_array_FavoriteSku;
    BOOL        _isRemake;
}

#pragma mark 注册需要的Identifier
static NSString * const reusablePublicZeroCellIdentifier        = @"PublicZeroCollectionViewCell";
static NSString * const reusablePublicOneCellIdentifier         = @"PublicOneCollectionViewCell";
static NSString * const reusableHeaderViewsIdentifier         = @"SearchResultHeaderReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    self.searchResultList = [NSMutableArray array];
    _tmpArray = [NSMutableArray arrayWithCapacity:16];
    _page = 1;
    _rows = 16;
    self.cellsCurrentlyEditing = [NSMutableSet new];
#pragma mark 添加上拉下拉刷新
    //添加下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self.collectionView.mj_footer resetNoMoreData];
        [self.collectionView.mj_header beginRefreshing];
        [self getListWithRows:_rows Page:_page Sort:_sort Order:_order];
    }];
    //添加上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page += 1;
        [self.collectionView.mj_footer beginRefreshing];
        [self getListWithRows:_rows Page:_page Sort:_sort Order:_order];
    }];
    self.collectionView.mj_footer.automaticallyHidden = YES;
#pragma mark    searchButton
    [self.searchButton setFrame:CGRectMake(SearchResultButtonToLeftValue, SearchResultButtonToTopValue, SearchResultButtonWidth, 30)];
    self.searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, SearchResultButtonImageInsets, 0, 0);
    //    self.searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, -SearchResultButtonTitleInsets, 0, 0);
    [self.searchButton setTitle:self.searchWords forState:UIControlStateNormal];
    self.searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
#pragma mark 注册cell
    
    [self.collectionView registerClass:[PublicZeroCollectionViewCell class] forCellWithReuseIdentifier:reusablePublicZeroCellIdentifier];
    [self.collectionView registerClass:[PublicOneCollectionViewCell class] forCellWithReuseIdentifier:reusablePublicOneCellIdentifier];
    
#pragma mark 注册section的headerView
    // Register header classes
    [self.collectionView registerNib:[UINib nibWithNibName:reusableHeaderViewsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableHeaderViewsIdentifier];
    // Do any additional setup after loading the view.
    
    [self getListWithRows:_rows Page:_page Sort:@"" Order:@""];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CustomFavoriteShared *favoriteShared = [CustomFavoriteShared customFavoriteShared];
    [favoriteShared getUrlCacheSuccess:^(NSArray *array_SkuCache) {
        NSLog(@"%@", array_SkuCache);
        _array_FavoriteSku = array_SkuCache;
        [self.collectionView reloadData];
    }];
}

//搜索
- (void)getListWithRows:(NSInteger)rows Page:(NSInteger)page Sort:(NSString *)sort Order:(NSString *)order {
    [[NetworkService sharedInstance] getSearchResultWithKeyWords:self.keyWords
                                                            Rows:rows
                                                            Page:page
                                                      CategoryId:self.keyWordsCategoryId
                                                            Sort:sort
                                                           Order:order
                                                         Success:^(NSArray *responseObject) {
                                                             if (_page == 1) {
                                                                 [self.searchResultList removeAllObjects];
                                                                 self.searchResultList = (NSMutableArray *)responseObject;
                                                                 if (ARRAY_IS_NIL(self.searchResultList)) {
                                                                     [SVProgressHUD showErrorWithStatus:@"暂无搜索结果"];
                                                                 }
                                                             } else {
                                                                 [self.searchResultList addObjectsFromArray:responseObject];
                                                                 if (ARRAY_IS_NIL(responseObject)) {
                                                                     [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                                                                 }
                                                             }
                                                             [_tmpArray removeAllObjects];
                                                             for (SearchResultModel *model in responseObject) {
                                                                 [_tmpArray addObject:model.sku];
                                                             }
                                                             if (!ARRAY_IS_NIL(responseObject)) {
                                                                 [self getPriceWithskuList:_tmpArray CityId:@"010"];
                                                             }
                                                             
                                                         } Failure:^(NSError *error) {
                                                             [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                                         }];
}
//价格列表
- (void)getPriceWithskuList:(NSArray *)skuList CityId:(NSString *)cityId {
    NSLog(@"%@", skuList);
    [[NetworkService sharedInstance] postSearchResultPriceListWithSkuList:skuList CityId:cityId Success:^(NSArray *responseObject) {
        NSLog(@"%@",responseObject);
        for (int i = 0; i < responseObject.count; i++) {
            NSDictionary *dic = responseObject[i];
            for (SearchResultModel *model in self.searchResultList) {
                if ([dic[@"sku"] isEqualToString:model.sku]) {
                    model.amount = dic[@"amount"];
                    continue ;
                }
            }
        }
        
//        if (_page == 1) {
//            [self.collectionView reloadData];
//        } else {
//            NSMutableArray *mArray_IndexPath = [NSMutableArray arrayWithCapacity:_rows];
//            for (NSInteger i = _rows * (_page - 1); i < _rows * _page; i++) {
//                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForItem:i inSection:0];
//                [mArray_IndexPath addObject:tmpIndexPath];
//            }
//            [self.collectionView insertItemsAtIndexPaths:mArray_IndexPath];
//        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
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
#pragma mark Method
//改变cell
- (IBAction)rightClicked:(id)sender {
    [self closeCell];
    if (self.rightButton.selected) {
        [self.rightButton setSelected:NO];
    } else {
        [self.rightButton setSelected:YES];
    }
    _isRemake = YES;
    [self.collectionView reloadData];
    
}
//创建搜索视图
- (IBAction)searchClicked:(id)sender {
    SearchView *searchView = [[[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:nil options:nil] firstObject];
    searchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    searchView.textField.text = self.searchWords;
    [WINDOW addSubview:searchView];
    
    __weak SearchView *weakSearchViewSelf = searchView;
    //取消
    searchView.searchViewCancelClickedBlock = ^() {
        [weakSearchViewSelf removeFromSuperview];
    };
    //return
    searchView.searchViewReturnClickedBlock = ^(NSInteger keyWordsCateforyId, NSString *keyWords) {
        [weakSearchViewSelf removeFromSuperview];
        _keyWords = keyWords;
        _keyWordsCategoryId = keyWordsCateforyId;
        [self getListWithRows:16 Page:1 Sort:@"" Order:@""];
    };
}
//删除筛选视图
- (void)tapAction {
    [self subWindowViewRemoveFromSuperView];
}
//点击确定按钮执行
- (void)determineClicked:(NSNotification *)notification {
    [self subWindowViewRemoveFromSuperView];
}
//删除子window视图
- (void)subWindowViewRemoveFromSuperView {
    [Utility yanshiWithSeconds:0.2 method:^{
        [self.window resignKeyWindow];
        self.window = nil;
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }];
    
    for (UIView *subView in self.window.subviews) {
        [Utility popAnnimationWithView:subView];
        [subView removeFromSuperview];
    }
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchResultList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchResultModel *searchResultModel = self.searchResultList[indexPath.item];
    if (self.rightButton.selected) {
        PublicOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusablePublicOneCellIdentifier forIndexPath:indexPath];
        
        cell.slipView.isPan = YES;
        [cell cellWithModel:searchResultModel];
        cell.slipView.button2.selected = NO;
        for (NSString *sku in _array_FavoriteSku) {
            if ([searchResultModel.sku isEqualToString:sku]) {
                cell.slipView.button2.selected = YES;
                break ;
            }
        }
        
        cell.slipView.PublicDelegate = self;
        
        return cell;
    } else {
        PublicZeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusablePublicZeroCellIdentifier forIndexPath:indexPath];
        
        cell.slipView.isPan = YES;
        [cell cellWithModel:searchResultModel];
        cell.slipView.button2.selected = NO;
        for (NSString *sku in _array_FavoriteSku) {
            if ([searchResultModel.sku isEqualToString:sku]) {
                cell.slipView.button2.selected = YES;
                break ;
            }
        }
        
        cell.slipView.PublicDelegate = self;
        
        return cell;
    }
}

#pragma mark  <PublicZeroCollectionViewCellDelegate>
- (void)cellDidOpen:(UICollectionViewCell *)cell {
    [self closeCell];
    NSIndexPath *currentEditingIndexPath = [self.collectionView indexPathForCell:cell];
    [self.cellsCurrentlyEditing addObject:currentEditingIndexPath];
}

- (void)closeCell {
    NSIndexPath *lastIndexPath = nil;
    lastIndexPath = [self.cellsCurrentlyEditing anyObject];
    PublicZeroCollectionViewCell *myCell = (PublicZeroCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:lastIndexPath];
    if (self.cellsCurrentlyEditing.count != 0) {
        [self.cellsCurrentlyEditing removeObject:lastIndexPath];
        [myCell.slipView closeCell];
    }
}

- (void)cellDidClose:(UICollectionViewCell *)cell {
    [self.cellsCurrentlyEditing removeObject:[self.collectionView indexPathForCell:cell]];
}

- (void)addShopping:(UICollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    SearchResultModel *searchResultModel = self.searchResultList[indexPath.item];
    [self inventoryProductWithSku:searchResultModel.sku num:1 success:^{
        [[NetworkService sharedInstance] postShoppingCartPageAddCartWithSku:searchResultModel.sku
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
    SearchResultModel *searchResultModel = self.searchResultList[indexPath.item];
    if (self.rightButton.selected) {
        PublicOneCollectionViewCell *myCell = (PublicOneCollectionViewCell *)cell;
        if (IsFavorite) {
            NSLog(@"移除关注");
        } else {
            NSLog(@"移入关注");
            [[NetworkService sharedInstance] favouriteCreate:searchResultModel.sku
                                                     Success:^{
                                                         [SVProgressHUD showSuccessWithStatus:@"关注成功"];
                                                         myCell.slipView.button2.selected = YES;
                                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"removeCache" object:nil];
                                                     } Failure:^(NSError *error) {
                                                         [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                     }];
        }
    } else {
        PublicZeroCollectionViewCell *myCell = (PublicZeroCollectionViewCell *)cell;
        if (IsFavorite) {
            NSLog(@"移除关注");
        } else {
            NSLog(@"移入关注");
            [[NetworkService sharedInstance] favouriteCreate:searchResultModel.sku
                                                     Success:^{
                                                         [SVProgressHUD showSuccessWithStatus:@"关注成功"];
                                                         myCell.slipView.button2.selected = YES;
                                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"removeCache" object:nil];
                                                     } Failure:^(NSError *error) {
                                                         [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                     }];
        }
    }
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SearchResultHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableHeaderViewsIdentifier forIndexPath:indexPath];
    /**
     *  排序
     */
    headerView.block_PriceCompare = ^(NSString *sort, NSString *order) {
        
        _page = 1;
        _sort = sort;
        _order = order;
        [self getListWithRows:_rows Page:_page Sort:sort Order:order];
    };
    //筛选
    headerView.shaixuanClickedBlock = ^() {
        
        //注册 确定点击 通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(determineClicked:) name:@"determineClicked" object:nil];
        
        /**
         蒙版
         */
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self.maskView addGestureRecognizer:tap];
        [WINDOW addSubview:self.maskView];
        
        /**
         次级window
         */
        self.window = [[UIWindow alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH - 60, SCREEN_HEIGHT)];
        self.window.backgroundColor = [UIColor clearColor];
        self.window.windowLevel = UIWindowLevelNormal;
        //        self.window.hidden = NO;
        [self.window makeKeyAndVisible];
        
        SearchSelectedTableViewController *selectecCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"SearchSelectedTableViewController"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:selectecCon];
        // 设置标题颜色
        NSMutableDictionary *titleAttrs = [NSMutableDictionary dictionary];
        titleAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
        titleAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17.0];
        [[UINavigationBar appearance] setTitleTextAttributes:titleAttrs];
        // 设置item样式
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15.0];
        [ [UIBarButtonItem appearance] setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        self.window.rootViewController = nav;
        
        /**
         *  取消
         */
        selectecCon.cancelClickedBlock = ^() {
            [self subWindowViewRemoveFromSuperView];
        };
        
    };
    return headerView;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (self.rightButton.selected) {
        return UIEdgeInsetsMake(PublicOneCellToLeftValue, PublicOneCellToLeftValue, 0, PublicOneCellToLeftValue);
    } else {
        return UIEdgeInsetsMake(PublicOneCellToLeftValue, 0, 0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.rightButton.selected) {
        return CGSizeMake(PublicOneCellWidth, PublicOneCellHeight);
    } else {
        return CGSizeMake(SCREEN_WIDTH, PublicZeroCellHeight);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.rightButton.selected) {
        return PublicOneCellToLeftValue;
    } else {
        return 1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, SearchResultHeaderViewHeight);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SearchResultModel *searchResultModel = self.searchResultList[indexPath.item];
    ProductDetailPageViewController *productDetailCon = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageViewController"];
    productDetailCon.productDetailId = searchResultModel.sku;
    [self.navigationController pushViewController:productDetailCon animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isChanged" object:nil userInfo:@{@"isChanged":[NSNumber numberWithBool:NO]}];
    [self closeCell];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isChanged" object:nil userInfo:@{@"isChanged":[NSNumber numberWithBool:YES]}];
}

@end

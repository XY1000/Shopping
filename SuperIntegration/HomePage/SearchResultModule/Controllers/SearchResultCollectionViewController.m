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
#import "ProductDetailPageCollectionViewController.h"

@interface SearchResultCollectionViewController ()<UICollectionViewDelegateFlowLayout>

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
@end

@implementation SearchResultCollectionViewController

#pragma mark 注册需要的Identifier
static NSString * const reusablePublicZeroCellIdentifier        = @"PublicZeroCollectionViewCell";
static NSString * const reusablePublicOneCellIdentifier         = @"PublicOneCollectionViewCell";
static NSString * const reusableHeaderViewsIdentifier         = @"SearchResultHeaderReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
#pragma mark    searchButton
    [self.searchButton setFrame:CGRectMake(SearchResultButtonToLeftValue, SearchResultButtonToTopValue, SearchResultButtonWidth, 30)];
    self.searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, SearchResultButtonImageInsets, 0, 0);
    self.searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, -SearchResultButtonTitleInsets, 0, 0);
    
#pragma mark 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"PublicZeroCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reusablePublicZeroCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PublicOneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reusablePublicOneCellIdentifier];
    
#pragma mark 注册section的headerView
    // Register header classes
    [self.collectionView registerNib:[UINib nibWithNibName:reusableHeaderViewsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableHeaderViewsIdentifier];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Method
//改变cell
- (IBAction)rightClicked:(id)sender {
    if (self.rightButton.selected) {
        [self.rightButton setSelected:NO];
    } else {
        [self.rightButton setSelected:YES];
    }
    [self.collectionView reloadData];
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
    searchView.searchViewReturnClickedBlock = ^(NSArray *searchResultList) {
        [weakSearchViewSelf removeFromSuperview];
        
        self.searchResultList = searchResultList;
        [self.collectionView reloadData];
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
    [Utility yanshiWithSeconds:0.1 method:^{
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
        [cell cellWithModel:searchResultModel];
        return cell;
    } else {
        PublicZeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusablePublicZeroCellIdentifier forIndexPath:indexPath];
        [cell cellWithModel:searchResultModel];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SearchResultHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableHeaderViewsIdentifier forIndexPath:indexPath];
    headerView.searchResultModelArray = self.searchResultList;
    /**
     *  排序
     */
    headerView.block_PriceCompare = ^(NSArray *compareArray) {
        self.searchResultList = compareArray;
        [self.collectionView reloadData];
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
        self.window.hidden = NO;
        [self.window makeKeyAndVisible];
        
        SearchSelectedTableViewController *selectecCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"SearchSelectedTableViewController"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:selectecCon];
        // 设置标题颜色
        NSMutableDictionary *titleAttrs = [NSMutableDictionary dictionary];
        titleAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
        titleAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20.0];
        [[UINavigationBar appearance] setTitleTextAttributes:titleAttrs];
        // 设置item样式
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17.0];
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
    ProductDetailPageCollectionViewController *productDetailCon = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageCollectionViewController"];
    productDetailCon.productDetailId = searchResultModel.sku;
    [self.navigationController pushViewController:productDetailCon animated:YES];
}



@end

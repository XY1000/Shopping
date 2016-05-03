//
//  ProductDetailPageCollectionViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/5.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ProductDetailPageCollectionViewController.h"
//views
#import "ProductDetailPageHeaderCollectionReusableView.h"
#import "HeaderCollectionReusableView.h"
#import "ProductDetailPageBottomView.h"
//models
#import "ProductDetailPageModel.h"
#import "ShoppingCartPageModel.h"
//cells
#import "ProductDetailPageOneCollectionViewCell.h"
#import "ProductDetailPageTwoCollectionViewCell.h"
#import "ProductDetailPageThreeCollectionViewCell.h"
//controllers
#import "ProductDetailPageWithAddressTableViewController.h"
#import "BaseNavViewController.h"
#import "BaseTabbarViewController.h"
#import "OrderFillInTableViewController.h"
#import "JSDropmenuView.h"
@interface ProductDetailPageCollectionViewController ()<UICollectionViewDelegateFlowLayout, JSDropmenuViewDelegate,UIWebViewDelegate>
{
    //主图地址
    NSString            *_imagePath;
    //图片地址数组
    NSMutableArray      *_imageMArray;
    //产品价格
    NSString            *_productPrice;
    //图文详情高度
    __block CGFloat     _productDetailPageContentHeight;
    
    LoadDataView        *_loadView;
    
}
//回到顶部按钮
@property (strong, nonatomic) UIButton *toTopButton;
@property (strong, nonatomic) ProductDetailPageModel *productDetailPageModel;
@property (weak, nonatomic) ProductDetailPageBottomView *bottomView;
@property(nonatomic,strong) NSArray *menuArray;
@property (strong, nonatomic) JSDropmenuView *dropmenuView;

/**
 *  筛选视图
 */
@property (nonatomic, strong) UIWindow *window;
/**
 *  蒙版view
 */
@property (strong, nonatomic) UIView *maskView;
@end

@implementation ProductDetailPageCollectionViewController
#pragma mark 注册需要的Identifier
//headerViewIdentifier
static NSString * const reusableSectionZeroHeaderViewsIdentifier        = @"ProductDetailPageHeaderCollectionReusableView";
static NSString * const reusableSectionOneHeaderViewsIdentifier         = @"HeaderCollectionReusableView";
//cellIdentifier
static NSString * const reusableOneCellIdentifier                       = @"ProductDetailPageOneCollectionViewCell";
static NSString * const reusableTwoCellIdentifier                       = @"ProductDetailPageTwoCollectionViewCell";
static NSString * const reusableThreeCellIdentifier                     = @"ProductDetailPageThreeCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20)];

    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:reusableSectionZeroHeaderViewsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableSectionZeroHeaderViewsIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:reusableSectionOneHeaderViewsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableSectionOneHeaderViewsIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
#pragma mark loadView
    
//    _loadView = [[[NSBundle mainBundle] loadNibNamed:@"LoadDataView" owner:nil options:nil] lastObject];
//    [_loadView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [WINDOW addSubview:_loadView];
//    
//    __weak ProductDetailPageCollectionViewController *weakSelf = self;
//    _loadView.block_LoadDataView_Refresh = ^() {
//        [weakSelf loadData];
//    };
    
//    [SVProgressHUD showWithStatus:@"加载中..."];
    [JFLoadingView JF_Loading];
#pragma mark  bottomView
    [self createBottomView];
    
//    self.productDetailId = @"";
    
#pragma mark 请求数据
    [self loadData];
    // Do any additional setup after loading the view.
    
#pragma mark rightItem
     self.menuArray = @[@{@"imageName":@"", @"title":@"首页"},@{@"imageName":@"", @"title":@"分享"}];
    
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
    [menuBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [menuBtn setImage:[UIImage imageNamed:@"组-3"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuTap:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    self.navigationItem.rightBarButtonItem = menuBarButtonItem;
    [self.navigationItem setCustomRightBarButtonItem:menuBarButtonItem ToRightValue:-12];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(selfBack)];
#pragma mark 添加回顶部按钮
    //创建回顶部按钮
    self.toTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.toTopButton.backgroundColor = RGB(204, 10, 42);
    self.toTopButton.alpha = 0.5;
    [self.toTopButton setFrame:CGRectMake(SCREEN_WIDTH - 70, SCREEN_HEIGHT - 49 - 60, 50, 50)];
    //    [self.toTopButton setTitle:@"回顶" forState:UIControlStateNormal];
    [self.toTopButton setImage:[UIImage imageNamed:@"首页_28"] forState:UIControlStateNormal];
    self.toTopButton.layer.masksToBounds = YES;
    self.toTopButton.layer.cornerRadius = 25;
    [self.toTopButton addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)selfBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData {
    [self getProductImages];
    
}

//返回顶部Method
- (void)toTop {
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)menuTap:(id)sender {
    self.dropmenuView = [[JSDropmenuView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH- 38*Screen320Scale*2 - 12, 64-12, 38*Screen320Scale*2, 38*Screen320Scale * 2)];
    self.dropmenuView.delegate = self;
    [self.dropmenuView showViewInView:self.navigationController.view];
}

#pragma mark - JSDropmenuViewDelegate

- (NSArray *)dropmenuDataSource {
    return self.menuArray;
}

- (void)dropmenuView:(JSDropmenuView *)dropmenuView didSelectedRow:(NSInteger)index {
    
    if(index>=self.menuArray.count){
        return;
    }
    
    if (index == 0) {
        NSLog(@"首页");
        BaseTabbarViewController *tabCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"BaseTabbarViewController"];
        WINDOW.rootViewController = tabCon;
    } else {
        NSLog(@"分享");
        [SVProgressHUD showErrorWithStatus:@"该功能暂未实现!"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //忽视视图View因为导航栏自动下移64像素
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.superview.backgroundColor = RGB(241, 72, 108);
#pragma mark navigaiotnBarView
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar lt_reset];
    [self.dropmenuView removeFromSuperview];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark 创建底部视图
- (void)createBottomView {
    _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailPageBottomView" owner:nil options:nil] lastObject];
    [_bottomView setFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    [self.view addSubview:_bottomView];
    
    __block ProductDetailPageBottomView *weakBottomView = _bottomView;
    /**
     *  购物车按钮
     */
    _bottomView.shoppingCartClickedBlock = ^() {
        [self judgeIsLoginYes:^{
            BaseTabbarViewController * baseTabbarViewController = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"BaseTabbarViewController"];
            baseTabbarViewController.selectedIndex = 3;
            WINDOW.rootViewController = baseTabbarViewController;
        }];
    };
    /**
     *  关注按钮
     */
    _bottomView.favoriteClickedBlock = ^() {
        [[NetworkService sharedInstance] favouriteCreate:self.productDetailPageModel.sku
                                                 Success:^{
                                                     [SVProgressHUD showSuccessWithStatus:@"关注成功"];
                                                 } Failure:^(NSError *error) {
                                                     [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                 }];
        //        if (_bottomView.favouriteButton.selected == NO) {
        //
        //
        //        } else {
        //            [[NetworkService sharedInstance] favouriteDelete:self.productDetailPageModel.sku Success:^{
        //                [SVProgressHUD showSuccessWithStatus:@"取消关注"];
        //                _bottomView.favouriteButton.selected = NO;
        //            } Failure:^(NSError *error) {
        //                [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
        //            }];
        //        }
//        [SVProgressHUD showErrorWithStatus:@"该功能暂未实现!"];
    };
    /**
     *  客服按钮
     */
    _bottomView.customServiceClickedBlock = ^() {
        [self judgeIsLoginYes:^{
            NSLog(@"拨打客服");
            NSString *number = @"18810552158";// 此处读入电话号码
            
            // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
            
            
            NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
        }];
    };
    /**
     *  立即购买按钮
     */
    _bottomView.goBuyClickedBlock = ^() {
        [self judgeIsLoginYes:^{
            [self inventoryProductWithSku:self.productDetailPageModel.sku num:1 success:^{
                if (!OBJ_IS_NULL(self.productDetailPageModel)) {
                    
                    NSDictionary *dic = @{@"sku" : self.productDetailPageModel.sku, @"name":self.productDetailPageModel.name, @"price":_productPrice, @"amount":@(1), @"image":self.productDetailPageModel.image};
                    ShoppingCartPageModel *model = [ShoppingCartPageModel modelWithDic:dic];
                    
                    OrderFillInTableViewController *orderCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"OrderFillInTableViewController"];
//                    orderCon.allPrice = [NSString stringWithFormat:@"%ld", (long)_productPrice];
                    orderCon.productsArray = (NSArray *)@[model];
                    
                    _bottomView.btn_GoBuy.userInteractionEnabled = YES;
                    
                    [self.navigationController pushViewController:orderCon animated:YES];
                }
            } Failure:^{
                _bottomView.btn_GoBuy.userInteractionEnabled = YES;
            }];
            
        }];
    };
    //添加购物车
    _bottomView.addShoppingCartClickedBlock = ^() {
        [self judgeIsLoginYes:^{
            [self inventoryProductWithSku:self.productDetailPageModel.sku num:1 success:^{
                [[NetworkService sharedInstance] postShoppingCartPageAddCartWithSku:self.productDetailPageModel.sku
                                                                             Amount:1 Success:^(NSInteger responseObject) {
                                                                                 NSLog(@"addCartSuccess");
                                                                                 weakBottomView.addShoppingCartButton.userInteractionEnabled = YES;
                                                                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"cartAmount" object:nil];
                                                                                 [SVProgressHUD showSuccessWithStatus:@"购物车添加成功"];
                                                                             } Failure:^(NSError *error) {
                                                                                 [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                                             }];
            } Failure:^{
                weakBottomView.addShoppingCartButton.userInteractionEnabled = YES;
            }];
        }];
    };
}
#pragma mark 请求数据
//产品图片
- (void)getProductImages {
    [[NetworkService sharedInstance] getProductDetailImagesWithProductSku:self.productDetailId
                                                                  Success:^(NSMutableArray *responseObject) {
                                                                      _imageMArray = [NSMutableArray arrayWithCapacity:responseObject.count];
                                                                      _imageMArray  = responseObject;
                                                                      
                                                                      [self getProductPrice];
                                                                      
                                                                  } Failure:^(NSError *error) {
                                                                      [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                                  }];
}
//产品价格
- (void)getProductPrice {
    [[NetworkService sharedInstance] getProductDetailPriceWithProductSku:self.productDetailId
                                                                 Success:^(NSString *responseObject) {
                                                                     _productPrice = responseObject;
//                                                                     [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
//
//                                                                     self.view.userInteractionEnabled = YES;
                                                                     [self getProductDetail];
                                                                 } Failure:^(NSError *error) {
                                                                     [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                                     self.view.userInteractionEnabled = NO;
                                                                     [JFLoadingView JF_LoadSuccess];
                                                                 }];
}
//产品详情
- (void)getProductDetail {
    [[NetworkService sharedInstance] getProductDetailWithProductSku:self.productDetailId
                                                            Success:^(NSMutableArray *responseObject) {
                                                                self.productDetailPageModel = responseObject[0];
                                                                _imagePath = self.productDetailPageModel.image;
                                                                
                                                                self.productDetailPageModel.introduction = [self filterHTML:self.productDetailPageModel.introduction];
                                                                
                                                                //获得高度
                                                                UIWebView *tmpWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
                                                                tmpWebView.hidden = YES;
                                                                tmpWebView.delegate = self;
                                                                tmpWebView.scrollView.scrollEnabled = NO;
                                                                NSString * htmlStyle = [NSString stringWithFormat:@" <style type=\"text/css\"> img{ width: %f; height: auto; display: block;} </style> ", SCREEN_WIDTH - 20];
                                                                NSString * htmlStr = self.productDetailPageModel.introduction;
                                                                htmlStr = [htmlStyle stringByAppendingString:htmlStr];
                                                                [tmpWebView loadHTMLString:htmlStr baseURL:nil];
                                                                [self.view addSubview:tmpWebView];
                                                                
                                                                
                                                            } Failure:^(NSError *error) {
                                                                [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                                self.view.userInteractionEnabled = NO;
                                                                [JFLoadingView JF_LoadSuccess];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _productDetailPageContentHeight = webView.scrollView.contentSize.height;
    
    [self.collectionView reloadData];
    [JFLoadingView JF_LoadSuccess];
    self.view.userInteractionEnabled = YES;
    
    webView.delegate = nil;
    [webView removeFromSuperview];
    webView = nil;
}

-(NSString *)filterHTML:(NSString *)html
{
    NSArray *array = [html componentsSeparatedByString:@"</object>"];

    if (array.count >= 2) {
        return array[1];
    }
    return array[0];
}

#pragma mark Method
//删除筛选视图
- (void)tapAction {
    [self subWindowViewRemoveFromSuperView];
}
//删除子window视图
- (void)subWindowViewRemoveFromSuperView {
    [Utility yanshiWithSeconds:0.5 method:^{
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
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            ProductDetailPageOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableOneCellIdentifier forIndexPath:indexPath];
            
            if (self.productDetailPageModel != nil) {
                [cell cellWithModel:self.productDetailPageModel andPrice:_productPrice];
            }
            
            return cell;
        } else {
            ProductDetailPageTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableTwoCellIdentifier forIndexPath:indexPath];
            
            if (self.productDetailPageModel != nil) {
                [cell cellWithModel:self.productDetailPageModel andIndexPath:indexPath];
            }
            
            return cell;
        }
    }
    if (indexPath.section == 1) {
        ProductDetailPageThreeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableThreeCellIdentifier forIndexPath:indexPath];
        
        if (self.productDetailPageModel != nil) {
            [cell cellWithModel:self.productDetailPageModel];
        }
        
//        cell.refreshBlock = ^(CGFloat contentHieght) {
//            _productDetailPageContentHeight = contentHieght;
//            [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:1]]];
//        };
        return cell;
    }
    return nil;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            ProductDetailPageHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableSectionZeroHeaderViewsIdentifier forIndexPath:indexPath];
            [headerView viewWithArray:_imageMArray];
            return headerView;
        }
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableSectionOneHeaderViewsIdentifier forIndexPath:indexPath];
        headerView.titleLabel.text = @"图文详情";
        return headerView;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *backView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        backView.backgroundColor = [UIColor greenColor];
        
        if (indexPath.section == 1) {
            if ((self.productDetailPageModel != nil) && (backView.subviews.count == 0)) {
                //获得高度
                UIWebView *tmpWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _productDetailPageContentHeight + 49)];
                tmpWebView.scrollView.scrollEnabled = NO;
                NSString * htmlStyle = [NSString stringWithFormat:@" <style type=\"text/css\"> img{ width: %f; height: auto; display: block;} </style> ", SCREEN_WIDTH - 20];
                NSString * htmlStr = self.productDetailPageModel.introduction;
                htmlStr = [htmlStyle stringByAppendingString:htmlStr];
                [tmpWebView loadHTMLString:htmlStr baseURL:nil];
                [backView addSubview:tmpWebView];
            }
        }
        
        return backView;
    }
    return nil;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            return CGSizeMake(SCREEN_WIDTH, ProductDetailPage_CellWithOneHeight);
        } else {
            return CGSizeMake(SCREEN_WIDTH, ProductDetailPage_CellWithTwoHeight);
        }
    }
    return CGSizeMake(SCREEN_WIDTH, 0.1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, ProductDetailPage_HeaderViewHeight);
    }
    return CGSizeMake(SCREEN_WIDTH, HeaderViewsHieght);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 49+49);
    }
    return CGSizeMake(SCREEN_WIDTH, _productDetailPageContentHeight + 49);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.item != 0) {
            
        }
        
        if (indexPath.item == 1) {
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
            
            ProductDetailPageTwoCollectionViewCell *cell = (ProductDetailPageTwoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            ProductDetailPageWithAddressTableViewController *addressCon = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageWithAddressTableViewController"];
            addressCon.addressString = cell.rightLabel.text;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addressCon];
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
            
            addressCon.backSelectAddressBlock = ^(NSArray *addressArray) {
                NSLog(@"%@", addressArray);
                [self subWindowViewRemoveFromSuperView];
                NSMutableString *mStr = [NSMutableString string];
                for (NSString *str in addressArray) {
                    [mStr appendString:[NSString stringWithFormat:@"%@ ", str]];
                }
                cell.rightLabel.text = mStr;
            };
        }
    }
}
#pragma mark 根据滑动的距离修改导航栏的透明度 和 回顶部按钮的出现/消失
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat TheControllercontentOffsetY = scrollView.contentOffset.y;
//    NSLog(@"%f", TheControllercontentOffsetY + ProductDetailPage_CellWithOneHeight + 2*ProductDetailPage_CellWithTwoHeight + 10);
    //导航栏透明度
    if ((TheControllercontentOffsetY >= 0) && (TheControllercontentOffsetY <= ProductDetailPage_HeaderViewHeight * 2)) {
        UIImage *image = [Utility buttonImageFromColor:RGB(204, 10, 42)];
        UIImage *newImage = [Utility imageByApplyingAlpha:TheControllercontentOffsetY / (ProductDetailPage_HeaderViewHeight * 4) image:image];
        [self.navigationController.navigationBar setBackgroundImage:newImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    //如果滑动的距离大于设备屏幕的一半就添加返回顶部按钮
    if (TheControllercontentOffsetY >= SCREEN_HEIGHT / 2) {
        if (self.toTopButton.superview == nil) {
            [self.toTopButton annimation_ScaleView:self.toTopButton duration:1.0 fromValue:0 toValue:1];
            [self.view addSubview:self.toTopButton];
        }
    }
    //如果滑动的距离小于设备屏幕的一半就删除返回顶部按钮
    if (TheControllercontentOffsetY < SCREEN_HEIGHT / 2) {
        if (self.toTopButton.superview != nil) {
            [self.toTopButton removeFromSuperview];
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

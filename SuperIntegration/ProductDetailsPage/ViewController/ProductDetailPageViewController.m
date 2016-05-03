//
//  ProductDetailPageViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/4/8.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#define BottomH 52

#import "ProductDetailPageViewController.h"
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
//新增产品参数
#import "ProductDeailPageTableViewCell.h"

@interface ProductDetailPageViewController ()<UIScrollViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, JSDropmenuViewDelegate,UIWebViewDelegate,UITableViewDataSource, UITableViewDelegate>
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
    
    BOOL                _isBackScroll;
    
//    NSArray             *_array_FavoriteSku;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *MyScrollView;
@property (weak, nonatomic) UIScrollView *webScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_ScrollHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_CollectionHeight;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_WebViewHeight;
@property (strong, nonatomic) UILabel *label_refresh;
/**
 *  新增产品参数
 */
@property (strong, nonatomic)  UIButton *btn_Detail;
@property (strong, nonatomic)  UIButton *btn_Paramter;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *paramter_KeyArray;
@property (strong, nonatomic) NSMutableArray *paramter_ValueMArray;
@property (assign, nonatomic) NSInteger tableView_SectionNum;
@property (assign, nonatomic) NSInteger tableView_RowNum;

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

@implementation ProductDetailPageViewController
#pragma mark 注册需要的Identifier
//headerViewIdentifier
static NSString * const reusableSectionZeroHeaderViewsIdentifier        = @"ProductDetailPageHeaderCollectionReusableView";
static NSString * const reusableSectionOneHeaderViewsIdentifier         = @"HeaderCollectionReusableView";
//cellIdentifier
static NSString * const reusableOneCellIdentifier                       = @"ProductDetailPageOneCollectionViewCell";
static NSString * const reusableTwoCellIdentifier                       = @"ProductDetailPageTwoCollectionViewCell";

static NSString * const reusableTableCellIdentifier                     = @"ProductDeailPageTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layout_ScrollHeight.constant = (SCREEN_HEIGHT - 20) * 2;
    self.layout_CollectionHeight.constant = SCREEN_HEIGHT - 20;
    self.layout_WebViewHeight.constant = SCREEN_HEIGHT - 20 - 44 - 49;
    
    
    self.MyScrollView.pagingEnabled = YES;//进行分页
    self.MyScrollView.scrollEnabled = YES;
    self.MyScrollView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.webView.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);//这里webView的frame时充满屏幕的
    self.webView.delegate = self;
    
    //获得webview的scrollview
    self.webScrollView = self.webView.scrollView;
    self.webScrollView.delegate = self;
    
    self.label_refresh = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 40)];
    self.label_refresh.text = @"下拉返回商品介绍";
    self.label_refresh.textColor = [UIColor lightGrayColor];
    self.label_refresh.font = [UIFont systemFontOfSize:12.0];
    self.label_refresh.textAlignment = NSTextAlignmentCenter;
    
//    [self.webView insertSubview:label_refresh belowSubview:self.webScrollView];
    
#pragma mark 新增产品参数
    self.btn_Detail = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_Detail setFrame:CGRectMake(SCREEN_WIDTH / 2 - 80, 5, 60, 30)];
    self.btn_Detail.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
    [self.btn_Detail setTitle:@"图文详情" forState:UIControlStateNormal];
    [self.btn_Detail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn_Detail setTitleColor:RGB(204, 10, 42) forState:UIControlStateSelected];
    [self.btn_Detail addTarget:self action:@selector(btn_DetailClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_Paramter = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_Paramter setFrame:CGRectMake(CGRectGetMaxX(self.btn_Detail.frame) + 40, 5, 60, 30)];
    self.btn_Paramter.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
    [self.btn_Paramter setTitle:@"产品参数" forState:UIControlStateNormal];
    [self.btn_Paramter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn_Paramter setTitleColor:RGB(204, 10, 42) forState:UIControlStateSelected];
    [self.btn_Paramter addTarget:self action:@selector(btn_ParamterClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn_Detail setSelected:YES];
    [self.btn_Paramter setSelected:NO];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.layout_WebViewHeight.constant) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGB(245, 246, 247);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0);
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:reusableSectionZeroHeaderViewsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableSectionZeroHeaderViewsIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:reusableSectionOneHeaderViewsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableSectionOneHeaderViewsIdentifier];

    [self.tableView registerNib:[UINib nibWithNibName:reusableTableCellIdentifier bundle:nil] forCellReuseIdentifier:reusableTableCellIdentifier];
#pragma mark loadView
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
    CustomFavoriteShared *favoriteShared = [CustomFavoriteShared customFavoriteShared];
    [favoriteShared getUrlCacheSuccess:^(NSArray *array_SkuCache) {
        NSLog(@"%@", array_SkuCache);
        //        _array_FavoriteSku = array_SkuCache;
        for (NSString *sku in array_SkuCache) {
            if ([self.productDetailId isEqualToString:sku]) {
                [_bottomView.favouriteButton setSelected:YES];
                return;
            }
        }
    }];
}

//返回顶部Method
- (void)toTop {
    [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
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
    self.MyScrollView.superview.backgroundColor = RGB(241, 72, 108);
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
    
    
    [self.btn_Detail removeFromSuperview];
    [self.btn_Paramter removeFromSuperview];
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
        [self judgeIsLoginYes:^{
            if (_bottomView.favouriteButton.selected == NO) {
                [[NetworkService sharedInstance] favouriteCreate:self.productDetailPageModel.sku
                                                         Success:^{
                                                             [SVProgressHUD showSuccessWithStatus:@"关注成功"];
                                                             _bottomView.favouriteButton.selected = YES;
                                                             [[NSNotificationCenter defaultCenter] postNotificationName:@"removeCache" object:nil];
                                                         } Failure:^(NSError *error) {
                                                             [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                         }];
                
            } else {
                return ;
//                [[NetworkService sharedInstance] favouriteDelete:self.productDetailPageModel.sku
//                                                         Success:^{
//                                                             [SVProgressHUD showSuccessWithStatus:@"取消关注"];
//                                                             _bottomView.favouriteButton.selected = NO;
//                                                             [[NSNotificationCenter defaultCenter] postNotificationName:@"removeCache" object:nil];
//                                                         } Failure:^(NSError *error) {
//                                                             [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
//                                                         }];
            }
        }];
        
    };
    /**
     *  客服按钮
     */
    _bottomView.customServiceClickedBlock = ^() {
        NSLog(@"拨打客服");
        NSString *number = @"18810552158";// 此处读入电话号码
        
        // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
        
        
        NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
        
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
                                                                
                                                                NSString * htmlStyle = [NSString stringWithFormat:@" <style type=\"text/css\"> img{ width: %f !important; height: auto; display: block;} </style> ", SCREEN_WIDTH - 20];
                                                                NSString * htmlStr = self.productDetailPageModel.introduction;
                                                                htmlStr = [htmlStyle stringByAppendingString:htmlStr];
                                                                self.webView.delegate = self;
                                                                [self.webView loadHTMLString:htmlStr baseURL:nil];
                                                                
                                                                /**
                                                                 *  处理产品参数数据
                                                                 */
                                                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                                    
                                                                    if (!DICT_IS_NIL(self.productDetailPageModel.param)) {
                                                                        _paramter_KeyArray = [self.productDetailPageModel.param allKeys];
                                                                        _paramter_ValueMArray = [NSMutableArray arrayWithCapacity:self.paramter_KeyArray.count];
                                                                        for (NSString *paramter_KeyString in self.paramter_KeyArray) {
                                                                            NSArray *paramter_ValueArray = [self.productDetailPageModel.param valueForKey:paramter_KeyString];
                                                                            [_paramter_ValueMArray addObject:paramter_ValueArray];
                                                                        }
                                                                    }
                                                                    
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        
                                                                        [self.tableView reloadData];
                                                                    });
                                                                });
                                                                
                                                                [self.collectionView reloadData];
                                                                [JFLoadingView JF_LoadSuccess];
                                                                self.view.userInteractionEnabled = YES;
                                                                
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

-(NSString *)filterHTML:(NSString *)html
{
    NSArray *array = [html componentsSeparatedByString:@"</object>"];
    
    if (array.count >= 2) {
        return array[1];
    }
    return array[0];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //判断是否是单击
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        return NO;
    }
    return YES;
}

#pragma mark Method
//删除筛选视图
- (void)tapAction {
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
    return 3;
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
    return nil;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ProductDetailPageHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableSectionZeroHeaderViewsIdentifier forIndexPath:indexPath];
        [headerView viewWithArray:_imageMArray];
        return headerView;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *backView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewFooter" forIndexPath:indexPath];
//        backView.backgroundColor = [UIColor greenColor];
        
        
        return backView;
    }
    return nil;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        return CGSizeMake(SCREEN_WIDTH, ProductDetailPage_CellWithOneHeight);
    } else {
        return CGSizeMake(SCREEN_WIDTH, ProductDetailPage_CellWithTwoHeight);
    }
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
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 20 - ProductDetailPage_HeaderViewHeight - ProductDetailPage_CellWithOneHeight - 2*ProductDetailPage_CellWithTwoHeight);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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
#pragma mark 根据滑动的距离修改导航栏的透明度 和 回顶部按钮的出现/消失
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat TheControllercontentOffsetY = scrollView.contentOffset.y;
    if ([scrollView isEqual:self.MyScrollView]) {
        //    NSLog(@"%f", TheControllercontentOffsetY + ProductDetailPage_CellWithOneHeight + 2*ProductDetailPage_CellWithTwoHeight + 10);
        //导航栏透明度
        if ((TheControllercontentOffsetY >= 0) && (TheControllercontentOffsetY <= ProductDetailPage_HeaderViewHeight)) {
            UIImage *image = [Utility buttonImageFromColor:RGB(204, 10, 42)];
            UIImage *newImage = [Utility imageByApplyingAlpha:TheControllercontentOffsetY / (ProductDetailPage_HeaderViewHeight * 4) image:image];
            [self.navigationController.navigationBar setBackgroundImage:newImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        }
        
        if (TheControllercontentOffsetY > ProductDetailPage_HeaderViewHeight) {
            UIImage *image = [Utility buttonImageFromColor:RGB(204, 10, 42)];
            UIImage *newImage = [Utility imageByApplyingAlpha:0 / (ProductDetailPage_HeaderViewHeight * 4) image:image];
            [self.navigationController.navigationBar setBackgroundImage:newImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        }
        
        if (TheControllercontentOffsetY >= self.layout_CollectionHeight.constant) {
            [self.navigationController.navigationBar addSubview:self.btn_Detail];
            [self.navigationController.navigationBar addSubview:self.btn_Paramter];
            scrollView.scrollEnabled = NO;
        } else {
            [self.btn_Detail removeFromSuperview];
            [self.btn_Paramter removeFromSuperview];
            scrollView.scrollEnabled = YES;
        }
    }
    
    if (![scrollView isEqual:self.MyScrollView]) {
        
        if ([scrollView isEqual:self.webScrollView]) {
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
         *  禁止webView左右滑动
         */
        if (scrollView.contentOffset.x > 0) {
            scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);//这里不要设置为CGPointMake(0, point.y)，这样我们在文章下面左右滑动的时候，就跳到文章的起始位置，不科学
        }
        
        /**
         *  添加删除"下拉刷新label"
         */
        if (scrollView.contentOffset.y <= - 20) {
            if (self.label_refresh.superview == nil) {
                [self.label_refresh annimation_SpringView:self.label_refresh duration:0.5 fromValue:0 toValue:1.0];
                
                [self.view addSubview:self.label_refresh];
            }
        } else {
            if (self.label_refresh.superview != nil) {
                [self.label_refresh removeFromSuperview];
            }
        }
        
        /**
         *  回滚到顶部
         */
        if (scrollView.contentOffset.y == 0) {
            
            if (_isBackScroll) {
                [self.MyScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                _isBackScroll = NO;
            }
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (![scrollView isEqual:self.MyScrollView]) {
        if (scrollView.contentOffset.y < -60) {
            _isBackScroll = YES;
            [scrollView setContentOffset:CGPointMake(0, -50) animated:YES];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (![scrollView isEqual:self.MyScrollView]) {
        if (_isBackScroll) {
            [Utility yanshiWithSeconds:0.1 method:^{
                [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                
            }];
        }
    }
}

#pragma mark  新增产品参数
/**
 *  图文详情
 */
- (void)btn_DetailClicked:(id)sender {
    [self toTop];
    if (self.btn_Detail.selected) {
        return ;
    } else {
        [self.btn_Paramter setSelected:NO];
        [self.btn_Detail setSelected:YES];
    }
    [self.tableView removeFromSuperview];
}
/**
 *  产品参数
 */
- (void)btn_ParamterClicked:(id)sender {
    if (self.toTopButton.superview != nil) {
        [self.toTopButton removeFromSuperview];
    }
    if (self.btn_Paramter.selected) {
        return ;
    } else {
        [self.webView insertSubview:self.tableView aboveSubview:self.webScrollView];
        [self.btn_Detail setSelected:NO];
        [self.btn_Paramter setSelected:YES];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (ARRAY_IS_NIL(self.paramter_KeyArray)) {
        return 0;
    }
    return self.paramter_KeyArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *tmpArray = self.paramter_ValueMArray[section];
    return tmpArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDeailPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableTableCellIdentifier forIndexPath:indexPath];
    
    NSArray *tmpArray = self.paramter_ValueMArray[indexPath.section];
    NSDictionary *paramter_Dic = tmpArray[indexPath.row];
    cell.label_ParamterKey.text = [NSString stringWithFormat:@"%@:",paramter_Dic[@"snparameterdesc"]];
    cell.label_ParamterValue.text = paramter_Dic[@"snparameterVal"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *tmpArray = self.paramter_ValueMArray[indexPath.section];
    NSDictionary *paramter_Dic = tmpArray[indexPath.row];
    CGFloat cell_Height = [Utility contentHeightWithSize:12.0 width:175.0 string:paramter_Dic[@"snparameterVal"]];
    if (cell_Height + 20 < 40) {
        return 40;
    }
    return cell_Height + 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view_Footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 41)];
    view_Footer.backgroundColor = [UIColor whiteColor];
    
    UILabel *label_Key = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH, 20)];
    label_Key.textAlignment = NSTextAlignmentLeft;
    label_Key.text = self.paramter_KeyArray[section];
    label_Key.font = [UIFont boldSystemFontOfSize:15.0];
    [view_Footer addSubview:label_Key];
    
    return view_Footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
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

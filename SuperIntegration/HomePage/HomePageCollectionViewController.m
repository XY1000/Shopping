//
//  HomePageCollectionViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/11.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "HomePageCollectionViewController.h"
//customNavigationBarView
#import "CustomNavigationBarView.h"
//headerView
#import "BannerView.h"
#import "BannerWebImageManager.h"
#import "HeaderCollectionReusableView.h"
#import "GuessYouLikeCollectionReusableView.h"
//cells
#import "BannerViewCollectionViewCell.h"
#import "ClassificationCollectionViewCell.h"
#import "SpecialShoppingCollectionViewCell.h"
#import "SectionThreeCollectionViewCell.h"
#import "PublicOneCollectionViewCell.h"
//Models
#import "HomePageModel.h"
#import "GuessYouLikeModel.h"
//controllers
#import "SearchResultCollectionViewController.h"
#import "BaseNavViewController.h"
#import "IntegralRechargeViewController.h"
#import "OrderAllListCollectionViewController.h"
#import "FollowAllListCollectionViewController.h"
#import "FootPrintAllListCollectionViewController.h"
//searchView
#import "SearchView.h"
//#import "SuperIntegration-Swift.h"
#import "ProductDetailPageViewController.h"


@interface HomePageCollectionViewController ()<UICollectionViewDelegateFlowLayout>

//回到顶部按钮
@property (strong, nonatomic) UIButton *toTopButton;
//自定义导航视图
@property (strong, nonatomic) CustomNavigationBarView *navigationBarView;

//section数量
@property (assign, nonatomic) NSInteger sectionNum;
//特色馆数量
@property (assign, nonatomic) NSInteger specialNum;
//频道数量
@property (assign, nonatomic) NSInteger channelNum;


@end

@implementation HomePageCollectionViewController{
    //视图Y值
    CGFloat                 _TheControllercontentOffsetY;
    //是否已经给cell上的滚动视图赋值
    BOOL                    _isAlreadyAssignmentForCellBannerView;
    //轮播图片数组
    NSMutableArray          *_bannerViewImagesMArray;
    //轮播跳转类型
    NSMutableArray          *_bannerViewMArray;
    //Section0的图片和title
    NSArray                 *_sectionZeroTitleArray;
    NSArray                 *_sectionZeroImageArray;
    //特色馆数组
    NSArray                 *_specialMArray;
    //频道列表
    NSArray                 *_channelListArray;
    //可用的频道列表
    NSMutableArray          *_valiChannelListArray;
    //猜你喜欢列表
    NSArray                 *_guessYouLikeArray;
    //查询到的用户积分
    NSString                *_userIntegral;
}

#pragma mark 注册需要的Identifier
//headerViewIdentifier
static NSString * const reusableHeaderViewsIdentifier           = @"HeaderCollectionReusableView";
static NSString * const reusableGuessHeaderViewsIdentifier      = @"GuessYouLikeCollectionReusableView";
//cellIdentifier
static NSString * const reusableBannerViewIdentifier            = @"BannerViewCollectionViewCell";
static NSString * const reusableClassifyIdentifier              = @"ClassificationCollectionViewCell";
static NSString * const reusableSpecialShoppingIdentifier       = @"SpecialShoppingCollectionViewCell";
static NSString * const reusableSectionThreeIdentifier          = @"SectionThreeCollectionViewCell";
static NSString * const reusableSectionGuessIdentifier          = @"PublicOneCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.specialNum = 1;
    self.sectionNum = 7;
    _sectionZeroTitleArray = @[@"积分充值", @"我的关注", @"我的足迹", @"我的订单", @"分享有礼"];
    _sectionZeroImageArray = @[@"首页_11", @"首页_13", @"首页_15", @"首页_17", @"首页_20"];
    
    //忽视视图View因为导航栏自动下移64像素
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.collectionView setFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 44)];
#pragma mark 注册section的headerView
    // Register header classes
    [self.collectionView registerNib:[UINib nibWithNibName:reusableHeaderViewsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableHeaderViewsIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:reusableGuessHeaderViewsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableGuessHeaderViewsIdentifier];
    
    [self.collectionView registerClass:[PublicOneCollectionViewCell class] forCellWithReuseIdentifier:reusableSectionGuessIdentifier];
#pragma mark 添加上拉下拉刷新
    //添加下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.collectionView.mj_footer resetNoMoreData];
        [self.collectionView.mj_header beginRefreshing];
        [self getData];
        
    }];
    //添加上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.collectionView.mj_footer beginRefreshing];
        [self getGuessYouLikeList];
    }];
    self.collectionView.mj_footer.automaticallyHidden = YES;
#pragma mark 添加自定义的导航栏
    //add navigationBarView
    self.navigationBarView = [[[NSBundle mainBundle] loadNibNamed:@"CustomNavigationBarView" owner:self options:nil] lastObject];
    [self.navigationBarView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.view addSubview:self.navigationBarView];
    //点击搜索框
    __weak HomePageCollectionViewController *weakSelf = self;
    self.navigationBarView.searchClicked = ^() {
        SearchView *searchView = [[[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:nil options:nil] firstObject];
        searchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
        [weakSelf.view addSubview:searchView];
        
        __weak SearchView *weakSearchViewSelf = searchView;
        //取消
        searchView.searchViewCancelClickedBlock = ^() {
            [weakSearchViewSelf removeFromSuperview];
        };
        //return
        searchView.searchViewReturnClickedBlock = ^(NSInteger keyWordsCateforyId, NSString *keyWords) {
            [weakSearchViewSelf removeFromSuperview];
            
            SearchResultCollectionViewController *searchResultCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"SearchResultCollectionViewController"];
            searchResultCon.searchWords = keyWords;
            searchResultCon.keyWords = keyWords;
            searchResultCon.keyWordsCategoryId = keyWordsCateforyId;
            [weakSelf.navigationController pushViewController:searchResultCon animated:YES];
            
        };
    };
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
#pragma mark 请求数据
    [self getData];
    
//    [self login];
}

- (void)getData {
    [self getBannerViewImages];
    [self getGuessYouLikeList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
//    self.navigationController.navigationBar.hidden = YES;
    self.collectionView.superview.backgroundColor = RGB(241, 72, 108);
    //防止隐藏后返回时出现背景色
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning");
}

#pragma mark 加载数据
- (void)login {
    [[NetworkService sharedInstance] postUserLoginWithUsername:GetObjectUserDefault(@"username")
                                                      Password:GetObjectUserDefault(@"password")
                                                       Success:^{
                                                           DLog(@"loginSuccess");
                                                           
                                                       } Failure:^(NSError *error) {
                                                           [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                                       }];
}
/**
 *  请求轮播图
 */
- (void)getBannerViewImages {
    [[NetworkService sharedInstance] getHomePageBannerImagesSuccess:^(NSMutableArray *responseObject) {
        _bannerViewImagesMArray = [NSMutableArray arrayWithCapacity:responseObject.count];
        _bannerViewMArray = [NSMutableArray arrayWithCapacity:responseObject.count];
        [_bannerViewImagesMArray removeAllObjects];
        for (HomePageBannerViewImageModel *imageModel in responseObject) {
            [_bannerViewImagesMArray addObject:imageModel.appPicUrl];
            [_bannerViewMArray addObject:imageModel];
        }
        [self getSpecialList];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
/**
 *  特色馆热销列表
 */
- (void)getSpecialList {
    [[NetworkService sharedInstance] getHomePageSpecialHotListSuccess:^(NSMutableArray *responseObject) {
        _specialMArray = (NSArray *)responseObject;
        HomePageSpecialModel *specialModel = _specialMArray[0];
        NSArray *productList = specialModel.list;
        if (specialModel.appType != 3) {//显示类型是1,2的 图片少于4张隐藏
            if (productList.count < 5) {
                self.specialNum = 0;
            }
        }
        if (specialModel.appType == 3) {//同上
            if (productList.count < 8) {
                self.specialNum = 0;
            }
        }
        [self getChannelList];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
/**
 *  获得频道列表
 */
- (void)getChannelList {
    [[NetworkService sharedInstance] getHomePageChannelListSuccess:^(NSMutableArray *responseObject) {
        _channelListArray = (NSArray *)responseObject;
        _valiChannelListArray = [NSMutableArray arrayWithCapacity:responseObject.count];
        self.channelNum = 0;
        for (HomePageChannelListModel *channelListModel in _channelListArray) {
            NSArray *productList = channelListModel.productList;
            if (channelListModel.showType != 3) {//显示类型是1,2的 图片少于4张隐藏
                if (productList.count >= 5) {
                    self.channelNum += 1;
                    [_valiChannelListArray addObject:channelListModel];
                }
            }
            if (channelListModel.showType == 3) {//同上
                if (productList.count >= 8) {
                    self.channelNum += 1;
                    [_valiChannelListArray addObject:channelListModel];
                }
            }
        }
        self.sectionNum = self.specialNum + self.channelNum + 2;
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
/**
 *  猜你喜欢列表
 */
- (void)getGuessYouLikeList {
    [[NetworkService sharedInstance] getGuessYouLikeListChannelId:-1
                                                           cityId:010
                                                          Success:^(NSArray *responseObject) {
                                                              _guessYouLikeArray = responseObject;
                                                              [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:self.sectionNum - 1]];
                                                              [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                                                          } Failure:^(NSError *error) {
                                                              [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                          }];
}
//查询用户积分
- (void)queryUserIntrgralSuccess:(void(^)())Success {
    [[NetworkService sharedInstance] getUserQueryIntegralSuccess:^(NSString *integral) {
        _userIntegral = integral;
        Success();
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}

#pragma mark 自定义Method
//返回顶部Method
- (void)toTop {
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionNum;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }
    if (section == (self.sectionNum - 1)) {
        if (ARRAY_IS_NIL(_guessYouLikeArray)) {
            return 0;
        } else {
            return _guessYouLikeArray.count;
        }
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    /**
     *  轮播图
     */
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            BannerViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableBannerViewIdentifier forIndexPath:indexPath];
            if (!_isAlreadyAssignmentForCellBannerView) {
                
                [cell.bannerView setNowFrame:CGRectMake(0, 0, SCREEN_WIDTH, BannerViewHeight)];
        
                if (!ARRAY_IS_NIL(_bannerViewImagesMArray)) {
                    [cell.bannerView setImageUrls:_bannerViewImagesMArray];
                    _isAlreadyAssignmentForCellBannerView = YES;
                }
                
                //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
                [cell.bannerView setImageViewDidTapAtIndex:^(NSInteger index) {
                    NSLog(@"第%zd张图片\n",index);
                    HomePageBannerViewImageModel *bannerModel = _bannerViewMArray[index];
                    if (bannerModel.redirectType.integerValue == 1) {
                        NSLog(@"详情");
                        ProductDetailPageViewController *productDetailController = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageViewController"];
                        productDetailController.productDetailId = bannerModel.detailId;
                        [self.navigationController showViewController:productDetailController sender:self];
                    }
                    if (bannerModel.redirectType.integerValue == 2) {
                        NSLog(@"搜索");
                        SearchResultCollectionViewController *searchResultCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"SearchResultCollectionViewController"];
                        searchResultCon.keyWords = bannerModel.content;
                        searchResultCon.searchWords = bannerModel.content;
                        [self.navigationController pushViewController:searchResultCon animated:YES];
                    }
                    if (bannerModel.redirectType.integerValue == 3) {
                        NSLog(@"广告");
                        return ;
                    }
                    if (bannerModel.redirectType.integerValue == 4) {
                        NSLog(@"频道专页");
                        return ;
                    }
                }];
                
                //default is 2.0f,如果小于0.5不自动播放
                cell.bannerView.AutoScrollDelay = 3.0f;
                
                //下载失败重复下载次数,默认不重复,
                [[BannerWebImageManager shareManager] setDownloadImageRepeatCount:1];
                
                //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
                //error错误信息
                
                //url下载失败的imageurl
                [[BannerWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
                    NSLog(@"%@",error);
                    
                }];
                
            }
            return cell;
        } else {
            ClassificationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableClassifyIdentifier forIndexPath:indexPath];
            [cell cellWithImage:_sectionZeroImageArray[indexPath.item - 1] title:_sectionZeroTitleArray[indexPath.item - 1]];
            return cell;
        }
        
        
    }
    /**
     *  特色馆和频道
     */
    if ((0 < indexPath.section) && (indexPath.section < (self.sectionNum - 1))) {
        SpecialShoppingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableSpecialShoppingIdentifier forIndexPath:indexPath];
        
        if (self.specialNum == 1) {
            if (indexPath.section == 1) {
                if (!ARRAY_IS_NIL(_specialMArray)) {
                    HomePageSpecialModel *specialModel = _specialMArray[0];
                    NSArray *productList = specialModel.list;
                    [cell.cellWithCustomView drawWithArray:productList andTheShowType:specialModel.appType];
                }
            } else {
                if (!ARRAY_IS_NIL(_channelListArray)) {
                    HomePageChannelListModel *channelListModel = _valiChannelListArray[indexPath.section - 2];
                    NSArray *productList = channelListModel.productList;
                    [cell.cellWithCustomView drawWithArray:productList andTheShowType:channelListModel.showType];
                }
            }
        }
        if (self.specialNum == 0) {
            if (!ARRAY_IS_NIL(_channelListArray)) {
                HomePageChannelListModel *channelListModel = _valiChannelListArray[indexPath.section - 1];
                NSArray *productList = channelListModel.productList;
                [cell.cellWithCustomView drawWithArray:productList andTheShowType:channelListModel.showType];
            }
        }
        
        cell.cellWithCustomView.buttonClicked = ^(NSInteger detailId) {
            NSLog(@"%ld", (long)detailId);
            ProductDetailPageViewController *productDetailController = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageViewController"];
            productDetailController.productDetailId = [NSString stringWithFormat:@"%ld", (long)detailId];
            [self.navigationController showViewController:productDetailController sender:self];
        };
        return cell;
    }
    /**
     *  猜你喜欢
     */
    if (indexPath.section == (self.sectionNum - 1)) {
        PublicOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableSectionGuessIdentifier forIndexPath:indexPath];
        
        if (!ARRAY_IS_NIL(_guessYouLikeArray)) {
            [cell cellWithGuessModel:_guessYouLikeArray[indexPath.item]];
        }
        
        return cell;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ((0 < indexPath.section) && (indexPath.section < (self.sectionNum - 1))) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableHeaderViewsIdentifier forIndexPath:indexPath];
        headerView.titleLabel.text = @"";
        
        if (self.specialNum == 1) {
            if (indexPath.section != 1) {
                if (!ARRAY_IS_NIL(_channelListArray)) {
                    HomePageChannelListModel *channelListModel = _channelListArray[indexPath.section - 2];
                    headerView.titleLabel.text = channelListModel.name;
                }
            } else {
                headerView.titleLabel.text = @"特色馆";
            }
        }
        if (self.specialNum == 0) {
            if (!ARRAY_IS_NIL(_channelListArray)) {
                HomePageChannelListModel *channelListModel = _channelListArray[indexPath.section - 1];
                headerView.titleLabel.text = channelListModel.name;
            }
        }
        
        return headerView;
    }
    if (indexPath.section == (self.sectionNum - 1)) {
        GuessYouLikeCollectionReusableView *guessYouLikeHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableGuessHeaderViewsIdentifier forIndexPath:indexPath];
        
        return guessYouLikeHeaderView;
    }
    return nil;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == (self.sectionNum - 1)) {
        return PublicOneCellToLeftValue;
    }
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == (self.sectionNum - 1)) {
        return 10;
    }
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    } else if (section == (self.sectionNum - 1)){
        return UIEdgeInsetsMake(0, (SCREEN_WIDTH - (PublicOneCellWidth * 2) - 10) / 2, 0, (SCREEN_WIDTH - (PublicOneCellWidth * 2) - 10) / 2);
    } else {
        return UIEdgeInsetsMake(1, 0, 0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            return CGSizeMake(SCREEN_WIDTH, BannerViewHeight);
        } else {
            return CGSizeMake(ClassificationWith, ClassificationHeight);
        }
    }
    if ((0 < indexPath.section) && (indexPath.section < (self.sectionNum - 1))) {
        return CGSizeMake(SCREEN_WIDTH, SpecialShoppingItem0Height);
    }
    if (indexPath.section == (self.sectionNum - 1)) {
        return CGSizeMake(PublicOneCellWidth, PublicOneCellHeight);
    }
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(SCREEN_WIDTH, HeaderViewsHieght);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.item == 1) {
            [self judgeIsLoginYes:^{
                [self queryUserIntrgralSuccess:^{
                    IntegralRechargeViewController *integralCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"IntegralRechargeViewController"];
                    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:integralCon];
                    navCon.navigationBar.barTintColor = [UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f];
                    navCon.navigationBar.translucent = NO;
                    integralCon.myIntegral = _userIntegral;
                    integralCon.zhifuType = hebaobao;
                    [self presentViewController:navCon animated:YES completion:^{
                    }];
                }];
            }];
        }
        if (indexPath.item == 4) {
            [self judgeIsLoginYes:^{
                NSLog(@"我的订单");
                OrderAllListCollectionViewController *orderAllListCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"OrderAllListCollectionViewController"];
                orderAllListCon.orderType = allOrderList;
                [self.navigationController pushViewController:orderAllListCon animated:YES];
            }];
        }
        if (indexPath.item == 2) {
            [self judgeIsLoginYes:^{
                FollowAllListCollectionViewController *followAllListCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"FollowAllListCollectionViewController"];
                [self.navigationController pushViewController:followAllListCon animated:YES];
            }];
        }
        if (indexPath.item == 3) {
            [self judgeIsLoginYes:^{
                FootPrintAllListCollectionViewController *footPrintCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"FootPrintAllListCollectionViewController"];
                [self.navigationController pushViewController:footPrintCon animated:YES];
            }];
        }
        if ((indexPath.item == 5)) {
            UIAlertController *alertController = [[UIAlertController alloc]
                                                  initAlertWithTitle:@"提示"
                                                  message:@"新功能暂未实现!"
                                                  preferredStyle:UIAlertControllerStyleAlert
                                                  antionTitle:@"取消"
                                                  actionStyle:UIAlertActionStyleDestructive
                                                  actionHandle:^{
                                                      
                                                  }
                                                  otherActionTitle:@"确定"
                                                  otherActionStyle:UIAlertActionStyleDestructive
                                                        otherActionHandle:^{
                                                      
                                                  }];
            
            [alertController alertShowForViewController:self completion:^{
                
            }];
        }
    }
    if (indexPath.section == (self.sectionNum - 1)) {
        GuessYouLikeModel *guessModel = _guessYouLikeArray[indexPath.item];
        ProductDetailPageViewController *productDetailController = [STOARYBOARD(@"ProductStoryboard") instantiateViewControllerWithIdentifier:@"ProductDetailPageViewController"];
        productDetailController.productDetailId = guessModel.sku;
        [self.navigationController showViewController:productDetailController sender:self];
    }
}
#pragma mark 根据bannerView的位置开启/关闭循环
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == 0) && (indexPath.item == 0)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"startTimer" object:nil];
    }
    if (indexPath.section == 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"endTimer" object:nil];
    }
}
#pragma mark 根据滑动的距离修改自定义导航栏的透明度 和 回顶部按钮的出现/消失
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _TheControllercontentOffsetY = scrollView.contentOffset.y;
//    //修改导航栏的透明度
//    if (_TheControllercontentOffsetY < 0) {
//        if (self.navigationBarView.alpha != 0.0) {
//            self.navigationBarView.alpha = 0.0;
//        }
//    }
//    if (_TheControllercontentOffsetY >= 0) {
//        if (self.navigationBarView.alpha != 1.0) {
//            [Utility annimationWithView:self.navigationBarView];
//            self.navigationBarView.alpha = 1.0;
//        }
//    }
//    
//    //修改导航栏背景的透明度
//    if (_TheControllercontentOffsetY <= BannerViewHeight) {
////        NSLog(@"11 %f", TheControllercontentOffsetY / (BannerViewHeight + BannerViewHeight / 3));
//        self.navigationBarView.backView.alpha = _TheControllercontentOffsetY / (BannerViewHeight + BannerViewHeight / 3);
//    }
    //如果滑动的距离大于设备屏幕的一半就添加返回顶部按钮
    if (_TheControllercontentOffsetY >= SCREEN_HEIGHT / 2) {
        if (self.toTopButton.superview == nil) {
            [self.toTopButton annimation_ScaleView:self.toTopButton duration:1.0 fromValue:0 toValue:1];
            [self.view addSubview:self.toTopButton];
        }
    }
    //如果滑动的距离小于设备屏幕的一半就删除返回顶部按钮
    if (_TheControllercontentOffsetY < SCREEN_HEIGHT / 2) {
        if (self.toTopButton.superview != nil) {
            [self.toTopButton removeFromSuperview];
        }
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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

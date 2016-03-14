//
//  ClassifyPageViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/20.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ClassifyPageViewController.h"
//collectionViewHeaderView
#import "ClassifyPageBannerCollectionReusableView.h"
#import "ClassifyPageCollectionReusableView.h"
//cells
#import "ClassifyPageTableViewCell.h"
#import "ClassifyPageCollectionViewCell.h"
//model
#import "ClassifyPageModel.h"
//searchView
#import "SearchView.h"
//searchResultCon
#import "SearchResultCollectionViewController.h"

@interface ClassifyPageViewController()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewWidthLayoutConstraint;

@end

@implementation ClassifyPageViewController{
    /**
     *  分类
     */
    NSMutableArray *_channelMArray;
    /**
     *  子分类
     */
    NSArray *_subChannelMArray;
    /**
     *  子分类的分类
     */
    NSArray *_keyWorkListArray;
}

#pragma mark 注册需要的Identifier
/**
 *  tableView cellIdentifier
 */
static NSString * const reusableClassifyPageTableViewCellIdentifier                 = @"ClassifyPageTableViewCell";
/**
 *  collectionView  headerViewIdentifier
 */
static NSString * const reusableClassifyPageCollectionBannerViewIdentifier            = @"ClassifyPageBannerCollectionReusableView";
static NSString * const reusableClassifyPageCollectionHeaderViewIdentifier            = @"ClassifyPageCollectionReusableView";
/**
 *  collectionView  cellIdentifier
 */
static NSString * const reusableClassifyPageCollectionViewCellIdentifier            = @"ClassifyPageCollectionViewCell";



- (void)viewDidLoad {
    
    [super viewDidLoad];
    _channelMArray = [NSMutableArray array];
#pragma mark navSearchButton
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchButton setImage:[UIImage imageNamed:@"首页_06"] forState:UIControlStateNormal];
    [self.searchButton setBackgroundColor:[UIColor whiteColor]];
    [self.searchButton setFrame:CGRectMake(ClassifyPageSearchButtonToLeftValue, ClassifyPageSearchButtonToTopValue, ClassifyPageSearchButtonWidth, 31)];
    self.searchButton.layer.masksToBounds = YES;
    self.searchButton.layer.cornerRadius = 5;
    [self.navigationController.navigationBar addSubview:self.searchButton];
    
    [self.searchButton setImageEdgeInsets:UIEdgeInsetsMake(0, ClassifyPageSearchButtonImageInsetsWithLeft, 0, ClassifyPageSearchButtonImageInsetsWithRight)];
    [self.searchButton addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
#pragma mark tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableViewWidthLayoutConstraint setConstant:ClassifyPageTableViewWidth];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, SCREEN_WIDTH);
#pragma mark collectionView
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    /**
     *  注册collectionView的headerView
     */
    [self.collectionView registerNib:[UINib nibWithNibName:@"ClassifyPageBannerCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableClassifyPageCollectionBannerViewIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ClassifyPageCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableClassifyPageCollectionHeaderViewIdentifier];
#pragma mark 请求数据
    [self getChannelList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchButton.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.searchButton.hidden = YES;
}

#pragma mark Method
- (void)getChannelList {
    [[NetworkService sharedInstance] getClassifyPageChannelListSuccess:^(NSMutableArray *responseObject) {
        _channelMArray = responseObject;
        
        [self.tableView reloadData];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        ClassifyPageChannelListModel *channelListModel = _channelMArray[0];
        _subChannelMArray = channelListModel.subChannelList;
        [self.collectionView reloadData];
        
    } Failure:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
}

- (void)goSearch {
    SearchView *searchView = [[[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:nil options:nil] firstObject];
    searchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
    [WINDOW addSubview:searchView];
    __weak SearchView *weakSearchViewSelf = searchView;
    //取消
    searchView.searchViewCancelClickedBlock = ^() {
        [weakSearchViewSelf removeFromSuperview];
    };
    //return
    searchView.searchViewReturnClickedBlock = ^(NSArray *searchResultList) {
        [weakSearchViewSelf removeFromSuperview];
        
        SearchResultCollectionViewController *searchResultCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"SearchResultCollectionViewController"];
        searchResultCon.searchResultList = searchResultList;
        [self.navigationController pushViewController:searchResultCon animated:YES];
    };
}

#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (ARRAY_IS_NIL(_channelMArray)) {
        return 0;
    }
    return _channelMArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [Utility setTableFooterViewZero:tableView];
    ClassifyPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableClassifyPageTableViewCellIdentifier forIndexPath:indexPath];
    
    /**
     *  改变选中cell的背景颜色
     */
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    /**
     *  改变cell的Label颜色
     */
    if (cell.selected) {
        cell.ClassifyPageTableViewCellTitleLabel.textColor = RGB(204, 10, 42);
    } else {
        cell.ClassifyPageTableViewCellTitleLabel.textColor = RGB(33, 33, 33);
    }
    
    ClassifyPageChannelListModel *channelListModel = _channelMArray[indexPath.row];
    cell.ClassifyPageTableViewCellTitleLabel.text = channelListModel.channelName;
    
    return cell;
}
#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ClassifyPageTableViewCellHeight;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyPageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.ClassifyPageTableViewCellTitleLabel.textColor = RGB(33, 33, 33);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    ClassifyPageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.ClassifyPageTableViewCellTitleLabel.textColor = RGB(204, 10, 42);
    
    ClassifyPageChannelListModel *channelListModel = _channelMArray[indexPath.row];
    _subChannelMArray = channelListModel.subChannelList;
    [self.collectionView reloadData];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [Utility animationForTableViewCell:cell];
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (ARRAY_IS_NIL(_subChannelMArray)) {
        return 0;
    }
    return _subChannelMArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (ARRAY_IS_NIL(_subChannelMArray)) {
        return 0;
    }
    ClassifyPageSubChannelListModel *subChannerlModel = _subChannelMArray[section];
    _keyWorkListArray = subChannerlModel.subChannelKeyWordList;
    return _keyWorkListArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableClassifyPageCollectionViewCellIdentifier forIndexPath:indexPath];
    ClassifyPageSubChannelListModel *subChannerlModel = _subChannelMArray[indexPath.section];
    _keyWorkListArray = subChannerlModel.subChannelKeyWordList;
    ClassifyPageKeyWordListModel *keyWordModel = _keyWorkListArray[indexPath.item];
    if (!STR_IS_NIL(keyWordModel.keyWordAppPicUrl)) {
        [cell.collectionViewCellImageView sd_setImageWithURL:[NSURL URLWithString:keyWordModel.keyWordAppPicUrl] placeholderImage:[UIImage imageNamed:@"place"]];
    }
    cell.collectionViewCellTitleLabel.text = keyWordModel.keyWordName;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ClassifyPageSubChannelListModel *subChannerlModel = _subChannelMArray[indexPath.section];
    NSString *titleName = subChannerlModel.subCahnnelName;
    if (indexPath.section == 0) {
        ClassifyPageBannerCollectionReusableView *bannerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableClassifyPageCollectionBannerViewIdentifier forIndexPath:indexPath];
        bannerView.bannerViewTitleLabel.text = titleName;
        return bannerView;
    } else {
        ClassifyPageCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableClassifyPageCollectionHeaderViewIdentifier forIndexPath:indexPath];
        headerView.headerViewTitleLabel.text = titleName;
        return headerView;
    }
}
#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ClassifyPageCollectionViewCellWidth, ClassifyPageCollectionViewCellHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(ClassifyPageCollectionViewCellMinimumLine, ClassifyPageCollectionViewCellMinimumInteritem, ClassifyPageCollectionViewCellMinimumLine, ClassifyPageCollectionViewCellMinimumLine);
    }
    return UIEdgeInsetsMake(ClassifyPageCollectionViewCellMinimumLine, ClassifyPageCollectionViewCellMinimumInteritem, ClassifyPageCollectionViewCellMinimumLine, ClassifyPageCollectionViewCellMinimumLine);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return ClassifyPageCollectionViewCellMinimumLine;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return ClassifyPageCollectionViewCellMinimumInteritem;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(0, ClassifyPageCollectionViewBannerViewHeight);
    }
    return CGSizeMake(0, ClassifyPageCollectionViewHeaderViewHeight);
}
@end

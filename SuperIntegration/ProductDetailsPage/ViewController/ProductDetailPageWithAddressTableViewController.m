//
//  ProductDetailPageWithAddressTableViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ProductDetailPageWithAddressTableViewController.h"
//cell
#import "ProductDetailPageWithAddressTableViewCell.h"

typedef enum{
    addressType_provice = 0,
    addressType_city,
    addressType_district,
    addressType_town
}AddressType;

@interface ProductDetailPageWithAddressTableViewController ()
{
    //列表数据
    NSArray         *_dataArray;
    //选择数据
    NSMutableArray  *_selectedArray;
    //选择的省Id
    NSString        *_selectProvinceId;
    //选择的城市id
    NSString        *_selectCityId;
}

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (assign, nonatomic) AddressType addressType;
@end

@implementation ProductDetailPageWithAddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark 初始化_selectedArray有四个值(省,市,区,乡镇)
    _selectedArray = [NSMutableArray array];
    _selectedArray = (NSMutableArray *)[self.addressString componentsSeparatedByString:@" "];
    if (_selectedArray.count == 3) {
        [_selectedArray addObject:@""];
    }
    if (_selectedArray.count == 5) {
        [_selectedArray removeLastObject];
    }
    self.backButton.hidden = YES;
#pragma mark 监听AddressType的值
    [self addObserver:self forKeyPath:@"addressType" options:NSKeyValueObservingOptionNew context:nil];
    
#pragma mark  请求数据
    [self getProvice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeObserver:self forKeyPath:@"addressType" context:nil];
}

#pragma mark 请求数据
//省份信息
- (void)getProvice {
    [[NetworkService sharedInstance] getProvinceDataSuccess:^(NSArray *responseObject) {
        _dataArray = responseObject;
        self.addressType = addressType_provice;
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
//市信息
- (void)getCityWithProviceId:(NSString *)proviceId noResponseObject:(void(^)())noResponseObject{
    [[NetworkService sharedInstance] getCityDataWithProvId:proviceId Success:^(NSArray *responseObject) {
        if (!ARRAY_IS_NIL(responseObject)) {
            _dataArray = responseObject;
            self.addressType = addressType_city;
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
//区信息
- (void)getDistrictWithCityId:(NSString *)cityId noResponseObject:(void(^)())noResponseObject{
    [[NetworkService sharedInstance] getDistrictDataWithCityId:cityId
                                                       Success:^(NSArray *responseObject) {
                                                           if (!ARRAY_IS_NIL(responseObject)) {
                                                               _dataArray = responseObject;
                                                               self.addressType = addressType_district;
                                                               [self.tableView reloadData];
                                                           }
                                                       } Failure:^(NSError *error) {
                                                           [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                       }];
}
//乡镇信息
- (void)gettTownWithCityId:(NSString *)cityId andDistrictId:(NSString *)districtId noResponseObject:(void(^)())noResponseObject{
    [[NetworkService sharedInstance] getTownDataWithCityId:cityId
                                                  countyId:districtId
                                                   Success:^(NSArray *responseObject) {
                                                       if (!ARRAY_IS_NIL(responseObject)) {
                                                           _dataArray = responseObject;
                                                           self.addressType = addressType_town;
                                                           [self.tableView reloadData];
                                                       } else {
                                                           noResponseObject();
                                                       }
                                                   } Failure:^(NSError *error) {
                                                       [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                   }];
}
#pragma mark  Method
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([change[@"new"] integerValue] != 0) {
        self.backButton.hidden = NO;
    } else {
        self.backButton.hidden = YES;
    }
}
- (IBAction)backButtonClicked:(id)sender {
    [_selectedArray removeLastObject];
    if (self.addressType == addressType_city) {
        [self getProvice];
    }
    if (self.addressType == addressType_district) {
        [self getCityWithProviceId:_selectProvinceId noResponseObject:^{
            
        }];
    }
    if (self.addressType == addressType_town) {
        [self getDistrictWithCityId:_selectCityId noResponseObject:^{
            
        }];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (ARRAY_IS_NIL(_dataArray)) {
        return 0;
    }
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailPageWithAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailPageWithAddressTableViewCell" forIndexPath:indexPath];
    [cell cellWithAddress:_dataArray[indexPath.row][@"name"] andSelectedAddress:_selectedArray[self.addressType]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailPageWithAddressTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [_selectedArray replaceObjectAtIndex:self.addressType withObject:cell.addressLabel.text];
    
    if (self.addressType == addressType_provice) {
        [self getCityWithProviceId:_dataArray[indexPath.row][@"code"] noResponseObject:^{
            self.backSelectAddressBlock((NSArray *)_selectedArray);
        }];
        _selectProvinceId = _dataArray[indexPath.row][@"code"];
    }
    if (self.addressType == addressType_city) {
        [self getDistrictWithCityId:_dataArray[indexPath.row][@"code"] noResponseObject:^{
            if (_selectedArray.count > self.addressType) {
                [_selectedArray removeLastObject];
            }
            self.backSelectAddressBlock((NSArray *)_selectedArray);
        }];
        _selectCityId = _dataArray[indexPath.row][@"code"];
    }
    if (self.addressType == addressType_district) {
        [self gettTownWithCityId:_selectCityId andDistrictId:_dataArray[indexPath.row][@"code"] noResponseObject:^{
            if (_selectedArray.count > self.addressType) {
                [_selectedArray removeLastObject];
            }
            self.backSelectAddressBlock((NSArray *)_selectedArray);
        }];
    }
    if (self.addressType == addressType_town) {
        self.backSelectAddressBlock((NSArray *)_selectedArray);
    }
}


@end

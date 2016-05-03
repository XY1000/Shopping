//
//  CreatAddressTableViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/1/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "CreatAddressTableViewController.h"
#import "AddressModel.h"

@interface CreatAddressTableViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>


//收件人
@property (weak, nonatomic) IBOutlet UITextField *txt_recipients;

//手机号
@property (weak, nonatomic) IBOutlet UITextField *txt_phone;

//详细地址
@property (weak, nonatomic) IBOutlet UITextField *txt_message;
//所在区域
@property (weak, nonatomic) IBOutlet UILabel *lb_zone;

//地址标签
@property (weak, nonatomic) IBOutlet UITextField *txt_addressLabel;

//Email
@property (weak, nonatomic) IBOutlet UITextField *txt_email;

//家庭电话
@property (weak, nonatomic) IBOutlet UITextField *homePhone;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;


@end

@implementation CreatAddressTableViewController
{
    NSArray *_provinceArr;  //省份
    NSArray *_cityArr;      //城市
    NSArray *_districtArr;  //区
    NSArray *_townArr;      //乡镇

    UIPickerView *_pick;
    UIView *allView;
    NSString *province,*city,*district,*town; //选择完，返回的字段
    NSString *provinceID,*cityID,*districtID,*townID; //选择完，返回的字段Id
    
    UIAlertController *alert;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新建地址";
    
    self.widthLayout.constant = btnWidth;
    self.heightLayout.constant = btnHeight;
    
    //页面出现时，请求数据
    [self getProvData];
    [self initPicView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 省、市、乡村网络请求

/**  获取省份的网络数据 **/
- (void)getProvData{
    
    province = nil;
    city = nil;
    district = nil;
    town = nil;
    
    provinceID = nil;
    cityID = nil;
    districtID = nil;
    townID = nil;
    
    [[NetworkService sharedInstance] getProvinceDataSuccess:^(NSArray *responseObject) {
       
        _provinceArr = responseObject;
        
        [_pick selectRow:0 inComponent:1 animated:YES];
        
       
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
    
}
/**  获取城市的网络数据 **/
- (void)getCityDataWithProvId:(NSString *)provId{
    
     _districtArr = nil;
        _townArr = nil;
        district = nil;
        town = nil;
    districtID = nil;
    townID = nil;
    
    [[NetworkService sharedInstance] getCityDataWithProvId:provId Success:^(NSArray *responseObject) {
        
        //判断数据是否为空
        if (!ARRAY_IS_NIL(responseObject)) {
            
          
            
        _cityArr = responseObject;
        
        [self pickerView:_pick didSelectRow:0 inComponent:1];
            [_pick selectRow:0 inComponent:1 animated:NO];
           
        }else{
            
            _cityArr = nil;
            city = nil;
            cityID = nil;
        }
        [_pick reloadAllComponents];
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
/**  获取区列表的网络数据 **/
- (void)getDistDataWithCityId:(NSString *)cityId{
    
    _townArr = nil;
    town = nil;
    townID = nil;
    [[NetworkService sharedInstance] getDistrictDataWithCityId:cityId Success:^(NSArray *responseObject) {
        
        if (!ARRAY_IS_NIL(responseObject)) {
           
        
        _districtArr = responseObject;
        
        [_pick selectRow:0 inComponent:2 animated:YES];
        
        [self pickerView:_pick didSelectRow:0 inComponent:2];
       
    
        }else{
            
            _districtArr = nil;
            district = nil;
            districtID = nil;
        }
        [_pick reloadAllComponents];
        

    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
}
/**  获取乡镇的网络数据 **/
- (void)getTownDataWithCityId:(NSString *)cityId DistId:(NSString *)countyId{
    
    [[NetworkService sharedInstance] getTownDataWithCityId:cityId countyId:countyId Success:^(NSArray *responseObject) {
        if (!ARRAY_IS_NIL(responseObject)) {
            
        _townArr = responseObject;
        [self pickerView:_pick didSelectRow:0 inComponent:3];
            [_pick selectRow:0 inComponent:3 animated:NO];
        }else{
            _townArr = nil;
            town = nil;
            townID = nil;
        }
        [_pick reloadComponent:3];

    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
    
}

#pragma mark - 添加地址的网络

- (void)addAddressNet{
    
    
    [HXYTool userNotLogin:self login:^{
       
        if (!cityID) {
            
            cityID = @"";
        }
        if (!districtID) {
            districtID = @"";
        }
        if (!townID) {
            townID = @"";
        }
        
        
        
    [SVProgressHUD showWithStatus:@"正在添加"];

    [[NetworkService sharedInstance] postUserAddAddressWithTelephone:self.txt_phone.text Contact:self.txt_recipients.text ProvinceId:provinceID CityId:cityID CountyId:districtID TownId:townID Name:self.txt_addressLabel.text Email:self.txt_email.text AddressDetail:self.txt_message.text Phone:self.homePhone.text provinceName:province cityName:city?city:@"" countyName:district?district:@"" townName:town?town:@"" Success:^{
        
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
        
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
   
    
    }];
    
}
//初始化选择器、按钮
- (void)initPicView{
    
    allView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.tableView.bounds.size.width, 200)];
   
    allView.backgroundColor = [UIColor whiteColor];
    
    _pick = [[UIPickerView alloc]init];
    _pick.backgroundColor = [UIColor whiteColor];
    _pick.frame = CGRectMake(0, 50, self.view.bounds.size.width, 150);
    _pick.dataSource = self;
    _pick.delegate = self;
    _pick.layer.borderWidth = 1;
    _pick.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [allView addSubview:_pick];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [cancelBtn setTitle:@"关闭" forState:(UIControlStateNormal)];
    [cancelBtn addTarget:self action:@selector(clickCancel) forControlEvents:(UIControlEventTouchUpInside)];
    cancelBtn.frame = CGRectMake(10, 5, 50, 30);
    [cancelBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];

    [allView addSubview:cancelBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [sureBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [sureBtn addTarget:self action:@selector(ClickSure) forControlEvents:(UIControlEventTouchUpInside)];
    [sureBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];

    sureBtn.frame = CGRectMake(self.view.bounds.size.width - 60, 5, 50, 30);
    [allView addSubview:sureBtn];
    

    [self.view addSubview:allView];
    
    
    
    
   
}
//取消按钮
- (void)clickCancel{
    
  [UIView animateWithDuration:1 animations:^{
       
        allView.frame = CGRectMake(0, self.view.bounds.size.height, self.tableView.bounds.size.width, 200);
        
    }];
    
    
}

//确定按钮
- (void)ClickSure{
    
    DLog(@"%@",[NSString stringWithFormat:@"%@ %@ %@ %@",province,city,district,town]);
    [self clickCancel];
    if (province) {
        
        self.lb_zone.text = [NSString stringWithFormat:@"%@%@%@%@",province,city?city:@"",district?district:@"",town?town:@""];
        
       
    }
    
}





#pragma mark - 保存

- (IBAction)save:(id)sender {
    
    if (STR_IS_NIL(self.txt_phone.text)) {
        [SVProgressHUD showErrorWithStatus:@"请填写联系人手机号"];
        return;
    }
    if (STR_IS_NIL(self.txt_message.text)) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写收货人的详细地址"];
        return;
    }
    if (STR_IS_NIL(self.txt_recipients.text)) {
        [SVProgressHUD showErrorWithStatus:@"请填写收货人姓名"];
        return;
    }
    if (STR_IS_NIL(self.lb_zone.text)) {
        [SVProgressHUD showErrorWithStatus:@"所在区域不能为空"];
        return;
    }
    
    if (STR_IS_NIL(self.txt_addressLabel.text)) {
        
        [SVProgressHUD showErrorWithStatus:@"家庭标签不能为空"];
        
        return;
        
    }
    
    
    if (![Utility checkUserTelNumber:self.txt_phone.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        
        return;
    }
    
    if (![Utility checkUserName:self.txt_recipients.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"请填有效的用户名"];
        return;
    }
    
    if (!STR_IS_NIL(self.txt_email.text)) {
        
        if (![Utility validateEmail:self.txt_email.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱"];
        return;
    }
        
        
    }
    
    if (self.txt_message.text.length > 30) {
        
        [SVProgressHUD showErrorWithStatus:@"详细地址输入过长"];
        return;
        
    }
    
    
    
    DLog(@"%@",self.txt_message.text);
   

    
  
    [self addAddressNet];
    
}
#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 5) {
        
       
        [self.view endEditing:YES];
        
        [UIView animateWithDuration:1 animations:^{
           
            allView.frame = CGRectMake(0, self.view.bounds.size.height - 200, self.view.bounds.size.width, 200);
        }];

        if (province) {
            
            NSDictionary *dic = @{
                                  @"name":province,
                                  @"code":provinceID
                                  };
            
            NSUInteger index = [_provinceArr indexOfObject:dic];
            
            [_pick selectRow:index inComponent:0 animated:NO];
            
        }else{
            
        [self pickerView:_pick didSelectRow:0 inComponent:0];
            
        }
    }
}




#pragma mark - UIPickViewDelegate/ DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger count = 0;
    switch (component) {
        case 0:
            count = _provinceArr.count;
            break;
        case 1:
            count = _cityArr.count;
            break;
        case 2:
            count = _districtArr.count;
            break;
        case 3:
            count = _townArr.count;
            break;
        default:
            break;
    }
    return count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *dic ;
    switch (component) {
        case 0:
        {
            dic = _provinceArr[row];
            
        }
            break;
        case 1:
        {
            dic = _cityArr[row];
        }
            break;
        case 2:
        {
            dic = _districtArr[row];
        }
            break;
            case 3:
        {
            dic = _townArr[row];
        }
        default:
            break;
    }
    return dic[@"name"];
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont systemFontOfSize:14];
        pickerLabel.textColor = [UIColor blackColor];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
//点击PickView
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
   
    
    switch (component) {
        case 0:
        {
            
            province = _provinceArr[row][@"name"];
            provinceID = _provinceArr[row][@"code"];
            [self getCityDataWithProvId:_provinceArr[row][@"code"]];
            
            
            
            
        }
            break;
        case 1:
        {
            city = _cityArr[row][@"name"];
            cityID = _cityArr[row][@"code"];

            if (_cityArr[row][@"code"]) {
                
                [self getDistDataWithCityId:_cityArr[row][@"code"]];
            }
            
           
        }
            break;
        case 2:
        {
            district = _districtArr[row][@"name"];
            districtID = _districtArr[row][@"code"];

            NSInteger tmp ;
            
            if (_districtArr.count > _cityArr.count) {
                
            tmp = [_pick selectedRowInComponent:1];
                
            
            }else{
            
                tmp = row;
            }
            
            if (_cityArr[tmp][@"code"]&&_districtArr[row][@"code"]) {
                
                [self getTownDataWithCityId:cityID DistId:_districtArr[row][@"code"]];
            }
            
            
        }
            break;
        case 3:
        {
            town = _townArr[row][@"name"];
            townID = _townArr[row][@"code"];

            
        }
            break;
        default:
            break;
    }


    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}



@end

//
//  ShoppingCartPageCartCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ShoppingCartPageCartCollectionViewCell.h"
#import "ShoppingCartPageModel.h"

@interface ShoppingCartPageCartCollectionViewCell()<UITextFieldDelegate>
{
    
    ShoppingCartPageModel *_cartModel;
    NSString              *_lastText;
}


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txt_LayoutWidth_Input;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_PriceTopTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_ImageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelBottomToImageLayoutConstraint;

@property (assign, nonatomic) NSInteger textInteger;
@property (assign, nonatomic) CellType cellType;

@end

@implementation ShoppingCartPageCartCollectionViewCell

- (void)awakeFromNib {
    
    self.txt_LayoutWidth_Input.constant = SCREEN_WIDTH * 200 / (375 * 2);
    [self.labelBottomToImageLayoutConstraint setConstant:-PublicZeroCellLabelValue];
    self.layout_ImageWidth.constant = (PublicZeroCellHeight - 20);
    
    self.textField.delegate = self;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    self.textField.text = @"1";
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, self.textField.frame.size.height)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"减号"] forState:UIControlStateNormal];
    self.textField.leftView = leftButton;
    leftButton.tag = 1;
    [leftButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 25, self.textField.frame.size.height)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"积分兑换_11"] forState:UIControlStateNormal];
    self.textField.rightView = rightButton;
    rightButton.tag = 2;
    [rightButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"开始编辑");
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:RGB(204, 10, 42) forState:UIControlStateNormal];
    [button setFrame:CGRectMake(SCREEN_WIDTH - 95, 0, 80, 40)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button addTarget:self action:@selector(btn_CommitClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 0.5, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineView];
    
    self.textField.inputAccessoryView = view;
    
    
}

//数量加减
- (void)buttonClicked:(UIButton *)button {
    _textInteger = self.textField.text.integerValue;
    if (button.tag == 1) {
        if (self.textInteger > 1) {
            _textInteger -= 1;
        }
    }
    if (button.tag == 2) {
        if (self.textInteger < 99) {
            _textInteger += 1;
        } else {
            [SVProgressHUD showErrorWithStatus:@"最多只能买99件哦!"];
        }
    }

    for (ShoppingCartPageModel *model in [ShoppingCartManager sharedInstance].allMArray) {
        if (_cartModel.id == model.id) {
            model.amount = self.textInteger;
        }
    }
    
    /**
     *  定时0.5s
     */
    self.textField.text = [NSString stringWithFormat:@"%lu", (long)self.textInteger];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(update) object:button];
    [self performSelector:@selector(update) withObject:button afterDelay:0.3];
    

//    [self inventoryProductWithSku:_cartModel.sku num:textInteger success:^{
//        self.updateClickedBlock(_cartModel.id, textInteger);
//        self.textField.text = [NSString stringWithFormat:@"%lu", (long)textInteger];
//    }];
}
- (void)update {
    self.updateClickedBlock(_cartModel.id, self.textInteger);
}


//查询商品库存
- (void)inventoryProductWithSku:(NSString *)Sku num:(NSInteger)Num success:(void(^)())Success{
    [[NetworkService sharedInstance] getProcuctInventoryWithProductSku:Sku
                                                            ProductNum:Num
                                                                CityId:@"010"
                                                             CountryId:@"01"
                                                               Success:^{
                                                                   Success();
                                                               } Failure:^(NSError *error) {
                                                                   [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
                                                               }];
}

/**
 *  选择
 */
- (IBAction)selectClicked:(id)sender {
    NSLog(@"选择");
    if (self.selectButton.selected) {
        [self.selectButton setSelected:NO];
        if (_cellType == compelteCell) {
            [[ShoppingCartManager sharedInstance].completeSelectedMArray removeObject:_cartModel];
        }
        if (_cellType == editCell) {
            [[ShoppingCartManager sharedInstance].editSelectMArray removeObject:_cartModel];
        }
    } else {
        [self.selectButton setSelected:YES];
        if (_cellType == compelteCell) {
            [[ShoppingCartManager sharedInstance].completeSelectedMArray addObject:_cartModel];
        }
        if (_cellType == editCell) {
            [[ShoppingCartManager sharedInstance].editSelectMArray addObject:_cartModel];
        }
    }
    
    if (_cellType == compelteCell) {
        self.selectedClickedBlock([ShoppingCartManager sharedInstance].completeSelectedMArray.count);
    }
    if (_cellType == editCell) {
        self.selectedClickedBlock([ShoppingCartManager sharedInstance].editSelectMArray.count);
    }
}


- (void)cellWithModel:(ShoppingCartPageModel *)model andCellType:(CellType)cellType{
    
    _cellType = cellType;

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"place"]];
    self.titleLabel.text = model.name;
    self.priceLabel.text = model.price;
    self.textField.text = [NSString stringWithFormat:@"%lu", (long)model.amount];
    _cartModel = model;
    
    [self.selectButton setSelected:NO];
    
    if (cellType == compelteCell) {
        for (ShoppingCartPageModel *cartModel in [ShoppingCartManager sharedInstance].completeSelectedMArray) {
            if (cartModel.id == _cartModel.id) {
                [self.selectButton setSelected:YES];
            }
        }
    }
    if (cellType == editCell) {
        for (ShoppingCartPageModel *cartModel in [ShoppingCartManager sharedInstance].editSelectMArray) {
            if (cartModel.id == _cartModel.id) {
                [self.selectButton setSelected:YES];
            }
        }
    }
    
}

#pragma mark <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _lastText = self.textField.text;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    NSLog(@"end");
    [self btn_CommitClicked];
}

- (void)textFieldDidChange:(NSNotification *)note
{
    NSLog(@"%@", self.textField.text);
    if ([self.textField.text integerValue] > 99) {
        [SVProgressHUD showErrorWithStatus:@"最多只能买99件哦!"];
        self.textField.text = @"99";
    }
}

- (void)btn_CommitClicked {
    if ([self.textField.text integerValue] == 0) {
        self.textField.text = _lastText;
    } else {
        for (ShoppingCartPageModel *model in [ShoppingCartManager sharedInstance].allMArray) {
            if (_cartModel.id == model.id) {
                model.amount = self.textField.text.integerValue;
            }
        }
        self.updateClickedBlock(_cartModel.id, self.textField.text.integerValue);
//        [self inventoryProductWithSku:_cartModel.sku num:self.textField.text.integerValue success:^{
//            self.updateClickedBlock(_cartModel.id, self.textField.text.integerValue);
//        }];
    }
    [self.textField resignFirstResponder];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.textField];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

@end

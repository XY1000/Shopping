//
//  PayPassTableViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/1/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "PayPassTableViewController.h"
#import "OrderPayPasswordView.h"
#import "UITextField+extension.h"
#import "AccountSecurityTableViewController.h"

#define INERVAL_WIDTH 1         //间隔的宽
#define INERVAL_HEIGHT 1        //间隔的高
#define KEYBTN_HEIGHT  60       //按键的高度

@interface PayPassTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet OrderPayPasswordView *firstView;

@property (weak, nonatomic) IBOutlet OrderPayPasswordView *secondView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;

//键盘边框宽度（storyboard 可设置）
@property (assign, nonatomic)IBInspectable CGFloat borderWidth;
//键盘边框颜色
@property (strong, nonatomic)IBInspectable UIColor *borderColor;

@end

@implementation PayPassTableViewController
{
    
    NSInteger _tmpTextFiledTag;
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"支付密码";
    
    self.widthLayout.constant = btnWidth;
    self.heightLayout.constant = btnHeight;
    
    
    
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
   
    
     [self initPassword];
}





- (void)initPassword{
    
    [self.firstView setFrame:CGRectMake(0, 0,self.firstView.frame.size.width, self.firstView.frame.size.height)];
    [self.firstView drawView];
    self.firstView.pwdTextField.inputView = [self CustomKeyBoardView];
    self.firstView.pwdTextField.tag = 100;
    self.firstView.pwdTextField.delegate = self;
   
    DLog(@"width = %f",self.firstView.bounds.size.width);
    
    [self.secondView setFrame:CGRectMake(0, 0, self.secondView.frame.size.width, self.secondView.frame.size.height)];
    [self.secondView drawView];
    
    self.secondView.pwdTextField.inputView = [self CustomKeyBoardView];
    self.secondView.pwdTextField.delegate = self;
    self.secondView.pwdTextField.tag = 200;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _tmpTextFiledTag = textField.tag;
    
}

#pragma mark - 下一步

- (IBAction)Next:(UIButton *)sender {
    
    NSArray *arr = self.navigationController.viewControllers;
    NSInteger num = arr.count - 3;
    if (self.firstView.pwdTextField.text.length != 6 && self.secondView.pwdTextField.text.length != 6) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (![self.firstView.pwdTextField.text isEqualToString:self.secondView.pwdTextField.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"密码不一致"];
        return ;
    }
    
    
    
    [[NetworkService sharedInstance] postPayPasswordWith:self.secondView.pwdTextField.text Success:^{
        
        [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        
       [self.navigationController popToViewController:arr[num] animated:YES];
        
    } Failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
    
    
    
    
}


#pragma mark - 自定义键盘

//键盘界面
- (UIView *)CustomKeyBoardView{
    
    NSArray *arr = [self randomArr];
    
    UIView *keyBoardView = [[UIView alloc] initWithFrame:CGRectMake( 0, SCREEN_HEIGHT - (KEYBTN_HEIGHT * 4 + INERVAL_HEIGHT * 3) ,SCREEN_WIDTH, KEYBTN_HEIGHT * 4 + INERVAL_HEIGHT * 3)];
    
    keyBoardView.backgroundColor = [UIColor lightGrayColor];
    
    //每个按键的宽度
    CGFloat btnW = (SCREEN_WIDTH - 2 * INERVAL_WIDTH) / 3.0;
    
    //配置每个按键
    for (int i = 0; i < 4; i++) {
        
        for (int j = 0; j < 3; j++) {
            
            static  int tmp = 0;
            UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake(j * (btnW + INERVAL_WIDTH), i * (KEYBTN_HEIGHT + INERVAL_HEIGHT), btnW, KEYBTN_HEIGHT)];
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            NSNumber *str = nil;
            
            //最后一行的设置
            if (i == 3) {
                
                switch (j) {
                    case 0:
                        [btn setTitle:@"取消" forState:(UIControlStateNormal)];
                        [btn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
                        break;
                    case 1:
                        str = [arr objectAtIndex:tmp];
                        tmp = 0;
                        [btn setTitle:str.stringValue forState:(UIControlStateNormal)];
                        [btn addTarget:self action:@selector(numberClick:) forControlEvents:(UIControlEventTouchUpInside)];
                        break;
                    case 2:
                        [btn setImage:[UIImage imageNamed:@"支付密码修改2_03"] forState:(UIControlStateNormal)];
                        [btn addTarget:self action:@selector(deleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
                        break;
                        
                    default:
                        break;
                }
                
            }else{
                
                str = [arr objectAtIndex:tmp];
                [btn setTitle:str.stringValue forState:(UIControlStateNormal)];
                
                [btn addTarget:self action:@selector(numberClick:) forControlEvents:(UIControlEventTouchUpInside)];

                tmp++;
                
            }
            
            btn.backgroundColor = [UIColor whiteColor];
            [keyBoardView addSubview:btn];
            
            
        }
        
        
    }
    
    keyBoardView.layer.borderWidth = self.borderWidth;
    keyBoardView.layer.borderColor = self.borderColor.CGColor;
    
    
    return keyBoardView;
}

//点击数字
- (void)numberClick:(UIButton *)button {
    
    
    
    if (_tmpTextFiledTag == 100) {
        
        
        
        if (self.firstView.pwdTextField.text.length <=5) {
            
            [self.firstView.pwdTextField changetext:button.titleLabel.text];
            [self.firstView setDotWithCount:self.firstView.pwdTextField.text.length];
        }
        
        DLog(@"%@",self.firstView.pwdTextField.text);
        
    }else{
        
        
        
        if (self.secondView.pwdTextField.text.length <= 5) {
            [self.secondView.pwdTextField changetext:button.titleLabel.text];
            [self.secondView setDotWithCount:self.secondView.pwdTextField.text.length];
        }
        
        DLog(@"%@",self.secondView.pwdTextField.text);

    }
    
    
    
}

//取消按钮点击
- (void)cancelBtnClick:(UIButton *)button{
    
    [self.view endEditing:YES];
    
}

//删除按钮点击
- (void)deleBtnClick:(UIButton *)button {
    
    
    
    
    if (_tmpTextFiledTag == 100) {
        
        [self.firstView.pwdTextField changetext:@""];
        
        if (self.firstView.pwdTextField.text.length <=5) {
            
            [self.firstView setDotWithCount:self.firstView.pwdTextField.text.length];
        }
        
        DLog(@"%@",self.firstView.pwdTextField.text);
        
    }else{
        
        [self.secondView.pwdTextField changetext:@""];
        
        if (self.secondView.pwdTextField.text.length <= 6) {
            
            [self.secondView setDotWithCount:self.secondView.pwdTextField.text.length];
        }
        
        DLog(@"%@",self.secondView.pwdTextField.text);
        
    }
    
    
}

//生成随机的数组
- (NSArray *)randomArr{
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:@[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9]];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        
        int t = arc4random() % arr.count;
        
        resultArr[i] = arr[t];
        
        arr[t] = [arr lastObject];
        [arr removeLastObject];
        
    }
    
    return [resultArr copy];
    
}



@end

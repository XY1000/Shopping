//
//  RechargeSuccessViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/23.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "RechargeSuccessViewController.h"
#import "BaseTabbarViewController.h"
@interface RechargeSuccessViewController ()

@property (weak, nonatomic) IBOutlet UIButton *label_RechargePrice;
@property (strong, nonatomic) UIView *backView;
@end

@implementation RechargeSuccessViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.label_RechargePrice setTitle:self.rechargePrice forState:UIControlStateNormal];
    
//    self.navigationItem.leftBarButtonItem = nil;
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 150, 40)];
    _backView.backgroundColor = RGB(204, 10, 42);
    [WINDOW addSubview:self.backView];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.backView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn_BackHomeClicked:(id)sender {
    BaseTabbarViewController *tabCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"BaseTabbarViewController"];
    WINDOW.rootViewController = tabCon;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

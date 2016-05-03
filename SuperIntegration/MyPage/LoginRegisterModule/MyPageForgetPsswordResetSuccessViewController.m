//
//  MyPageForgetPsswordResetSuccessViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/2.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "MyPageForgetPsswordResetSuccessViewController.h"
#import "BaseTabbarViewController.h"

@implementation MyPageForgetPsswordResetSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//回首页
- (IBAction)btn_backHomeClicked:(id)sender {
    BaseTabbarViewController *tabCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"BaseTabbarViewController"];
    WINDOW.rootViewController = tabCon;
}

@end

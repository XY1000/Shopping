//
//  BaseTabbarViewController.m
//  MeridianStreamer
//
//  Created by PP－mac001 on 15/9/1.
//  Copyright (c) 2015年 PP－mac001. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "BaseNavViewController.h"

@interface BaseTabbarViewController ()<UIAlertViewDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UITabBarItem *shoppingCartPageBarItem;

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = RGB(217, 52, 79);
    self.delegate = self;
    
    //修改tabbar的背景色
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = RGB(36, 37, 38);
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
    
    //购物车badgeValue
    self.shoppingCartPageBarItem = [self.tabBar.items objectAtIndex:3];
    
    /**
     *  获得购物车数量
     */
    [self getShoppingCartPageCartAmount];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getShoppingCartPageCartAmount) name:@"cartAmount" object:nil];
    
    /**
     *  登录失效
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goLoginCon) name:@"login" object:nil];
    
//    self.tabBarController.tabBar.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)goLoginCon {
    //未登录
    BaseNavViewController *loginCon = [STOARYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"BaseNavLoginViewController"];
    [self presentViewController:loginCon animated:YES completion:^{
        
    }];
}

- (void)getShoppingCartPageCartAmount {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        [[NetworkService sharedInstance] getShoppingCartPageCartAmountSuccess:^(NSInteger responseObject) {
            DLog(@"购物车数量 = %ld",(long)responseObject);
            if (responseObject > 0) {
                self.shoppingCartPageBarItem.badgeValue = [NSString stringWithFormat:@"%ld", (long)responseObject];
            } else {
                self.shoppingCartPageBarItem.badgeValue = nil;
            }
        } Failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
        }];
    } else {
        self.shoppingCartPageBarItem.badgeValue = nil;
    }
}


//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//
//}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    DLog(@"%@  %d", viewController.title,tabBarController.selectedIndex);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

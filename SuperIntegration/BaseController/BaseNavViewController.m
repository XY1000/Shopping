//
//  BaseNavViewController.m
//  KMovie
//
//  Created by PP－mac001 on 15/7/13.
//  Copyright (c) 2015年 PP－mac001. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:204/255.0 green:10/255.0 blue:42/255.0 alpha:1.0f];
    self.navigationBar.translucent = NO;
    
    // 设置标题颜色
    NSMutableDictionary *titleAttrs = [NSMutableDictionary dictionary];
    titleAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    titleAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17.0];
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttrs];
    
    // 设置item样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15.0];
    [ [UIBarButtonItem appearance] setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //侧滑返回
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ( gestureRecognizer == self.interactivePopGestureRecognizer ) {
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] ) {
            return NO;
        }
    }
    return YES;
}
/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    UIBarButtonItem *drawerBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"120客户端图标汇总_14"] style:UIBarButtonItemStylePlain target:self action:@selector(settingBtnClick)];
    //
    //    viewController.navigationItem.leftBarButtonItem =drawerBarButtonItem;
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setFrame:CGRectMake(0, 0, 20, 20)];
//        [backButton setImage:[UIImage imageNamed:@"搜索结果页_检索展开演示3_03"] forState:UIControlStateNormal];
//        
//        [backButton addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//        [backBarButtonItem setTintColor:[UIColor whiteColor]];
//        viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
        
        UIBarButtonItem *drawerBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索结果页_检索展开演示3_03"] style:UIBarButtonItemStylePlain target:self action:@selector(settingBtnClick)];
        [drawerBarButtonItem setTintColor:[UIColor whiteColor]];
        viewController.navigationItem.leftBarButtonItem =drawerBarButtonItem;
    }
    
    //侧滑返回
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
    
}

-(void)settingBtnClick{
    [self popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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

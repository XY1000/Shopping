//
//  MyPageSetViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/4.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "MyPageSetViewController.h"

@interface MyPageSetViewController()

@property (weak, nonatomic) IBOutlet UILabel *label_CacheAmount;
@property (weak, nonatomic) IBOutlet UIButton *btn_LoginOut;
@end

@implementation MyPageSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self judgeIsLoginYes:^{
        
    }];
    
    self.label_CacheAmount.text = [NSString stringWithFormat:@"%.2f M", [self getCachtAmount]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)getCachtAmount {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return [Utility folderSizeAtPath:cachesDir];
}

//清除缓存
- (IBAction)btn_CleanClicked:(id)sender {
    [Utility releaseCache];
    self.label_CacheAmount.text = @"0.00 M";
}
//关于
- (IBAction)btn_AbountClicked:(id)sender {
}
//退出登录
- (IBAction)btn_LoginOutClicked:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
    //获得该用户的购物车数量
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cartAmount" object:nil];
    [self judgeIsLoginYes:^{
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  判断是否登录
 */
- (void)judgeIsLoginYes:(void(^)())yes {
    //已登录
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        self.btn_LoginOut.hidden = NO;
        yes();
    } else {
        self.btn_LoginOut.hidden = YES;
    }
}

@end

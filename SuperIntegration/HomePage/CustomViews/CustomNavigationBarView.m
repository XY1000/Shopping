//
//  CustomNavigationBarView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/14.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "CustomNavigationBarView.h"

@interface CustomNavigationBarView()

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchButtonWidthLayoutConstraint;


@end

@implementation CustomNavigationBarView

- (void)awakeFromNib {
    self.searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, -SearchButtonTitleInsetsWithLeft, 0, 0);
    self.searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, SearchButtonImageInsetsWithLeft, 0, SearchButtonImageInsetsWithRight);
    [self.searchButtonWidthLayoutConstraint setConstant:SearchButtonWidth];
}

- (IBAction)searchClicked:(id)sender {
    self.searchClicked();
}
- (IBAction)newsCliked:(id)sender {
    NSLog(@"消息");
}

@end

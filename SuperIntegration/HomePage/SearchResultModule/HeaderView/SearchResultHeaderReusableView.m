//
//  SearchResultHeaderReusableView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/27.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "SearchResultHeaderReusableView.h"
#import "SearchResultModel.h"
@interface SearchResultHeaderReusableView()

@property (weak, nonatomic) IBOutlet UIButton *button1Btn;
@property (weak, nonatomic) IBOutlet UIButton *button2Btn;
@property (weak, nonatomic) IBOutlet UIButton *button3Btn;
@property (weak, nonatomic) IBOutlet UIButton *button4Btn;


@end

@implementation SearchResultHeaderReusableView

- (void)awakeFromNib {
    [self.button1Btn setImageEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton1ImageInsets, 0, 0)];
//    [self.button1Btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -SearchResultHeaderViewButton1TitleInsets, 0, 0)];
    [self.button2Btn setImageEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton2ImageInsets, 0, 0)];
//    [self.button2Btn setTitleEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton2TitleInsets, 0, 0)];
    [self.button3Btn setImageEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton2ImageInsets, 0, 0)];
//    [self.button3Btn setTitleEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton2TitleInsets, 0, 0)];
//    [self.button4Btn setTitleEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton4TitleInsets, 0, 0)];
    [self.button1Btn setSelected:YES];
}


/**
 *  默认排序
 */
- (IBAction)button1Clicked:(id)sender {
    if (!self.button1Btn.selected) {
        [self.button1Btn setSelected:YES];
        [self.button3Btn setSelected:NO];
        [self.button2Btn setSelected:NO];
        self.block_PriceCompare(@"", @"");
    }
}
/**
 *  价格
 */
- (IBAction)button2Clicked:(id)sender {
    [self.button1Btn setSelected:NO];
    NSString *order = @"";
    if (self.button2Btn.selected) {
        [self.button2Btn setSelected:NO];
        order = @"desc";
    } else {
        order = @"asc";
        [self.button3Btn setSelected:NO];
        [self.button2Btn setSelected:YES];
    }
    self.block_PriceCompare(@"amount", order);
}

/**
 *  销量
 */
- (IBAction)button3Clicked:(id)sender {
    if (self.button3Btn.selected) {
        [self.button3Btn setSelected:NO];
    } else {
        [self.button2Btn setSelected:NO];
        [self.button3Btn setSelected:YES];
    }
    [SVProgressHUD showErrorWithStatus:@"新功能暂未实现 。。。。"];
}
/**
 *  筛选
 */
- (IBAction)button4Clicked:(id)sender {
    _shaixuanClickedBlock();
}

@end

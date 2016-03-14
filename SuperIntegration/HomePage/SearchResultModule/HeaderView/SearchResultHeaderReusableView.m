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
    [self.button1Btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -SearchResultHeaderViewButton1TitleInsets, 0, 0)];
    [self.button2Btn setImageEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton2ImageInsets, 0, 0)];
    [self.button2Btn setTitleEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton2TitleInsets, 0, 0)];
    [self.button3Btn setImageEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton2ImageInsets, 0, 0)];
    [self.button3Btn setTitleEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton2TitleInsets, 0, 0)];
    [self.button4Btn setTitleEdgeInsets:UIEdgeInsetsMake(0, SearchResultHeaderViewButton4TitleInsets, 0, 0)];
}

- (void)setSearchResultModelArray:(NSArray *)searchResultModelArray {
    _searchResultModelArray = searchResultModelArray;
}

/**
 *  综合排序
 */
- (IBAction)button1Clicked:(id)sender {
    
}
/**
 *  价格
 */
- (IBAction)button2Clicked:(id)sender {
    if (self.button2Btn.selected) {
        [self.button2Btn setSelected:NO];
    } else {
        [self.button3Btn setSelected:NO];
        [self.button2Btn setSelected:YES];
    }

    //数组排序
    
    self.searchResultModelArray = [self.searchResultModelArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        SearchResultModel *model1 = obj1;
        SearchResultModel *model2 = obj2;
        if (self.button2Btn.selected) {//正序
            if (model1.price > model2.price) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if (model1.price < model2.price) {
                return (NSComparisonResult)NSOrderedAscending;
            }
        } else {//倒序
            if (model1.price > model2.price) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            if (model1.price < model2.price) {
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
        return (NSComparisonResult)NSOrderedSame;
        
    }];
    self.block_PriceCompare(self.searchResultModelArray);
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

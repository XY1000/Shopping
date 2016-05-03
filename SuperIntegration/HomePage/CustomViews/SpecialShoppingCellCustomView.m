//
//  SpecialShoppingCellCustomView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/13.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//



#import "SpecialShoppingCellCustomView.h"
#import "HomePageModel.h"

@implementation SpecialShoppingCellCustomView{
    //section == 1时里面各个item的起始点坐标
    CGFloat originXForSection1;
    CGFloat originYForSection1;
    
    //button的高度和宽度
    CGFloat SpecialShoppingItem0With;
    CGFloat SpecialShoppingItem1With;
    CGFloat SpecialShoppingItem2With;
}

- (void)drawWithArray:(NSArray *)Array andTheShowType:(NSInteger)theShowType {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    NSMutableArray *imageMArray = [NSMutableArray array];
    for (HomePageModel *specialModel in Array) {
        [imageMArray addObject:specialModel.appPicUrl];
    }
    
    if (Array.count < 3) {
        return;
    }
    
    if (theShowType != 3) {
        for (int i = 0; i < 5; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            if (ARRAY_IS_NIL(imageMArray)) {
                [button setBackgroundImage:[UIImage imageNamed:@"place"] forState:UIControlStateNormal];
            } else {
                [Utility yanshiWithSeconds:0.1 method:^{
                    [button sd_setBackgroundImageWithURL:[NSURL URLWithString:imageMArray[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"place"]];
                }];
            }
            HomePageModel *model = Array[i];
            button.tag = [model.detailId integerValue];
            
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (theShowType == 1) {
                if (i == 0) {
                    [button setFrame:CGRectMake(0, 0, SpecialShoppingItem0Height, SpecialShoppingItem0Height)];
                }
                if (i == 1) {
                    [button setFrame:CGRectMake(SpecialShoppingItem0Height + 1, 0, (SCREEN_WIDTH - SpecialShoppingItem0Height)/2, (SCREEN_WIDTH - SpecialShoppingItem0Height)/2)];
                }
                if (i == 2) {
                    [button setFrame:CGRectMake(SpecialShoppingItem0Height + (SCREEN_WIDTH - SpecialShoppingItem0Height)/2 + 1, 0, (SCREEN_WIDTH - SpecialShoppingItem0Height)/2, (SCREEN_WIDTH - SpecialShoppingItem0Height)/2)];
                }
                if (i == 3) {
                    [button setFrame:CGRectMake(SpecialShoppingItem0Height + 1, (SCREEN_WIDTH - SpecialShoppingItem0Height)/2 + 1, (SCREEN_WIDTH - SpecialShoppingItem0Height)/2, (SCREEN_WIDTH - SpecialShoppingItem0Height)/2)];
                }
                if (i == 4) {
                    [button setFrame:CGRectMake(SpecialShoppingItem0Height + (SCREEN_WIDTH - SpecialShoppingItem0Height)/2 + 1, (SCREEN_WIDTH - SpecialShoppingItem0Height)/2 + 1, (SCREEN_WIDTH - SpecialShoppingItem0Height)/2, (SCREEN_WIDTH - SpecialShoppingItem0Height)/2)];
                }
            }
            if (theShowType == 2) {
                if (i == 0) {
                    [button setFrame:CGRectMake(0, 0, (SpecialShoppingItem0Height - 1)/2, (SpecialShoppingItem0Height - 1)/2)];
                }
                if (i == 1) {
                    [button setFrame:CGRectMake((SpecialShoppingItem0Height - 1)/2 + 1, 0, (SpecialShoppingItem0Height - 1)/2, (SpecialShoppingItem0Height - 1)/2)];
                }
                if (i == 2) {
                    [button setFrame:CGRectMake(0, (SpecialShoppingItem0Height - 1)/2 + 1, (SpecialShoppingItem0Height - 1)/2, (SpecialShoppingItem0Height - 1)/2)];
                }
                if (i == 3) {
                    [button setFrame:CGRectMake((SpecialShoppingItem0Height - 1)/2 + 1, (SpecialShoppingItem0Height - 1)/2 + 1, (SpecialShoppingItem0Height - 1)/2, (SpecialShoppingItem0Height - 1)/2)];
                }
                if (i == 4) {
                    [button setFrame:CGRectMake(SpecialShoppingItem0Height + 1, 0, SpecialShoppingItem0Height, SpecialShoppingItem0Height)];
                }
            }
            [self addSubview:button];
        }
    }
    if (theShowType == 3) {
        
        CGFloat butWidth = (SpecialShoppingItem0Height - 1)/2;
        
        for (int i = 0; i < 8; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            if (ARRAY_IS_NIL(imageMArray)) {
                [button setBackgroundImage:[UIImage imageNamed:@"place"] forState:UIControlStateNormal];
            } else {
                [Utility yanshiWithSeconds:0.1 method:^{
                    [button sd_setBackgroundImageWithURL:[NSURL URLWithString:imageMArray[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"place"]];
                }];
            }
            HomePageModel *model = Array[i];
            button.tag = [model.detailId integerValue];
            
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            [button setFrame:CGRectMake(i%4 * (butWidth+1), i/4 * (butWidth+1), butWidth, butWidth)];
            
            [self addSubview:button];
        }
    }
    
}


- (void)buttonClicked:(UIButton *)button {
    self.buttonClicked(button.tag);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

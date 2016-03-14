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
        if (theShowType == 1) {
            SpecialShoppingItem0With = HMC_TypeOneCellWith;
        }
        if (theShowType == 2) {
            SpecialShoppingItem0With = HMC_TypeTwoCellWith;
        }
        SpecialShoppingItem1With = SCREEN_WIDTH - SpecialShoppingItem0With - 1;
        SpecialShoppingItem2With = (SpecialShoppingItem1With - 1) / 2;
        
        for (int i = 0; i < 4; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            if (ARRAY_IS_NIL(imageMArray)) {
                [button setBackgroundImage:[UIImage imageNamed:@"place"] forState:UIControlStateNormal];
            } else {
                [button sd_setBackgroundImageWithURL:[NSURL URLWithString:imageMArray[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"place"]];
                
            }
            [button setBackgroundColor:[UIColor whiteColor]];
            
            HomePageModel *model = Array[i];
            button.tag = [model.detailId integerValue];
            
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            //重新定位cell的位置
            if (i == 0) {
                [button setFrame:CGRectMake(0, 0, SpecialShoppingItem0With, SpecialShoppingItem0Height)];
                originYForSection1 = button.frame.origin.y;
                originXForSection1 = button.frame.size.width;
            } else if (i == 1) {
                [button setFrame:CGRectMake(originXForSection1 + 1, originYForSection1, SpecialShoppingItem1With, SpecialShoppingItem1Height)];
                originYForSection1 = button.frame.origin.y + button.frame.size.height;
            } else if (i == 2) {
                [button setFrame:CGRectMake(originXForSection1 + 1, originYForSection1 + 1, SpecialShoppingItem2With, SpecialShoppingItem2Height)];
                originXForSection1 = button.frame.origin.x + button.frame.size.width;
            } else {
                [button setFrame:CGRectMake(originXForSection1 + 1, originYForSection1 + 1, SpecialShoppingItem2With, SpecialShoppingItem2Height)];
            }
            [self addSubview:button];
        }
        
    }
    
    if (theShowType == 3) {
        SpecialShoppingItem1With = HMC_TypeThreeCellWith;
        SpecialShoppingItem0With = (SCREEN_WIDTH - SpecialShoppingItem1With) / 2;
        SpecialShoppingItem2With = SpecialShoppingItem0With;
        
        for (int i = 0; i < 3; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            if (ARRAY_IS_NIL(imageMArray)) {
                [button setBackgroundImage:[UIImage imageNamed:@"place"] forState:UIControlStateNormal];
            } else {
                [button sd_setBackgroundImageWithURL:[NSURL URLWithString:imageMArray[i]] forState:UIControlStateNormal];
            }
            [button setBackgroundColor:[UIColor whiteColor]];
            
            HomePageModel *model = Array[i];
            button.tag = [model.detailId integerValue];
            
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            //重新定位cell的位置
            if (i == 0) {
                [button setFrame:CGRectMake(0, 0, SpecialShoppingItem0With, SpecialShoppingItem0Height)];
                originXForSection1 = button.frame.size.width;
            } else if (i == 1) {
                [button setFrame:CGRectMake(originXForSection1, 0, SpecialShoppingItem1With, SpecialShoppingItem0Height)];
                originXForSection1 = button.frame.origin.x + button.frame.size.width;
            } else if (i == 2) {
                [button setFrame:CGRectMake(originXForSection1, 0, SpecialShoppingItem2With, SpecialShoppingItem0Height)];
            }
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

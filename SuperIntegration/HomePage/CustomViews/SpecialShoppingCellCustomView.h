//
//  SpecialShoppingCellCustomView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/13.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialShoppingCellCustomView : UIView
- (void)drawWithArray:(NSArray *)Array andTheShowType:(NSInteger)theShowType;
@property (copy, nonatomic) void(^buttonClicked)(NSInteger detailId);
@end

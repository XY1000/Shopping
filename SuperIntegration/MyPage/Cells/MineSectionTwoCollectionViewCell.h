//
//  MineSectionTwoCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineSectionTwoCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) void(^zhifubaoClickedBlock)();
@property (copy, nonatomic) void(^hebaoClickedBlock)();
@property (copy, nonatomic) void(^integralExchangeClickedBlock)();
@property (copy, nonatomic) void(^transactionClickedBlock)();

@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@end

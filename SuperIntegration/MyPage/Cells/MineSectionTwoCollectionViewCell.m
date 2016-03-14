//
//  MineSectionTwoCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "MineSectionTwoCollectionViewCell.h"

@interface MineSectionTwoCollectionViewCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *button1ToLeftLayoutConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *button1WidthLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *button2WidthLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *button3WidthLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *button4WidthLayoutConstraint;


@end

@implementation MineSectionTwoCollectionViewCell

- (void)awakeFromNib {
    [self.button1ToLeftLayoutConstraint setConstant:MineSectionTwoCellButton1ToLeftValue];
    
    [self.button1WidthLayoutConstraint setConstant:MineSectionTwoCellButton1Width];
    [self.button2WidthLayoutConstraint setConstant:MineSectionTwoCellButton2Width];
    [self.button3WidthLayoutConstraint setConstant:MineSectionTwoCellButton3Width];
    [self.button4WidthLayoutConstraint setConstant:MineSectionTwoCellButton4Width];
}

//支付宝充值
- (IBAction)zhifubaoClicked:(id)sender {
    self.zhifubaoClickedBlock();
}
//和包充值
- (IBAction)hebaoClicked:(id)sender {
    self.hebaoClickedBlock();
}
//积分兑换
- (IBAction)IntegralExchangeClicked:(id)sender {
    self.integralExchangeClickedBlock();
}
//转账
- (IBAction)transactionClicked:(id)sender {
    self.transactionClickedBlock();
}


@end

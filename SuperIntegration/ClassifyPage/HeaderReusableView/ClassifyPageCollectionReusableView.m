//
//  ClassifyPageCollectionReusableView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/20.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ClassifyPageCollectionReusableView.h"

@interface ClassifyPageCollectionReusableView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelToLeftLayoutConstraint;


@end

@implementation ClassifyPageCollectionReusableView

- (void)awakeFromNib {
    [self.titleLabelToLeftLayoutConstraint setConstant:ClassifyPageCollectionViewCellMinimumInteritem];
}

@end

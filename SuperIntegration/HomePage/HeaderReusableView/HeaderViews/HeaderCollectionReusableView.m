//
//  HeaderCollectionReusableView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/12.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "HeaderCollectionReusableView.h"

@interface HeaderCollectionReusableView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BackViewToReusableViewHeightLayoutConstraint;
@end

@implementation HeaderCollectionReusableView

- (void)awakeFromNib {
    [self.BackViewToReusableViewHeightLayoutConstraint setConstant:BackViewHeight];
}

@end

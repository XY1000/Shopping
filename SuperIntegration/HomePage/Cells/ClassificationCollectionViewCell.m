//
//  ClassificationCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/12.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ClassificationCollectionViewCell.h"

@interface ClassificationCollectionViewCell()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightLayoutConstraint;

@end

@implementation ClassificationCollectionViewCell

- (void)awakeFromNib {
    CGFloat imageHeight = ClassificationHeight / 2;
    [self.imageViewHeightLayoutConstraint setConstant:imageHeight];
}

- (void)cellWithImage:(NSString *)Image title:(NSString *)Title {
    self.classificationLabel.text = Title;
    self.classificationImageView.image = [UIImage imageNamed:Image];
    [self.classificationImageView annimation_RotateView:self.classificationImageView duration:1 degrees:180.0 x:0 y:0 z:1 repeatCount:1];
}

@end

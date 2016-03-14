//
//  SectionThreeCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/13.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "SectionThreeCollectionViewCell.h"

@interface SectionThreeCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SectionThreeCollectionViewCell

- (void)cellWithImageString:(NSString *)imageString {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"place"]];
}

@end

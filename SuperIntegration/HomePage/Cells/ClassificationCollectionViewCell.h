//
//  ClassificationCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/12.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassificationCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *classificationImageView;
@property (weak, nonatomic) IBOutlet UILabel *classificationLabel;

- (void)cellWithImage:(NSString *)Image title:(NSString *)Title;
@end

//
//  PostImageView.h
//  iPolice
//
//  Created by PP－mac001 on 15/10/14.
//  Copyright (c) 2015年 Bert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostImageView : NSObject
+ (instancetype) sharedPostImageView;
- (void)createActionSheetViewWithViewController:(UIViewController *)viewController title:(NSString *)title andMethod:(void (^)(UIImage *image, NSString *imagePath, NSData *imageData))method;
@end

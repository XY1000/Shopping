//
//  UIImage+ImageCornerRadius.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/3.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "UIImage+ImageCornerRadius.h"

@implementation UIImage (ImageCornerRadius)

- (UIImage *)image_CornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end

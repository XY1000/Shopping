//
//  CALayer+BorderLayer.m
//  SuperIntegration
//
//  Created by Bert on 1/25/16.
//  Copyright © 2016 PP－mac001. All rights reserved.
//

#import "CALayer+BorderLayer.h"

@implementation CALayer (BorderLayer)
-(void)setBorderUIColor:(UIColor *)borderColor{
    [self setBorderColor:borderColor.CGColor];
}
@end

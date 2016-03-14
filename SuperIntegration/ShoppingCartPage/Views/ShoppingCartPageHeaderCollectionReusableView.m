//
//  ShoppingCartPageHeaderCollectionReusableView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/3.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ShoppingCartPageHeaderCollectionReusableView.h"

@interface ShoppingCartPageHeaderCollectionReusableView()

@end


@implementation ShoppingCartPageHeaderCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)freeOfChargeClicked:(id)sender {
    self.freeOfChargeClickedBlock();
}



@end

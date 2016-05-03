//
//  ProductDetailPageBottomView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ProductDetailPageBottomView.h"

@interface ProductDetailPageBottomView()



@end

@implementation ProductDetailPageBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)shoppingCartClicked:(id)sender {
    self.shoppingCartClickedBlock();
}

- (IBAction)favoriteClicked:(id)sender {
    self.favoriteClickedBlock();
}

- (IBAction)customServiceClicked:(id)sender {
    self.customServiceClickedBlock();
}

- (IBAction)goBuyClicked:(id)sender {
    self.btn_GoBuy.userInteractionEnabled = NO;
    self.goBuyClickedBlock();
}

- (IBAction)addShoppingCartClicked:(id)sender {
    self.addShoppingCartButton.userInteractionEnabled = NO;
    self.addShoppingCartClickedBlock();
}

@end

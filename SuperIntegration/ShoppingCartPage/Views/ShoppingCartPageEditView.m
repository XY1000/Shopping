//
//  ShoppingCartPageEditView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/1.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ShoppingCartPageEditView.h"
#import "ShoppingCartPageModel.h"

@interface ShoppingCartPageEditView()



@end

@implementation ShoppingCartPageEditView

- (void)awakeFromNib {
    [self.allButton setSelected:YES];
}

- (IBAction)deleteClicked:(id)sender {
    self.deleteClickedBlock();
}

- (IBAction)allClicked:(id)sender {
    if (self.allButton.selected) {
        [self.allButton setSelected:NO];
    } else {
        [self.allButton setSelected:YES];
    }
    self.allSelectedClickedBlock(self.allButton.selected);
}
@end

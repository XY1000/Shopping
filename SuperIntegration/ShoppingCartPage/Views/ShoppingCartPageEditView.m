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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_ButtonWidth;

@end

@implementation ShoppingCartPageEditView

- (void)awakeFromNib {
    [self.allButton setSelected:YES];
    self.layout_ButtonWidth.constant = SCREEN_WIDTH * 100 / 375;
}

- (IBAction)deleteClicked:(id)sender {
    self.deleteClickedBlock();
}

- (IBAction)allClicked:(id)sender {
    if (self.allButton.selected) {
        [self.allButton setSelected:NO];
        self.deleteButton.userInteractionEnabled = NO;
        self.deleteButton.backgroundColor = [UIColor lightGrayColor];
    } else {
        [self.allButton setSelected:YES];
        self.deleteButton.userInteractionEnabled = YES;
        self.deleteButton.backgroundColor = RGB(204, 10, 42);
    }
    self.allSelectedClickedBlock(self.allButton.selected);
}
@end

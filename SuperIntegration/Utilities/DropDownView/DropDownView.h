//
//  DropDownView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/8.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *label_Title;
- (void)cellWithTxt:(NSString *)txt;

@end

@interface DropDownView : UIView <UITableViewDelegate, UITableViewDataSource>

-(void)hideDropDown:(UIButton *)Button;
- (void)showDropDown:(UIButton *)Button height:(CGFloat)Height array:(NSArray *)Array;

@property (copy, nonatomic) void(^block_DidSelect)(NSString *sex);
@end



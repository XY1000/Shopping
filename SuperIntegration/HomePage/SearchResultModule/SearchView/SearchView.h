//
//  SearchView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

@property (weak, nonatomic) IBOutlet UITextField *textField;
//点击取消
@property (copy, nonatomic) void(^searchViewCancelClickedBlock)();
//点击return
@property (copy, nonatomic) void(^searchViewReturnClickedBlock)(NSInteger keyWordsCateforyId, NSString *keyWords);

@end

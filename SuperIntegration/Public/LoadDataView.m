//
//  LoadDataView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/5.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "LoadDataView.h"

@interface LoadDataView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView_Load;
@property (weak, nonatomic) IBOutlet UILabel *label_Load;
@property (weak, nonatomic) IBOutlet UIButton *btn_Refresh;


@end

@implementation LoadDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    self.btn_Refresh.hidden = YES;
}

- (void)setFrame:(CGRect)frame {
    super.frame = frame;
    [self.imageView_Load annimation_RotateView:self.imageView_Load duration:1.0 degrees:45.0 x:0 y:0 z:1 repeatCount:HUGE_VALF];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadError:) name:@"loadError" object:nil];
}

- (IBAction)btn_RefreshClicked:(id)sender {
    self.label_Load.text = @"小分正在努力加载...";
    [self.imageView_Load annimation_RotateView:self.imageView_Load duration:1.0 degrees:45.0 x:0 y:0 z:1 repeatCount:HUGE_VALF];
    self.block_LoadDataView_Refresh();
}

/**
 *  加载异常
 */
- (void)loadError:(NSNotification *)Noti {
    NSLog(@"%@", Noti.userInfo);
    [self.imageView_Load annimation_RemoveView:self.imageView_Load key:@"transform"];
    self.btn_Refresh.hidden = NO;
    [self.btn_Refresh annimation_SpringView:self.btn_Refresh duration:1.0 fromValue:0 toValue:1];
    self.label_Load.text = Noti.userInfo[@"errmsg"];
}
/**
 *  加载完成
 */
- (void)loadComplete {
    [self annimation_ScaleView:self duration:1.0 fromValue:1 toValue:0];
    [Utility yanshiWithSeconds:1.0 method:^{
        [self removeFromSuperview];
    }];
}

- (void)dealloc {
    [self removeFromSuperview];
    [self removeObserver:self forKeyPath:@"loadError"];
}
@end

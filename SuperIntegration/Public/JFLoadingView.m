//
//  JFLoadingView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/16.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "JFLoadingView.h"

@interface JFLoadingView()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (assign, nonatomic) double add;
@property (strong, nonatomic) dispatch_source_t Loading_timer;

@end

@implementation JFLoadingView

+ (JFLoadingView *)sharedView {
    static dispatch_once_t once;
    static JFLoadingView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}

+ (void)createProgressShapeLayer {
    //创建出CAShapeLayer
    [self sharedView].shapeLayer = [CAShapeLayer layer];
    [self sharedView].shapeLayer.frame = CGRectMake(0, 0, 50, 50);//设置shapeLayer的尺寸和位置
    [self sharedView].shapeLayer.position = [self sharedView].center;
    [self sharedView].shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    [self sharedView].shapeLayer.lineWidth = 3.0f;
    [self sharedView].shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 50, 50)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    [self sharedView].shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [[self sharedView].layer addSublayer:[self sharedView].shapeLayer];
    
}

- (void)drawImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageView.layer.position = self.center;
    imageView.image = [UIImage imageNamed:@"无网络_03"];
    [self addSubview:imageView];
}

- (void)createTimer{
    self.add = 0.1;//每次递增0.1
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0.7;
    //用定时器模拟数值输入的情况
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.Loading_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(self.Loading_timer, dispatch_walltime(NULL, 0), 0.1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.Loading_timer, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeStart < 1) {
                self.shapeLayer.strokeStart += self.add;
            }else if(self.shapeLayer.strokeStart == 0){
                self.shapeLayer.strokeEnd += self.add;
            }
            
            if (self.shapeLayer.strokeEnd == 0) {
                self.shapeLayer.strokeStart = 0;
            }
            
            if (self.shapeLayer.strokeStart == self.shapeLayer.strokeEnd) {
                self.shapeLayer.strokeEnd = 0;
            }
            
        });
    });
    dispatch_resume(self.Loading_timer);
}


+ (void)JF_Loading {
    [self sharedView].backgroundColor = [UIColor clearColor];
    [self sharedView].alpha = 0.5;
    
    [self createProgressShapeLayer];
    [[self sharedView] drawImage];
    [[self sharedView] createTimer];
    
    if(![self sharedView].superview){
#if !defined(SV_APP_EXTENSIONS)
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows){
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                [window addSubview:[self sharedView]];
                break;
            }
        }
#else
        
#endif
    } else {
        // Ensure that overlay will be exactly on top of rootViewController (which may be changed during runtime).
        [[self sharedView].superview bringSubviewToFront:[self sharedView]];
    }
}

+ (void)JF_LoadSuccess {
    [Utility yanshiWithSeconds:0.5 method:^{
        dispatch_source_cancel([self sharedView].Loading_timer);
        [self sharedView].Loading_timer = nil;
        if ([self sharedView].superview) {
            [[self sharedView].shapeLayer removeFromSuperlayer];
            [[self sharedView] removeFromSuperview];
        }
    }];
}

@end

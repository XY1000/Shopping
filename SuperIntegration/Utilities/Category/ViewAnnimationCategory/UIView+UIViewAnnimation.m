//
//  UIView+UIViewAnnimation.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/3.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "UIView+UIViewAnnimation.h"

@implementation UIView (UIViewAnnimation)

- (void)annimation_RotateView:(UIView *)View duration:(CFTimeInterval)Duration degrees:(CGFloat)Degrees x:(NSInteger)X y:(NSInteger)Y z:(NSInteger)Z repeatCount:(NSInteger)RepeatCount {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.duration = Duration;
        
        // Z轴旋转180度
        CATransform3D transform3d = CATransform3DMakeRotation((Degrees * 3.14159265) / 180.0, X, Y, Z);
        animation.toValue = [NSValue valueWithCATransform3D:transform3d];
        
        animation.cumulative = YES;
        animation.removedOnCompletion = NO;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.repeatCount = RepeatCount;
        animation.autoreverses = YES;
        animation.fillMode = kCAFillModeForwards;
        
        [View.layer addAnimation:animation forKey:@"transform"];
}


- (void)annimation_TranslationView:(UIView *)View duration:(CFTimeInterval)Duration pointX:(CGFloat)PointX pointY:(CGFloat)PointY {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.duration = Duration;
    
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(PointX, PointY)];
    
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //默认的是 0,意味着动画只会播放一次。如果指定一个无限大的重复次数,使用 1e100f。这个不应该和 repeatDration 属性一块使用。
    animation.repeatCount = HUGE_VALF;
    //当你设定这个属性为 YES 时,在它到达目的地之后,动画的返回到开始的值,代替了直接跳转到 开始的值。
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [View.layer addAnimation:animation forKey:@"transform.translation"];
}

- (void)annimation_ScaleView:(UIView *)View duration:(CFTimeInterval)Duration fromValue:(NSInteger)FromValue toValue:(NSInteger)ToValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = Duration;
    animation.fromValue = @(FromValue);
    animation.toValue = @(ToValue);
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = 1;
    // 默认为NO，设置为YES后，在动画达到toValue点时，就会以动画由toValue返回到fromValue点。
    // 如果不设置或设置为NO，在动画到达toValue时，就会突然马上返回到fromValue点
    animation.autoreverses = NO;
    // 当autoreverses设置为NO时，最终会留在toValue处
    animation.fillMode = kCAFillModeForwards;
    
    [View.layer addAnimation:animation forKey:@"transform.scale"];
}


- (void)annimation_SpringView:(UIView *)View duration:(CFTimeInterval)Duration fromValue:(NSInteger)FromValue toValue:(NSInteger)ToValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = Duration;
    animation.fromValue = @(FromValue);
    animation.toValue = @(ToValue);
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = 1;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [View.layer addAnimation:animation forKey:@"opacity"];
}

- (void)annimation_LineView:(UIView *)View duration:(CFTimeInterval)Duration fromValue:(CGPoint)FromValue toValue:(CGPoint)ToValue {
    // 添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 起点，这个值是指position，也就是layer的中心值
    animation.fromValue = [NSValue valueWithCGPoint:FromValue];
    // 终点，这个值是指position，也就是layer的中心值
    animation.toValue = [NSValue valueWithCGPoint:ToValue];
    // byValue与toValue的区别：byValue是指x方向再移动到指定的宽然后y方向移动指定的高
    // 而toValue是整体移动到指定的点
    //  animation.byValue = [NSValue valueWithCGPoint:CGPointMake(self.view.bounds.size.width - 50 - 50,
    //                                                            self.view.bounds.size.height - 50 - 50 - 50)];
    // 线性动画
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = NO;
    
    // 设定开始值到结束值花费的时间，也就是动画时长，单位为秒
    animation.duration = Duration;
    
    // 播放速率，默认为1，表示常速
    // 设置为2则以2倍的速度播放，同样设置为N则以N倍速度播放
    // 如果值小于1，自然就是慢放
    animation.speed = 0.5;
    
    // 开始播放动画的时间，默认为0.0，通常是在组合动画中使用
    animation.beginTime = 0.0;
    
    // 播放动画的次数，默认为0，表示只播放一次
    // 设置为3表示播放3次
    // 设置为HUGE_VALF表示无限动画次数
    animation.repeatCount = HUGE_VALF;
    
    // 默认为NO，设置为YES后，在动画达到toValue点时，就会以动画由toValue返回到fromValue点。
    // 如果不设置或设置为NO，在动画到达toValue时，就会突然马上返回到fromValue点
    animation.autoreverses = YES;
    
    // 当autoreverses设置为NO时，最终会留在toValue处
    animation.fillMode = kCAFillModeForwards;
    // 将动画添加到层中
    [View.layer addAnimation:animation forKey:@"position"];
}

- (void)annimation_MixView:(UIView *)View duration:(CFTimeInterval)Duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D rotateTransform = CATransform3DMakeRotation(1.57, 0, 0, -1);
    CATransform3D scaleTransform = CATransform3DMakeScale(5, 5, 5);
    CATransform3D positionTransform = CATransform3DMakeTranslation(0, 0, 0); //位置移动
    CATransform3D combinedTransform =CATransform3DConcat(rotateTransform, scaleTransform); //Concat就是combine的意思
    combinedTransform = CATransform3DConcat(combinedTransform, positionTransform); //再combine一次把三个动作连起来
    
    [animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]]; //放在3D坐标系中最正的位置
    [animation setToValue:[NSValue valueWithCATransform3D:combinedTransform]];
    [animation setDuration:5.0f];
    
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [View.layer addAnimation:animation forKey:nil];
}

- (void)annimation_RemoveView:(UIView *)View key:(NSString *)Key {
    [View.layer removeAnimationForKey:Key];
}

- (void)annimation_ChangeFrameView:(UIView *)View duration:(CFTimeInterval)Duration frame:(CGRect)Frame {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:Duration];
    [UIView setAnimationDelegate:self];
    View.frame = Frame;
    [UIView commitAnimations];
}
@end

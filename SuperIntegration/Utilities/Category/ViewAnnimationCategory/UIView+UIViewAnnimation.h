//
//  UIView+UIViewAnnimation.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/3.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewAnnimation)

/**
 *  view旋转
 *
 *  @param View     view
 *  @param Duration 时间
 *  @param Degrees  旋转度数
 *  @param X        以x为轴
 *  @param Y        以y为轴
 *  @param Z        以z为轴
 */
- (void)annimation_RotateView:(UIView *)View duration:(CFTimeInterval)Duration degrees:(CGFloat)Degrees x:(NSInteger)X y:(NSInteger)Y z:(NSInteger)Z repeatCount:(NSInteger)RepeatCount;


/**
 *  view移动
 *
 *  @param View     view
 *  @param Duration 时间
 *  @param PointX   平移到的x点
 *  @param PointY   平移到的y点
 */
- (void)annimation_TranslationView:(UIView *)View duration:(CFTimeInterval)Duration pointX:(CGFloat)PointX pointY:(CGFloat)PointY;

/**
 *  view缩放
 *
 *  @param View      view
 *  @param Duration  时间
 *  @param FromValue 开始值
 *  @param ToValue   结束值
 */
- (void)annimation_ScaleView:(UIView *)View duration:(CFTimeInterval)Duration fromValue:(NSInteger)FromValue toValue:(NSInteger)ToValue;

/**
 *  view闪烁
 *
 *  @param View      view
 *  @param Duration  时间
 *  @param FromValue 开始值
 *  @param ToValue   结束值
 */
- (void)annimation_SpringView:(UIView *)View duration:(CFTimeInterval)Duration fromValue:(NSInteger)FromValue toValue:(NSInteger)ToValue;

/**
 *  view路径动画
 *
 *  @param View      view
 *  @param Duration  时间
 *  @param FromValue 开始值
 *  @param ToValue   结束值
 */
- (void)annimation_LineView:(UIView *)View duration:(CFTimeInterval)Duration fromValue:(CGPoint)FromValue toValue:(CGPoint)ToValue;

/**
 *  view混合动画
 *
 *  @param View     view
 *  @param Duration 时间
 */
- (void)annimation_MixView:(UIView *)View duration:(CFTimeInterval)Duration;

- (void)annimation_RemoveView:(UIView *)View key:(NSString *)Key;

/**
 *  改变view的frame动画
 *
 *  @param View     view
 *  @param Duration 时间
 *  @param Frame    新的frame 
 */
- (void)annimation_ChangeFrameView:(UIView *)View duration:(CFTimeInterval)Duration frame:(CGRect)Frame;
@end

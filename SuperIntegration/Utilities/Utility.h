//
//  Utility.h
//  MeridianStreamer
//
//  Created by PP－mac001 on 15/9/9.
//  Copyright (c) 2015年 PP－mac001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

#pragma mark 正则表达式
/**
 *  检查用户的身份证号码
 */
+ (BOOL)checkUserIdCard:(NSString *)idCard;
/**
 *  正则匹配用户姓名,20位的中文或英文
 */
+ (BOOL)checkUserName:(NSString *)userName;
/**
 *  电话号码
 */
+ (BOOL)checkUserTelNumber:(NSString *)telNumber;
/**
 *  邮箱
 */
+ (BOOL)validateEmail:(NSString *)email;
/**
 *  6-20位字母数字密码
 */
+ (BOOL)evaluateWithPassword:(NSString *)password;

/**
 *  16进制颜色转换为UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
/**
 *  创建时间与当前时间的差值
 */
+ (CGFloat)intervalTimeWithCreatetime:(NSString *)createtime;
/**
 *  时间戳转时间
 */
+ (NSString *)timeWithString:(NSString *)string andType:(NSString *)type;
/**
 *  拨打电话
 *
 *  @param phoneNo 电话号码
 *  @param view 显示窗体
 */
+ (void)callPhone:(NSString *)phoneNo view:(UIView *)view;
/**
 *  根据内容字体大小和宽度返回内容的高度
 */
+ (CGFloat)contentHeightWithSize:(CGFloat)size width:(CGFloat)width string:(NSString *)string;

+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

+ (float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;

/**
 *  字符串分割
 *
 *  @param string 源字符串
 *  @param fuhao  分割符号
 *
 *  @return 分割后的数组
 */
+ (NSArray *)arrayWithString:(NSString *)string andFuhao:(NSString *)fuhao;
/**
 *  方法 延时执行
 */
+ (void)yanshiWithSeconds:(CGFloat)seconds method:(void(^)(void))method;
/**
 *  alertView弹出动画
 */
+ (void)popAnimationAlertViewWithView:(UIView *)view;
/**
 *  tableViewCell出现动画
 */
+ (void)animationForTableViewCell:(UITableViewCell *)cell;
/**
 *  tableView消除多余的分割线
 */
+ (void)setTableFooterViewZero:(UITableView *)tableView;
/**
 *  view淡入淡出
 */
+ (void)annimationWithView:(UIView *)view;
/**
 *  popView动画
 */
+ (void)popAnnimationWithView:(UIView *)view;
/**
 *  纯色生成图片
 */
+ (UIImage *)buttonImageFromColor:(UIColor *)color;
/**
 *  改变图片的alpha值
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;
/**
 *  去除view的粘性
 */
+ (void)removeNianxingWithScrollView:(UIScrollView *)scrollView SectionHeaderHeight:(NSInteger)headerHeight SectionFooterHeight:(NSInteger)footerHeight;
/**
 *  计算缓存
 */
+ (float ) folderSizeAtPath:(NSString*) folderPath;
/**
 *  清除缓存
 */
+ (void)releaseCache;
/**
 *  textField字距左边距
 *
 *  @param textField textField
 *  @param leftWidth 距离
 */
+(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth;
@end

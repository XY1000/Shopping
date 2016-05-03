//
//  LeftSlipEditView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/4/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "LeftSlipEditView.h"
#import "Masonry.h"

@interface LeftSlipEditView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
//起始右侧约束值
@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;
//右侧约束值
@property (nonatomic, assign)  CGFloat contentViewRightConstraint;
//左侧约束值
@property (nonatomic, assign)  CGFloat contentViewLeftConstraint;

@end

@implementation LeftSlipEditView

{
    BOOL _isChanged;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIButton *btn_RightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_RightBtn.backgroundColor = RGB(204, 10, 42);
        [btn_RightBtn setTitle:@"加购物车" forState:UIControlStateNormal];
        [self addSubview:btn_RightBtn];
        [btn_RightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(0);
            make.top.equalTo(self).with.offset(0);
            make.bottom.equalTo(self).with.offset(0);
            make.width.mas_equalTo(40);
        }];
        [btn_RightBtn addTarget:self action:@selector(btn_RightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.button1 = btn_RightBtn;
        
        UIButton *btn_LeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_LeftBtn.backgroundColor = RGB(191, 191, 191);
        [btn_LeftBtn setTitle:@"移入关注" forState:UIControlStateNormal];
        [btn_LeftBtn setTitle:@"已关注" forState:UIControlStateSelected];
        [self addSubview:btn_LeftBtn];
        [btn_LeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn_RightBtn.mas_left).with.offset(0);
            make.top.equalTo(self).with.offset(0);
            make.bottom.equalTo(self).with.offset(0);
            make.width.mas_equalTo(40);
            
        }];
        [btn_LeftBtn addTarget:self action:@selector(btn_LeftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.button2 = btn_LeftBtn;
        
        UIView *view_ContentView = [[UIView alloc] init];
        view_ContentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:view_ContentView];
        [view_ContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            make.top.equalTo(self).with.offset(0);
            make.bottom.equalTo(self).with.offset(0);
        }];
        
        self.myContentView = view_ContentView;
        
        self.button1.titleLabel.numberOfLines = 0;
        self.button2.titleLabel.numberOfLines = 0;
        _isChanged = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isChanged:) name:@"isChanged" object:nil];
    }
    return self;
}

- (void)isChanged:(NSNotification *)noti {
    _isChanged = [noti.userInfo[@"isChanged"] boolValue];
}

//是否添加手势
- (void)setIsPan:(BOOL)isPan {
    _isPan = isPan;
    if (_isPan) {
        self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
        self.panRecognizer.delegate = self;
        [self.myContentView addGestureRecognizer:self.panRecognizer];
    }
}

- (void)btn_RightBtnClicked:(UIButton*)sender {
    if ([self.PublicDelegate respondsToSelector:@selector(addShopping:)]) {
        UICollectionViewCell *cell = (UICollectionViewCell *)self.superview.superview;
        [self.PublicDelegate addShopping:cell];
    }
}
- (void)btn_LeftBtnClicked:(UIButton*)sender {
    if ([self.PublicDelegate respondsToSelector:@selector(addFavorite:isFavorite:)]) {
        UICollectionViewCell *cell = (UICollectionViewCell *)self.superview.superview;
        [self.PublicDelegate addFavorite:cell isFavorite:self.button2.selected];
    }
}

/**
 *  新增左滑
 */
- (void)panThisCell:(UIPanGestureRecognizer *)recognizer {
    if ([recognizer isEqual:self.panRecognizer]) {
        switch (recognizer.state) {
            case UIGestureRecognizerStateBegan:{
                self.panStartPoint = [recognizer translationInView:self.myContentView];
                self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint;
                //            NSLog(@"Pan Began at %@", NSStringFromCGPoint(self.panStartPoint));
            }
                break;
            case UIGestureRecognizerStateChanged: {
            
                if (!_isChanged) {
                    return;
                }
                
                CGPoint currentPoint = [recognizer translationInView:self.myContentView];
                CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
                //            NSLog(@"Pan Moved %f", deltaX);
                
                BOOL panningLeft = NO;
                if (currentPoint.x < self.panStartPoint.x) {
                    //1 判断手势是往左还是往右
                    panningLeft = YES;
                }
                
                if (self.startingRightLayoutConstraintConstant == 0) {
                    //2如果右约束常量为 0 ，意味着 myContentView 完全挡住 contentView 。因此 Cell 在这里一定已经关闭，而用户准备打开它。
                    if (!panningLeft) {//右滑
                        CGFloat constant = MAX(-deltaX, 0);
                        //3这是处理用户从做到右滑动以关闭 Cell 的 情况。除了说“你不能做那个”之外，你还要处理的情况是，当用户滑动 Cell 只打开一点点，然后他们希望不必抬起他们的手指来结束此手势就可以滑动它关闭。译者注：就是说，打开一点点不会完全显示出后面的按钮，Cell 会自动关闭。因为一个从左到右的滑动会导致 deltaX 为正值，而从右到左的滑动回到导致 deltaX 为负值，你必须根据负的 deltaX 计算出常量以设置到右约束上。因为是从它与0中找出最大值，所以视图不可能往右边走多远。
                        if (constant == 0) {
                            //4如果常量为 0，Cell 就是完全关闭的。调用处理关闭的方法——它（如你回忆起的）在目前还什么也不会做。
                            [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
                        } else {
                            //5如果常量为不为 0，那么你就将其设置到右手边的约束上。
                            self.contentViewRightConstraint = constant;
                        }
                    } else {//左滑
                        CGFloat constant = MIN(-deltaX, [self buttonTotalWidth]);
                        //6否者，如果是从右往做滑动，那么用户试图打开 Cell 。这在个情况里，常量将会小于负deltaX或两个按钮的宽度之和
                        if (constant == [self buttonTotalWidth]) {
                            //7如果目标常量是两个按钮的宽度之和，那么 Cell 就被打开至捕捉点（catch point），你应该调用方法来处理这个打开状态。
                            [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];
                        } else {
                            //8如果常量不是两个按钮的宽度之和，那就将其设置到右约束上。
                            self.contentViewRightConstraint = constant;
                        }
                    }
                } else {
                    
                    CGFloat adjustment = self.startingRightLayoutConstraintConstant - deltaX;
                    //1在这个情况下，你只是接受 deltaX ，你就用 rightLayoutConstraint 的原始位置减去 deltaX 以便得知要做多少调整。
                    if (!panningLeft) {//右滑
                        CGFloat constant = MAX(adjustment, 0);
                        //2如果用户从做往右滑动，你必须接受 adjustment 与 0 中的较大值。如果 adjustment 已变成负值，那就说明用户已经把 Cell 滑到边界之外了，Cell 就关闭了，这就让你进入下一个情况。
                        if (constant == 0) {
                            //3如果常量为 0，那么 Cell 已经关闭，你就调用处理其关闭的方法。
                            [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
                        } else {
                            //4否则，将常量设置到右约束上
                            self.contentViewRightConstraint = constant;
                        }
                    } else {//左滑
                        CGFloat constant = MIN(adjustment, [self buttonTotalWidth]);
                        //5对于从右到左的滑动，你将接受 adjustment 与 两个按钮宽度之和 中的较小值。如果 adjustment 更大，那就表示用户已经滑出超过捕捉点了。
                        if (constant == [self buttonTotalWidth]) {
                            //6如果常量刚好等于两个按钮宽度之和，那么 Cell 就打开了，你必须调用处理 Cell 打开的方法。
                            [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];
                        } else {
                            //7否则，将常量设置到右约束上。
                            self.contentViewRightConstraint = constant;
                        }
                    }
                }
                self.contentViewLeftConstraint = -self.contentViewRightConstraint;
                [self.myContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).with.offset(0);
                    make.right.equalTo(self).with.offset(-self.contentViewRightConstraint);
                    make.top.equalTo(self).with.offset(0);
                    make.bottom.equalTo(self).with.offset(0);
                }];
                //8现在，你已经处理完“Cell关闭”和“Cell部分开启”的情况，在这两个情况里，你都可对左约束做同样的事情：将其设置为右约束常量的负值。这就保证了 myContentView 的宽度一直保持不变。
            }
                break;
            case UIGestureRecognizerStateEnded:{
                //            NSLog(@"Pan Ended");
                if (self.startingRightLayoutConstraintConstant == 0) {
                    //1通过检查开始右约束值，得知手势开始时 Cell 是否已经打开或关闭。
                    
                    //Cell was opening
                    CGFloat halfOfButtonOne = CGRectGetWidth(self.button1.frame) * 2 / 3;
                    //2如果 Cell 是关闭的，那你就正在打开它，你要让 Cell 自动滑动到打开，至少需要先滑动右边按钮(self.button1)一半的宽度。因为你在测量约束的常量，你只需要计算实际的按钮宽度，而不是它在视图中的 X 位置。
                    if (self.contentViewRightConstraint >= halfOfButtonOne) {
                        //3接下来，测试约束是否已被打开至超过你希望让 Cell 自动打开的点。如果已经超过，那就自动打开 Cell。如果没有，那就自动关闭 Cell。
                        
                        //Open all the way
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                    } else {
                        
                        //Re-close
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                    }
                } else {
                    
                    //Cell was closing
                    CGFloat buttonOnePlusHalfOfButton2 = CGRectGetWidth(self.button1.frame) + (CGRectGetWidth(self.button2.frame) / 2);
                    //4此处表示 Cell 从打开的状态开始，你需要那个能让 Cell 自动 snap 关闭的点，至少需要超过最左边按钮的一半。 将不是最左边的按钮的那些按钮的宽度加起来，在这个情况里，只有 self.button1 而已，再加上最左边按钮的一半——也就是 self.button2 —— 以便找到需要的检查点。
                    if (self.contentViewRightConstraint >= buttonOnePlusHalfOfButton2) {
                        //5测试约束是否以及超过这个点，即你希望 Cell 自动关闭的那个点。如果超过了，关闭 Cell。如果没有，那就重新打开 Cell。
                        
                        //Re-open all the way
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                    } else {
                        
                        //Close
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                    }
                }
            }
                break;
            case UIGestureRecognizerStateCancelled:{
                //            NSLog(@"Pan Cancelled");
                /**
                 *  由于用户取消了触摸，表示他们不想改变 Cell 当前的状态，所以你只需要将一切都设置为它们原本的样子即可。
                 */
                if (self.startingRightLayoutConstraintConstant == 0) {
                    
                    //Cell was closed - reset everything to 0
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                } else {
                    
                    //Cell was open - reset to the open state
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                }
            }
                break;
            default:
                break;
        }
    }
}

- (void)updateConstraintsIfNeeded:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    float duration = 0;
    if (animated) {
        duration = 0.1;
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:completion];
}

- (CGFloat)buttonTotalWidth {
    return CGRectGetWidth(self.frame) - CGRectGetMinX(self.button2.frame);
}


/**
 *  关闭cell
 */
- (void)resetConstraintContstantsToZero:(BOOL)animated notifyDelegateDidClose:(BOOL)notifyDelegate {
    
    //TODO: Notify delegate.
    
    UICollectionViewCell *cell = (UICollectionViewCell *)self.superview.superview;
    if (notifyDelegate) {
        [self.PublicDelegate cellDidClose:cell];
    }
    
    if (self.startingRightLayoutConstraintConstant == 0 &&
        self.contentViewRightConstraint == 0) {
        
        //Already all the way closed, no bounce necessary
        return;
    }
    

    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        self.contentViewRightConstraint = 0;
        self.contentViewLeftConstraint = 0;
        [self.myContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            make.top.equalTo(self).with.offset(0);
            make.bottom.equalTo(self).with.offset(0);
        }];
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint;
            
        }];
    }];
}

/**
 *  打开cell
 */
- (void)setConstraintsToShowAllButtons:(BOOL)animated notifyDelegateDidOpen:(BOOL)notifyDelegate {
    
    //TODO: Notify delegate.
    UICollectionViewCell *cell = (UICollectionViewCell *)self.superview.superview;
    if (notifyDelegate) {
        [self.PublicDelegate cellDidOpen:cell];
    }
    
    //1如果 Cell 已经开启，约束已经到达完全开启值，那就返回——否则弹性操作将会一次又一次的发生，就像你继续滑动超过总按钮宽度那样。
    if (self.startingRightLayoutConstraintConstant == [self buttonTotalWidth] &&
        self.contentViewRightConstraint == [self buttonTotalWidth]) {
        return;
    }
    
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        
        //3当第一个动画完成，发动第二个动画，它将 Cell 正好打开在从按钮宽度的位置。
        self.contentViewLeftConstraint = -[self buttonTotalWidth];
        self.contentViewRightConstraint = [self buttonTotalWidth];
        [self.myContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(-[self buttonTotalWidth]);
            make.top.equalTo(self).with.offset(0);
            make.bottom.equalTo(self).with.offset(0);
        }];
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            
            //4当第二个动画完成，重设起始约束否则你会看到多次弹跳。
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint;
        }];
    }];
}
/**
 *   你的 UIPanGestureRecognizer 有时候会影响 UITableView 的 Scroll 操作, 这个方法告知各手势识别器，它们可以同时工作。
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)openCell {
    [self setConstraintsToShowAllButtons:NO notifyDelegateDidOpen:NO];
}

- (void)closeCell {
    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

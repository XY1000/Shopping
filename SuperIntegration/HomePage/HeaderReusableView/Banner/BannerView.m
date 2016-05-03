//
//  BannerView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/11.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#define myWidth self.frame.size.width
#define myHeight self.frame.size.height
#define pageSize (myHeight * 0.2 > 25 ? 25 : myHeight * 0.2)

#import "BannerView.h"
#import "BannerWebImageManager.h"

@interface BannerView()<UIScrollViewDelegate>

@property (nonatomic,copy) NSArray *imageData;

@end

@implementation BannerView{
    
    __weak  UIImageView *_leftImageView,*_centerImageView,*_rightImageView;
    
    __weak  UILabel *_leftLabel,*_centerLabel,*_rightLabel;
    
    __weak  UIScrollView *_scrollView;
    
    __weak  UIPageControl *_PageControl;
    
//    NSTimer *_timer;
    dispatch_source_t _timer;
    __block CGFloat _scrollViewContentX;//滚动内容的x值
    
    NSInteger _currentIndex;
    
    NSInteger _MaxImageCount;
    
    BOOL _isNetwork;
    
    BOOL _hasTitle;
    
    BOOL _isHasTimer;
    
    BOOL _isRefresh;
}

- (void)setMaxImageCount:(NSInteger)MaxImageCount {
    _MaxImageCount = MaxImageCount;
    
    [self prepareImageView];
    [self preparePageControl];
    
    [self setUpTimer];
    
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}


- (void)imageViewDidTap {
    if (self.imageViewDidTapAtIndex != nil) {
        self.imageViewDidTapAtIndex(_currentIndex);
    }
}

+ (instancetype)picScrollViewWithFrame:(CGRect)frame WithImageUrls:(NSArray<NSString *> *)imageUrl {
    return  [[BannerView alloc] initWithFrame:frame WithImageNames:imageUrl];
}

- (instancetype)initWithFrame:(CGRect)frame WithImageNames:(NSArray<NSString *> *)ImageName {
    if (ImageName.count < 2) {
        return nil;
    }
    self = [super initWithFrame:frame];
    
    [self prepareScrollView];
    [self setImageData:ImageName];
    [self setMaxImageCount:_imageData.count];
    
    return self;
}

- (void)setNowFrame:(CGRect)nowFrame {
    _nowFrame = nowFrame;
    self.frame = _nowFrame;
}

//首页调用
- (void)setImageUrls:(NSArray<NSString *> *)imageUrls {
    _imageUrls = imageUrls;
    
    _isHasTimer = YES;
    _scrollViewContentX = myWidth;
    
    [self prepareScrollView];
    [self setImageData:imageUrls];
    [self setMaxImageCount:_imageData.count];
}
//产品详情调用
- (void)setProductDetailPage_ImageUrls:(NSArray<NSString *> *)ProductDetailPage_ImageUrls {
    _ProductDetailPage_ImageUrls = ProductDetailPage_ImageUrls;
    
    _isHasTimer = NO;
    _isRefresh = YES;
    
    _MaxImageCount = ProductDetailPage_ImageUrls.count;
    [self prepareScrollView];
    [self setImageData:_ProductDetailPage_ImageUrls];
    [self prepareImageView];
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}

- (void)startTimer {
    [self setUpTimer];
}
- (void)endTimer {
    [self removeTimer];
}

- (void)prepareScrollView {
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:sc];
    
    _scrollView = sc;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(myWidth * 3,0);
    
    _AutoScrollDelay = 2.0f;
    _currentIndex = 0;
}

- (void)prepareImageView {
    
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,myWidth, myHeight)];
    UIImageView *center = [[UIImageView alloc] initWithFrame:CGRectMake(myWidth, 0,myWidth, myHeight)];
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(myWidth * 2, 0,myWidth, myHeight)];
    
    center.userInteractionEnabled = YES;
    [center addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    
    [_scrollView addSubview:left];
    [_scrollView addSubview:center];
    [_scrollView addSubview:right];
    
    _leftImageView = left;
    _centerImageView = center;
    _rightImageView = right;
    
}

- (void)preparePageControl {
    
    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0,myHeight - 10,myWidth, 7)];
    
    page.pageIndicatorTintColor = [UIColor lightGrayColor];
    page.currentPageIndicatorTintColor =  [UIColor whiteColor];
    page.numberOfPages = _MaxImageCount;
    page.currentPage = 0;
    
    [self addSubview:page];
    
    
    _PageControl = page;
}

- (void)setStyle:(PageControlStyle)style {
    if (style == PageControlAtRight) {
        CGFloat w = _MaxImageCount * 17.5;
        _PageControl.frame = CGRectMake(0, 0, w, 7);
        _PageControl.center = CGPointMake(myWidth-w*0.5, myHeight-pageSize * 0.5);
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _PageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _PageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}


- (void)setTitleData:(NSArray<NSString *> *)titleData {
    if (titleData.count < 2)  return;
    
    if (titleData.count < _imageData.count) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:titleData];
        for (int i = 0; i < _imageData.count - titleData.count; i++) {
            [temp addObject:@""];
        }
        _titleData = temp;
    }else {
        
        _titleData = titleData;
    }
    
    [self prepareTitleLabel];
    _hasTitle = YES;
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}


- (void)prepareTitleLabel {
    
    [self setStyle:PageControlAtRight];
    
    UIView *left = [self creatLabelBgView];
    UIView *center = [self creatLabelBgView];
    UIView *right = [self creatLabelBgView];
    
    _leftLabel = (UILabel *)left.subviews.firstObject;
    _centerLabel = (UILabel *)center.subviews.firstObject;
    _rightLabel = (UILabel *)right.subviews.firstObject;
    
    [_leftImageView addSubview:left];
    [_centerImageView addSubview:center];
    [_rightImageView addSubview:right];
    
    
}



- (UIView *)creatLabelBgView {
    
    
    UIToolbar *v = [[UIToolbar alloc] initWithFrame:CGRectMake(0, myHeight-pageSize, myWidth, pageSize)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, myWidth-_PageControl.frame.size.width,pageSize)];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [[UIColor alloc] initWithWhite:0.5 alpha:1];
    label.font = [UIFont systemFontOfSize:pageSize*0.5];
    
    [v addSubview:label];
    
    return v;
}

- (void)setTextColor:(UIColor *)textColor {
    _leftLabel.textColor = textColor;
    _rightLabel.textColor = textColor;
    _centerLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font {
    _leftLabel.font = font;
    _rightLabel.font = font;
    _centerLabel.font = font;
}

#pragma mark scrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_isHasTimer) {
        _scrollViewContentX = scrollView.contentOffset.x;
        [self setUpTimer];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_isHasTimer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self changeImageWithOffset:scrollView.contentOffset.x];
}

- (void)changeImageWithOffset:(CGFloat)offsetX {
    
    if (offsetX >= myWidth * 2) {
        
        _currentIndex++;
        
        if (_currentIndex == _MaxImageCount-1) {
            
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else if (_currentIndex == _MaxImageCount) {
            
            _currentIndex = 0;
            [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
            
        }else {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        
        
        if (!_isHasTimer) {
            self.currentImageIndexBlock(_currentIndex + 1);
        }
    }
    
    if (offsetX <= 0) {
        _currentIndex--;
        
        if (_currentIndex == 0) {
            
            [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
            
        }else if (_currentIndex == -1) {
            
            _currentIndex = _MaxImageCount-1;
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        
        
        if (!_isHasTimer) {
            self.currentImageIndexBlock(_currentIndex + 1);
        }
    }
    [self setPageControlCurrentPage];
    
}

- (void)setPageControlCurrentPage {
    _PageControl.currentPage = _currentIndex;
}

- (void)changeImageLeft:(NSInteger)LeftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex {
    
//    if (_imageUrls.count < 1) {
//        _centerImageView.image = [self setImageWithIndex:0];
//        [Utility yanshiWithSeconds:1.0f method:^{
//            _centerImageView.image = [self setImageWithIndex:0];
//        }];
//    } else {
//        
//    }
    if (_isNetwork) {
        _leftImageView.image = [self setImageWithIndex:LeftIndex];
        _centerImageView.image = [self setImageWithIndex:centerIndex];
        _rightImageView.image = [self setImageWithIndex:rightIndex];
        
        if (_isRefresh) {
            [Utility yanshiWithSeconds:0.5f method:^{
                _centerImageView.image = [self setImageWithIndex:centerIndex];
                _isRefresh = NO;
            }];
        }
        
    }else {
        _leftImageView.image = _imageData[LeftIndex];
        _centerImageView.image = _imageData[centerIndex];
        _rightImageView.image = _imageData[rightIndex];
    }
    
    if (_hasTitle) {
        _leftLabel.text = _titleData[LeftIndex];
        _centerLabel.text = _titleData[centerIndex];
        _rightLabel.text = _titleData[rightIndex];
    }
    [_scrollView setContentOffset:CGPointMake(myWidth, 0)];
}

-(void)setPlaceImage:(UIImage *)placeImage {
    _placeImage = placeImage;
    _placeImage = [UIImage imageNamed:@"place"];
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}

- (UIImage *)setImageWithIndex:(NSInteger)index {
    
    //从内存缓存中取,如果没有使用占位图片
    UIImage *image = [[[BannerWebImageManager shareManager] webImageCache] valueForKey:_imageData[index]];
    
    return image ? image : _placeImage;
}


- (void)scorll {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + myWidth, 0) animated:YES];
}

- (void)setAutoScrollDelay:(NSTimeInterval)AutoScrollDelay {
    _AutoScrollDelay = AutoScrollDelay;
    [self removeTimer];
    [self setUpTimer];
}

- (void)setUpTimer {
    if (_AutoScrollDelay < 0.5) return;
    
    if (_isHasTimer) {
        if (_timer == nil) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            //每秒执行一次
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), _AutoScrollDelay * NSEC_PER_SEC, 0);
            dispatch_source_set_event_handler(_timer, ^{
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    if (_scrollViewContentX >= myWidth) {//右滑
                        [_scrollView setContentOffset:CGPointMake(2 * myWidth, 0) animated:YES];
                    } else {//左滑
                        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                        _scrollViewContentX = myWidth;
                    }
                    
                });
            });
            dispatch_resume(_timer);
        }
    } else {
        return ;
    }
}

- (void)removeTimer {
//    if (_timer == nil) return;
//    if ((_scrollView.contentOffset.x > myWidth) && (_scrollView.contentOffset.x < myWidth * 2)) {
//        [_scrollView setContentOffset:CGPointMake(myWidth, 0)];
//        [self scorll];
//    }
//    [_timer invalidate];
//    _timer = nil;
}

- (void)setImageData:(NSArray *)ImageNames {
    
    _isNetwork = [ImageNames.firstObject hasPrefix:@"http://"];
    
    if (_isNetwork) {
        
        _imageData = [ImageNames copy];
        
        [self getImage];
        
    }else {
        
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:ImageNames.count];
        
        for (NSString *name in ImageNames) {
            [temp addObject:[UIImage imageNamed:name]];
        }
        
        _imageData = [temp copy];
    }
    
}


- (void)getImage {
    
    for (NSString *urlSting in _imageData) {
        [[BannerWebImageManager shareManager] downloadImageWithUrlString:urlSting];
    }
    
}

-(void)dealloc {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

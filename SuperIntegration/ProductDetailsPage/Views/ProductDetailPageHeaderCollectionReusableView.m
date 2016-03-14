//
//  ProductDetailPageHeaderCollectionReusableView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/4.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ProductDetailPageHeaderCollectionReusableView.h"
#import "BannerView.h"
#import "BannerWebImageManager.h"
@interface ProductDetailPageHeaderCollectionReusableView()

@property (weak, nonatomic) IBOutlet BannerView *bannerView;

@end

@implementation ProductDetailPageHeaderCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
}

- (void)viewWithArray:(NSArray *)array {
//    NSArray *UrlStringArray = @[@"http://p1.qqyou.com/pic/UploadPic/2013-3/19/2013031923222781617.jpg",
//                                @"http://cdn.duitang.com/uploads/item/201409/27/20140927192649_NxVKT.thumb.700_0.png",
//                                @"http://img4.duitang.com/uploads/item/201409/27/20140927192458_GcRxV.jpeg",
//                                @"http://cdn.duitang.com/uploads/item/201304/20/20130420192413_TeRRP.thumb.700_0.jpeg"];
    
    [self.bannerView setNowFrame:self.bounds];
    
    if (!ARRAY_IS_NIL(array)) {
        [self.bannerView setProductDetailPage_ImageUrls:array];
    }
    
    //占位图片,你可以在下载图片失败处修改占位图片
    self.bannerView.placeImage = [UIImage imageNamed:@"place.png"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    
    [self.bannerView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("第%zd张图片\n",index);
    }];
    
    
    //下载失败重复下载次数,默认不重复,
    [[BannerWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
    [[BannerWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"%@",error);
    }];
    
    //右下角图片张数
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 13 - ProductDetailPage_HeaderViewBottomLabelHeigtht, self.frame.size.height - 13 - ProductDetailPage_HeaderViewBottomLabelHeigtht, ProductDetailPage_HeaderViewBottomLabelHeigtht, ProductDetailPage_HeaderViewBottomLabelHeigtht)];
    bottomLabel.backgroundColor = RGB(182, 183, 184);
    [self addSubview:bottomLabel];
    bottomLabel.layer.masksToBounds = YES;
    bottomLabel.layer.cornerRadius = ProductDetailPage_HeaderViewBottomLabelHeigtht / 2;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.textColor = [UIColor whiteColor];
    
    //改变第一个字符的字体
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"1/%ld", (unsigned long)array.count]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(0, 1)];
    bottomLabel.attributedText = attributedString;
    
    //滚动一次改变一次值
    self.bannerView.currentImageIndexBlock = ^(NSInteger index) {
        [attributedString replaceCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%ld", (long)index]];
        bottomLabel.attributedText = attributedString;
    };
}

@end

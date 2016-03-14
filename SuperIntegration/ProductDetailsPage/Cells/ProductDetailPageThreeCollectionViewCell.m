//
//  ProductDetailPageThreeCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ProductDetailPageThreeCollectionViewCell.h"
#import "ProductDetailPageModel.h"

@interface ProductDetailPageThreeCollectionViewCell()<UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ProductDetailPageThreeCollectionViewCell

- (void)awakeFromNib {
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
}

- (void)cellWithModel:(ProductDetailPageModel *)model {
    [self.webView loadHTMLString:model.introduction baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.frame.size.height == 49) {
        self.refreshBlock(webView.scrollView.contentSize.height);
    }
}

@end

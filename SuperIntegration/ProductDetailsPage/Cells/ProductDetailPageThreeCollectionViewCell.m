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
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.delegate = self;
//    [self.webView setScalesPageToFit:YES];
}

- (void)cellWithModel:(ProductDetailPageModel *)model {
    /**
     *  webView修改图片的style
     */
    NSString * htmlStyle = [NSString stringWithFormat:@" <style type=\"text/css\"> img{ width: %f; height: auto; display: block;} </style> ", SCREEN_WIDTH - 20];
    NSString * htmlStr = model.introduction;
    
    htmlStr = [htmlStyle stringByAppendingString:htmlStr];
    [self.webView loadHTMLString:htmlStr baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    /**
     *  webView内容水平和垂直都居中
     */
//    NSString *bodyStyleVertical = @"document.getElementsByTagName('body')[0].style.verticalAlign = 'middle';";
//    NSString *bodyStyleHorizontal = @"document.getElementsByTagName('body')[0].style.textAlign = 'center';";
//    NSString *mapStyle = @"document.getElementById('mapid').style.margin = 'auto';";
//    
//    [webView stringByEvaluatingJavaScriptFromString:bodyStyleVertical];
//    [webView stringByEvaluatingJavaScriptFromString:bodyStyleHorizontal];
//    [webView stringByEvaluatingJavaScriptFromString:mapStyle];
    
    /**
     *  webView修改图片的宽度和高度
     */
//    [webView stringByEvaluatingJavaScriptFromString:
//     @"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "script.text = \"function ResizeImages() { "
//        "var myimg,oldwidth;"
//        "var maxwidth = 400;" //图片宽度
//        "for(i=0;i <document.images.length;i++){"
//            "myimg = document.images[i];"
//            "if(myimg.width > maxwidth){"
//                "oldwidth = myimg.width;"
//                "myimg.width = maxwidth;"
//     "myimg.height = myimg.height * (maxwidth/oldwidth);"
//            "}"
//        "}"
//     "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);"];
//    
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
//    if (self.frame.size.height == 49) {
//        self.refreshBlock(webView.scrollView.contentSize.height);
//        
//    }
    
}

@end

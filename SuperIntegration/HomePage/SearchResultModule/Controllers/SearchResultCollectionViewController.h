//
//  SearchResultCollectionViewController.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchResultCollectionViewController : UICollectionViewController

//关键字
@property (copy, nonatomic) NSString *keyWords;
//关键字id
@property (assign, nonatomic) NSInteger keyWordsCategoryId;

@property (copy, nonatomic) NSString *searchWords;
@end

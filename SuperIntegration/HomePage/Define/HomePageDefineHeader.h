//
//  HomePageDefineHeader.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/14.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#ifndef HomePageDefineHeader_h
#define HomePageDefineHeader_h

/*
 Controller
 */
//bannerView的高度
#define BannerViewHeight                SCREEN_HEIGHT * 410 / (667 * 2)
//headerView的高度
#define HeaderViewsHieght               SCREEN_HEIGHT * (80 + 20) / (667 * 2)
//#define GuessHeaderViewHeight           SCREEN_HEIGHT * 100 / (667 * 2)
//cell的高度和宽度
#define ClassificationWith              (SCREEN_WIDTH - 1) / 5
#define ClassificationHeight            SCREEN_HEIGHT * 165 / (667 * 2)
#define SectionThreeItem1Width          SCREEN_WIDTH / 2
#define SectionThreeItem0Width          (SCREEN_WIDTH - SectionThreeItem1Width) / 2
//特色馆的cell的高度和宽度
#define SpecialShoppingItem0Height      SCREEN_HEIGHT * 374 / (667 * 2)
#define SpecialShoppingItem1Height      SpecialShoppingItem0Height / 2
#define SpecialShoppingItem2Height      SpecialShoppingItem1Height - 1

#define HMC_TypeOneCellWith             SCREEN_WIDTH * 302 / (375 * 2)
#define HMC_TypeTwoCellWith             SCREEN_WIDTH * 374 / (375 * 2)
#define HMC_TypeThreeCellWith           SCREEN_WIDTH * 336 / (375 * 2)

/*
 HeaderCollectionReusableView
 */
#define BackViewHeight                  SCREEN_HEIGHT * 80 / 1334

/*
 CustomNavigationBarView
 */
#define SearchButtonWidth               SCREEN_WIDTH * 630 / (375 * 2)
#define SearchButtonTitleInsetsWithLeft SearchButtonWidth * 20 / 630
#define SearchButtonImageInsetsWithLeft SearchButtonWidth * 570 / 630
#define SearchButtonImageInsetsWithRight SearchButtonWidth * 20 / 630

#endif /* HomePageDefineHeader_h */

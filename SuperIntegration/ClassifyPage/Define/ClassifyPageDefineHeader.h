//
//  ClassifyPageDefineHeader.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/20.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#ifndef ClassifyPageDefineHeader_h
#define ClassifyPageDefineHeader_h

/**
 *  navSearchButton
 */
#define ClassifyPageSearchButtonWidth                   SCREEN_WIDTH * 690 / (375 * 2)
#define ClassifyPageSearchButtonToLeftValue             (SCREEN_WIDTH - ClassifyPageSearchButtonWidth) / 2
#define ClassifyPageSearchButtonToTopValue              44 - 31 - 8
#define ClassifyPageSearchButtonImageInsetsWithLeft     ClassifyPageSearchButtonWidth * 640 / 690
#define ClassifyPageSearchButtonImageInsetsWithRight    ClassifyPageSearchButtonWidth * 20 / 690

/**
 *  Controller
 */
#define ClassifyPageTableViewWidth                      SCREEN_WIDTH * 180 / (375 * 2)
/**
 *  tableViewCell
 */
#define ClassifyPageTableViewCellHeight                 SCREEN_HEIGHT * 80 / (667 * 2)
/**
 *  collectionViewCell
 */
#define ClassifyPageCollectionViewCellMinimumLine       SCREEN_WIDTH * 30 / (375 * 2)
#define ClassifyPageCollectionViewCellMinimumInteritem  SCREEN_WIDTH * 20 / (375 * 2)
#define ClassifyPageCollectionViewCellWidth             ((SCREEN_WIDTH - ClassifyPageTableViewWidth) - ClassifyPageCollectionViewCellMinimumInteritem * 3 - ClassifyPageCollectionViewCellMinimumLine * 2) / 3
#define ClassifyPageCollectionViewCellHeight            ClassifyPageCollectionViewCellWidth + (SCREEN_HEIGHT * 41 / (667 * 2))

/**
 *  collectionHeaderViewHeight
 */
#define ClassifyPageCollectionViewBannerImageViewHeight SCREEN_HEIGHT * 152 / (667 * 2)
#define ClassifyPageCollectionViewBannerViewHeight      ClassifyPageCollectionViewBannerImageViewHeight + ClassifyPageCollectionViewCellMinimumInteritem + 18 + 15
#define ClassifyPageCollectionViewHeaderViewHeight      SCREEN_HEIGHT * 42 / (667 * 2)
#endif /* ClassifyPageDefineHeader_h */

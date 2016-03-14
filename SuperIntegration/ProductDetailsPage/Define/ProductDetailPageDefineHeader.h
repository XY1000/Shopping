//
//  ProductDetailPageDefineHeader.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/4.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#ifndef ProductDetailPageDefineHeader_h
#define ProductDetailPageDefineHeader_h


/**
 *  headerView
 */
#define ProductDetailPage_HeaderViewHeight                  SCREEN_HEIGHT * 750 / (667 * 2)
#define ProductDetailPage_HeaderViewBottomLabelHeigtht      SCREEN_HEIGHT * 120 / (667 * 2)

/**
 *  cells
 */
//左右边框距离
#define ProductDetailPage_LeftOrRightBorderDistance         SCREEN_WIDTH * 20 / (375 * 2)
#define ProductDetailPage_TopLabelDistance                  SCREEN_HEIGHT * 30 / (667 * 2)
#define ProductDetailPage_TopOrBottomBorderDistance         SCREEN_HEIGHT * 40 / (667 * 2)
#define ProductDetailPage_LeftLabelDistance                 SCREEN_WIDTH * 70 / (375 * 2)

#define ProductDetailPage_CellWithOneHeight                 ProductDetailPage_TopOrBottomBorderDistance * 2 + ProductDetailPage_TopLabelDistance + 20 + 24
#define ProductDetailPage_CellWithTwoHeight                 SCREEN_HEIGHT * 100 / (667 * 2)

#endif /* ProductDetailPageDefineHeader_h */

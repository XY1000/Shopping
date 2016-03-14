
//
//  MineDefineHeader.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#ifndef MineDefineHeader_h
#define MineDefineHeader_h

/*
 Controller
 */
#define MineSectionZeroHeight                   SCREEN_HEIGHT * (448 - 64) / (667 * 2)
#define MineSectionZeroButtonHeight             MineSectionZeroHeight * 100 / (448 - 64)
#define MineSectionZeroFootPrintButtonWidth     SCREEN_WIDTH * 250 / (375 * 2)
#define MineSectionZeroButtonTitleInsets        MineSectionZeroButtonHeight * 40 / 100
#define MineSectionZeroLabelToTopValue          MineSectionZeroButtonHeight * 10 / 100

#define MineSectionOneCellWith                  SCREEN_WIDTH / 4
#define MineSectionOneCellHeight                SCREEN_HEIGHT * 165 / (667 * 2)

#define MineSectionTwoCellHeight                SCREEN_HEIGHT * 220 / (667 * 2)
#define MineSectionTwoCellButton1ToLeftValue    SCREEN_WIDTH * 26 / (375 * 2)
#define MineSectionTwoCellButton1Width          SCREEN_WIDTH * 180 / (375 * 2)
#define MineSectionTwoCellButton2Width          SCREEN_WIDTH * 170 / (375 * 2)
#define MineSectionTwoCellButton3Width          SCREEN_WIDTH * 160 / (375 * 2)
#define MineSectionTwoCellButton4Width          SCREEN_WIDTH * 160 / (375 * 2)

#define MineSectionThreeCellHeight              SCREEN_HEIGHT * 100 / (667 * 2)
#define MineSectionThreeCellHeaderViewHeight    SCREEN_HEIGHT * 20 / (667 * 2)


//OrderCon
#define OrderAllList_CellHeaderViewHeight       SCREEN_HEIGHT * 80 / (667 * 2)
#define OrderAllList_HeaderViewHeight           OrderAllList_CellHeaderViewHeight * 60 / 80

#endif /* MineDefineHeader_h */

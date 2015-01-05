//
//  MultiFunctionCell.h
//  XZMultiFunctionCell
//
//  Created by xiazer on 15/1/5.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MultiFunctionCellType) {
    MultiFunctionCellTypeForNormal = 1, // 常见状态，cell没有任何移动
    MultiFunctionCellTypeForLeftMenu = 2, // 左侧menu可见
    MultiFunctionCellTypeForRightMenu = 3, // 右侧menu可见
};

    
@interface MultiFunctionCell : UITableViewCell <UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *leftMenus;
@property (nonatomic, strong) NSArray *rightMenus;
@property (nonatomic, assign) float cellHeight;
@property (nonatomic, strong) UIScrollView *cellContentView;
@property (nonatomic, assign) MultiFunctionCellType cellStauts;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons;

@end

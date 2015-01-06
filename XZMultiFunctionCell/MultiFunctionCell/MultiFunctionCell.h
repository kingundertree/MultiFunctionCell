//
//  MultiFunctionCell.h
//  XZMultiFunctionCell
//
//  Created by xiazer on 15/1/5.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultiFunctionCell;

typedef NS_ENUM(NSInteger, MultiFunctionCellType) {
    MultiFunctionCellTypeForNormal = 0, // 常见状态，cell没有任何移动
    MultiFunctionCellTypeForLeftMenu = 1, // 左侧menu可见
    MultiFunctionCellTypeForRightMenu = 2, // 右侧menu可见
};


@protocol MultiFunctionCellActionDelegate <NSObject>
- (void)tableMenuDidShowInCell:(MultiFunctionCell *)cell;
- (void)tableMenuWillShowInCell:(MultiFunctionCell *)cell;
- (void)tableMenuDidHideInCell:(MultiFunctionCell *)cell;
- (void)tableMenuWillHideInCell:(MultiFunctionCell *)cell;
- (void)deleteCell:(MultiFunctionCell *)cell;
- (void)cellMenuIndex:(NSIndexPath *)indexPath menuIndexNum:(NSInteger)menuIndexNum isLeftMenu:(BOOL)isLeftMenu;
@end

    
@interface MultiFunctionCell : UITableViewCell <UIScrollViewDelegate>
@property (nonatomic, assign) id<MultiFunctionCellActionDelegate> cellActionDelegate;

@property (nonatomic, strong) NSArray *leftMenus;
@property (nonatomic, strong) NSArray *rightMenus;
@property (nonatomic, assign) float cellHeight;
@property (nonatomic, strong) UIView *cellContentView;
@property (nonatomic, assign) MultiFunctionCellType cellStauts;
@property (nonatomic, strong) UIView *leftMenuView;
@property (nonatomic, strong) UIView *rightMenuView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons;

- (void)setMenuHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler;
@end

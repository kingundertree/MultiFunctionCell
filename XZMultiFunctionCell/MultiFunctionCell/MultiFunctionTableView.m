//
//  MultiFunctionTableView.m
//  XZMultiFunctionCell
//
//  Created by xiazer on 15/1/5.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "MultiFunctionTableView.h"

@interface MultiFunctionTableView ()
@property (nonatomic, strong) MultiFunctionCell *activeCell;
@property (nonatomic, strong) OverLayView *overLayView;
@property (nonatomic, assign) BOOL isCellMenuOn;
@property (nonatomic, assign) NSInteger cellIndex;

@end

@implementation MultiFunctionTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    
    return self;
}

#pragma mark - OverLayViewDelegate
- (UIView *)overLayView:(OverLayView *)view didHitPoint:(CGPoint)didHitPoint withEvent:(UIEvent *)withEvent{
    BOOL shoudReceivePointTouch = YES;
    
    CGPoint location = [self convertPoint:didHitPoint fromView:view];

    CGRect rect;
    if (self.activeCell.cellStauts == MultiFunctionCellTypeForLeftMenu) {
       rect = [self.activeCell  convertRect:self.activeCell.leftMenuView.frame toView:self];
    } else if (self.activeCell.cellStauts == MultiFunctionCellTypeForRightMenu) {
        rect = [self.activeCell  convertRect:self.activeCell.rightMenuView.frame toView:self];
    }
    shoudReceivePointTouch = CGRectContainsPoint(rect, location);
    if (!shoudReceivePointTouch) {
        // 回复cell 菜单状态
        [self hideMenuActive:YES];
    }
    
    return (shoudReceivePointTouch) ? [self.activeCell hitTest:didHitPoint withEvent:withEvent] : view;
}

- (void)hideMenuActive:(BOOL)aninated{
    __block MultiFunctionTableView *this = self;
    [self.activeCell setMenuHidden:YES animated:YES completionHandler:^{
        this.isCellMenuOn = NO;
    }];
}
#pragma mark MultiFunctionCellActionDelegate
- (void)tableMenuDidShowInCell:(MultiFunctionCell *)cell{
    self.cellIndex = [self indexPathForCell:cell].row;
    self.isCellMenuOn = YES;
    self.activeCell = cell;
}
- (void)tableMenuWillShowInCell:(MultiFunctionCell *)cell{
    self.cellIndex = [self indexPathForCell:cell].row;
    self.isCellMenuOn = YES;
    self.activeCell = cell;
}
- (void)tableMenuDidHideInCell:(MultiFunctionCell *)cell{
    self.cellIndex = -1;
    self.isCellMenuOn = NO;
    self.activeCell = nil;
}
- (void)tableMenuWillHideInCell:(MultiFunctionCell *)cell{
    self.cellIndex = -1;
    self.isCellMenuOn = NO;
    self.activeCell = nil;
}

- (void)cellMenuIndex:(NSIndexPath *)indexPath menuIndexNum:(NSInteger)menuIndexNum isLeftMenu:(BOOL)isLeftMenu;
{
    NSLog(@"你选择了第 %d 行第 %ld 个菜单",indexPath.row+1,(long)menuIndexNum+1);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"你选择了%@第 %ld 行第 %ld 个菜单",isLeftMenu?@"左侧":@"右侧",(long)(indexPath.row+1),(long)menuIndexNum+1] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)deleteCell:(MultiFunctionCell *)cell{
    
}


#pragma mark  UITableView delegate
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView cellForRowAtIndexPath:indexPath] == self.activeCell) {
        [self hideMenuActive:YES];
        return NO;
    }
    return YES;
}

- (void)setIsCellMenuOn:(BOOL)isCellMenuOn{
    if (_isCellMenuOn != isCellMenuOn) {
        _isCellMenuOn = isCellMenuOn;
    }

    if (_isCellMenuOn) {
        if (!self.overLayView) {
            self.overLayView = [[OverLayView alloc] initWithFrame:self.bounds];
            self.overLayView.delegate = self;
            [self addSubview:self.overLayView];
        }
    }else{
        self.activeCell = nil;
        [_overLayView removeFromSuperview];
        _overLayView = nil;
    }
}



@end

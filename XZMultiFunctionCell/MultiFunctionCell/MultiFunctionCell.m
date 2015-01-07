//
//  MultiFunctionCell.m
//  XZMultiFunctionCell
//
//  Created by xiazer on 15/1/5.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "MultiFunctionCell.h"

//定义屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//定义屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define CellMenuWidth 80.0


@interface MultiFunctionCell () <UIGestureRecognizerDelegate>
@property (nonatomic, assign) float startX;
@property (nonatomic, assign) float cellStartX;
@property (nonatomic, strong) UIView *baseCellView;
@property (nonatomic, assign) float leftMargin;
@property (nonatomic, assign) float rightMargin;
@property (nonatomic, assign) BOOL isMoving;
@property (nonatomic, strong) UITableView *containTableView;
@end

@implementation MultiFunctionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellHeight = containingTableView.rowHeight;
        self.containTableView = containingTableView;
        
        [self initUI];
        self.leftMenus = [NSArray arrayWithArray:leftUtilityButtons];
        self.rightMenus = [NSArray arrayWithArray:rightUtilityButtons];
        [self addCellView];
    }
    return self;
}

- (void)initUI{
    self.baseCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.cellHeight)];
    self.baseCellView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.baseCellView];
}

- (void)addCellView{
    self.leftMargin = 10+self.leftMenus.count*CellMenuWidth;
    self.rightMargin = 0-10-self.rightMenus.count*CellMenuWidth;

    self.cellContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.cellHeight)];
    self.cellContentView.backgroundColor = [UIColor  clearColor];
    [self.baseCellView addSubview:self.cellContentView];

    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cellPanGes:)];
    panGes.delegate = self;
    panGes.delaysTouchesBegan = YES;
    panGes.cancelsTouchesInView = NO;
    [self.cellContentView addGestureRecognizer:panGes];
}

- (void)setLeftMenus:(NSArray *)leftMenus{
    _leftMenus = leftMenus;
    
    if (_leftMenus.count > 0) {
        self.leftMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CellMenuWidth*_leftMenus.count, self.cellHeight)];
        self.leftMenuView.backgroundColor = [UIColor clearColor];
        [self.baseCellView addSubview:self.leftMenuView];
        
        for (NSInteger i = 0; i < _leftMenus.count; i++) {
            CGRect frame = CGRectMake(CellMenuWidth*i, 0, CellMenuWidth, self.cellHeight);
            UIButton *menuBtn = [self createBtn:frame title:_leftMenus[i] titleColor:[UIColor blueColor] bgcolor:[UIColor greenColor] menuTag:100+i];
            [self.leftMenuView addSubview:menuBtn];
        }
    }
}

- (void)setRightMenus:(NSArray *)rightMenus{
    _rightMenus = rightMenus;
    
    if (_rightMenus.count > 0) {
        self.rightMenuView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-CellMenuWidth*_rightMenus.count, 0, CellMenuWidth*_rightMenus.count, self.cellHeight)];
        self.rightMenuView.backgroundColor = [UIColor clearColor];
        [self.baseCellView addSubview:self.rightMenuView];

        for (NSInteger i = 0; i < _rightMenus.count; i++) {
            CGRect frame = CGRectMake(CellMenuWidth*i, 0, CellMenuWidth, self.cellHeight);
            UIButton *menuBtn = [self createBtn:frame title:_rightMenus[i] titleColor:[UIColor whiteColor] bgcolor:[UIColor redColor] menuTag:200+i];
            [self.rightMenuView addSubview:menuBtn];
        }
    }
}

#pragma mark * UIPanGestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self];
        return fabs(translation.x) > fabs(translation.y);
    }
    return YES;
}

- (void)cellPanGes:(UIPanGestureRecognizer *)panGes{
    if (self.isMoving) {
        return;
    }
    
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    CGPoint pointer = [panGes locationInView:self.contentView];
    if (panGes.state == UIGestureRecognizerStateBegan) {
        self.startX = pointer.x;
        self.cellStartX = self.cellContentView.frame.origin.x;
    }else if (panGes.state == UIGestureRecognizerStateChanged){
        if (self.cellActionDelegate && [self.cellActionDelegate respondsToSelector:@selector(tableMenuWillHideInCell:)]) {
            [self.cellActionDelegate tableMenuWillShowInCell:self];
        }
        [self cellViewMoveToX:self.cellStartX + pointer.x - self.startX];
    }else if (panGes.state == UIGestureRecognizerStateCancelled || panGes.state == UIGestureRecognizerStateEnded){
        [self resetCellContentView];
        return;
    }
}

- (void)cellViewMoveToX:(float)x{
    NSLog(@"nowX-->>%f",x);
    if (x >= self.leftMargin) {
        return;
    } else if (x <= self.rightMargin) {
        return;
    }

    self.cellContentView.frame = CGRectMake(x, 0, ScreenWidth, self.cellHeight);
}

- (void)resetCellContentView{
    float cellX = self.cellContentView.frame.origin.x;
    __block MultiFunctionCell *this = self;
    if (cellX <= 10 && cellX >= -10) {
        self.isMoving = YES;
        [UIView animateWithDuration:0.2 animations:^{
            this.cellContentView.frame = CGRectMake(0, 0, ScreenWidth, this.cellHeight);
        } completion:^(BOOL finished) {
            self.isMoving = NO;
            this.cellStauts = MultiFunctionCellTypeForNormal;
            [self.cellActionDelegate tableMenuDidHideInCell:self];
        }];
    } else if ( cellX > 10) {
        self.isMoving = YES;
        [UIView animateWithDuration:0.2 animations:^{
            this.cellContentView.frame = CGRectMake(self.leftMenus.count*CellMenuWidth, 0, ScreenWidth, this.cellHeight);
        } completion:^(BOOL finished) {
            self.isMoving = NO;
            this.cellStauts = MultiFunctionCellTypeForLeftMenu;
            [self.cellActionDelegate tableMenuDidShowInCell:self];
        }];
    } else if (cellX < -10) {
        self.isMoving = YES;
        [UIView animateWithDuration:0.2 animations:^{
            this.cellContentView.frame = CGRectMake(0.0-self.rightMenus.count*CellMenuWidth, 0, ScreenWidth, this.cellHeight);
        } completion:^(BOOL finished) {
            self.isMoving = NO;
            this.cellStauts = MultiFunctionCellTypeForRightMenu;
            [self.cellActionDelegate tableMenuDidShowInCell:self];
        }];
    }
}

- (void)setMenuHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    if (hidden) {
        CGRect frame = self.cellContentView.frame;
        if (frame.origin.x != 0) {
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
                [self.cellActionDelegate tableMenuDidHideInCell:self];
                if (completionHandler) {
                    completionHandler();
                }
            }];
        }
    }
}

- (void)initCellFrame:(float)x{
    CGRect frame = self.cellContentView.frame;
    frame.origin.x = x;
    
    self.cellContentView.frame = frame;
}


- (UIButton *)createBtn:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor bgcolor:(UIColor *)bgcolor menuTag:(NSInteger)menuTag{
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = frame;
    [menuBtn setBackgroundColor:bgcolor];
    [menuBtn setTitle:title forState:UIControlStateNormal];
    [menuBtn setTitleColor:titleColor forState:UIControlStateNormal];
    menuBtn.tag = menuTag;
    [menuBtn addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return menuBtn;
}

- (void)menuClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (self.cellActionDelegate && [self.cellActionDelegate respondsToSelector:@selector(cellMenuIndex:menuIndexNum:isLeftMenu:)]) {
        if (btn.tag >= 200) {
            [self.cellActionDelegate cellMenuIndex:[self.containTableView indexPathForCell:self] menuIndexNum:btn.tag-200 isLeftMenu:NO];
        } else {
            [self.cellActionDelegate cellMenuIndex:[self.containTableView indexPathForCell:self] menuIndexNum:btn.tag-100 isLeftMenu:YES];
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

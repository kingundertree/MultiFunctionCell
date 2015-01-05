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


@interface MultiFunctionCell ()
@property (nonatomic, strong) UIView *baseCellView;
@end


@implementation MultiFunctionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.cellHeight = containingTableView.rowHeight;

        [self initUI];
        self.leftMenus = [NSArray arrayWithArray:leftUtilityButtons];
        self.rightMenus = [NSArray arrayWithArray:rightUtilityButtons];
        [self addCellView];
    }
    return self;
}

- (void)initUI{
    self.baseCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.cellHeight)];
    self.baseCellView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.baseCellView];
}

- (void)addCellView{
    self.cellContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.cellHeight)];
    self.cellContentView.contentSize = CGSizeMake(ScreenWidth+1, self.cellHeight);
    self.cellContentView.backgroundColor = [UIColor  clearColor];
    self.cellContentView.delegate = self;
    self.cellContentView.showsHorizontalScrollIndicator = YES;
    [self.baseCellView addSubview:self.cellContentView];
}

- (void)setLeftMenus:(NSArray *)leftMenus{
    _leftMenus = leftMenus;
    
    if (_leftMenus.count > 0) {
        for (NSInteger i = 0; i < _leftMenus.count; i++) {
            CGRect frame = CGRectMake(80*i, 0, 80, self.cellHeight);
            UIButton *menuBtn = [self createBtn:frame title:_leftMenus[i] titleColor:[UIColor blueColor] bgcolor:[UIColor whiteColor] menuTag:100+i];
            [self.baseCellView addSubview:menuBtn];
        }
    }
}
- (void)setRightMenus:(NSArray *)rightMenus{
    _rightMenus = rightMenus;
    
    if (_rightMenus.count > 0) {
        for (NSInteger i = 0; i < _rightMenus.count; i++) {
            CGRect frame = CGRectMake(ScreenWidth-80*(_rightMenus.count-i), 0, 80, self.cellHeight);
            UIButton *menuBtn = [self createBtn:frame title:_rightMenus[i] titleColor:[UIColor whiteColor] bgcolor:[UIColor redColor] menuTag:200+i];
            [self.baseCellView addSubview:menuBtn];
        }
    }
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
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HomeViewCell.m
//  XZMultiFunctionCell
//
//  Created by xiazer on 15/1/5.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "HomeViewCell.h"

//定义屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//定义屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation HomeViewCell

- (void)configCell:(id)model index:(NSIndexPath*)index{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    lab.backgroundColor = [UIColor whiteColor];
    [self.cellContentView addSubview:lab];

    lab.text = [NSString stringWithFormat:@"  MultiFunctionCell---->>  %ld",(long)index.row];
}

@end

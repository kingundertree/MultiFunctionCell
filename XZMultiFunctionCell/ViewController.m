//
//  ViewController.m
//  XZMultiFunctionCell
//
//  Created by xiazer on 15/1/5.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "ViewController.h"
#import "MultiFunctionTableView.h"
#import "HomeViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) MultiFunctionTableView *tableList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多功能cell";
    
    self.tableList = [[MultiFunctionTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableList.delegate = self;
    self.tableList.dataSource = self;
    self.tableList.rowHeight = 80;
    [self.view addSubview:self.tableList];
}

#pragma mark
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"cell";
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[HomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellIdentify
                               containingTableView:tableView
                                leftUtilityButtons:@[@"Left1"]
                               rightUtilityButtons:@[@"right1",@"right2"]];
        [cell configCell:nil index:indexPath];
    }
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

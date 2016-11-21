//
//  AccountTableViewController.m
//  DrowDownMenu
//
//  Created by yaoshuai on 2016/11/21.
//  Copyright © 2016年 yaoshuai. All rights reserved.
//

#import "AccountTableViewController.h"
#import "AccountModel.h"
#import "AccountTableViewCell.h"

#define inputW 230 // 输入框宽度
#define inputH 35  // 输入框高度

static NSString *cellID = @"cellID";

@interface AccountTableViewController ()

@end

@implementation AccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景
    self.view.backgroundColor = [UIColor whiteColor];
    // 清除多余的分割线
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    //  边界
    self.tableView.layer.borderWidth = 0.5;
    
    [self.tableView registerClass:[AccountTableViewCell class] forCellReuseIdentifier:cellID];
    
    // 默认关闭下拉列表
    _isOpen = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 展开与隐藏账号列表
    if(_isOpen)
        return _accountSource.count;
    else
        return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AccountTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.accountModel = self.accountSource[indexPath.row];
    
    //分割线清偏移
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
        
    }
    return cell;
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return inputH;
}

// cell选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 通知代理
    if([self.delegate respondsToSelector:@selector(selectedCell:)]){
        [_delegate selectedCell:indexPath.row];
    }
}

// 打开cell滑动编辑
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 删除按钮的显示文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

// cell删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_accountSource removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        // 通知代理更新下拉菜单高度
        [_delegate updateListH];
    }
}

@end

//
//  ViewController.m
//  DrowDownMenu
//
//  Created by yaoshuai on 2016/11/21.
//  Copyright © 2016年 yaoshuai. All rights reserved.
//

#import "ViewController.h"
#import "AccountModel.h"
#import "AccountTableViewController.h"

#define inputW 230 // 输入框宽度
#define inputH 35  // 输入框高度

@interface ViewController ()<AccountDelegate>

/**
 * 账号数据
 */
@property (nonatomic) NSMutableArray *dataSource;

/**
 * 当前账号选择框
 */
@property (nonatomic, copy) UIButton *currentAccount;

/**
 *  当前选中账号
 */
@property (nonatomic, strong) AccountModel *currentAccountModel;

/**
 * 当前账号头像
 */
@property (nonatomic, copy) UIImageView *icon;

/**
 *  账号下拉列表
 */
@property (nonatomic, strong) AccountTableViewController *accountListVC;

/**
 *  下拉列表的frame
 */
@property (nonatomic) CGRect listFrame;

/**
 *  下拉列表隐藏时的frame
 */
@property (nonatomic) CGRect listHiddenFrame;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 加载数据
    [self loadData];
    // 设置下拉菜单
    [self setPopMenu];
}

/**
 加载数据
 */
- (void)loadData{
    NSMutableArray *accounts = [[NSMutableArray alloc]init];
    
    AccountModel *acc1 = [[AccountModel alloc]init];
    acc1.avatar = @"icon1";
    acc1.account = @"Mugua";
    acc1.password = @"mg123";
    [accounts addObject:acc1];
    
    AccountModel *acc2 = [[AccountModel alloc]init];
    acc2.avatar = @"icon2";
    acc2.account = @"Taozi";
    acc2.password = @"tz123";
    [accounts addObject:acc2];
    
    AccountModel *acc3 = [[AccountModel alloc]init];
    acc3.avatar = @"icon3";
    acc3.account = @"Nangua";
    acc3.password = @"ng123";
    [accounts addObject:acc3];
    
    _dataSource = accounts;
}

/**
 * 设置下拉菜单
 */
- (void)setPopMenu {
    
    // 1.1帐号选择框
    _currentAccount = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, inputW, inputH)];
    _currentAccount.center = CGPointMake(self.view.center.x, 200);
    // 默认当前账号为已有账号的第一个
    AccountModel *acc = _dataSource[0];
    [_currentAccount setTitle:acc.account forState:UIControlStateNormal];
    // 字体
    [_currentAccount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _currentAccount.titleLabel.font = [UIFont systemFontOfSize:12.0];
    // 文字居左显示
    _currentAccount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _currentAccount.titleEdgeInsets = UIEdgeInsetsMake(0, inputH, 0, 0);
    // 边框
    _currentAccount.layer.borderWidth = 0.5;
    // 显示框背景色
    [_currentAccount setBackgroundColor:[UIColor whiteColor]];
    [_currentAccount addTarget:self action:@selector(openAccountList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_currentAccount];
    // 1.2图标
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, inputH-10, inputH-10)];
    _icon.layer.cornerRadius = (inputH-10)/2;
    [_icon setImage:[UIImage imageNamed:acc.avatar]];
    [_currentAccount addSubview:_icon];
    // 1.3下拉菜单弹出按钮
    UIButton *openBtn = [[UIButton alloc]initWithFrame:CGRectMake(inputW - inputH, 0, inputH, inputH)];
    [openBtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(openAccountList) forControlEvents:UIControlEventTouchUpInside];
    [_currentAccount addSubview:openBtn];
    
    // 2.设置账号弹出菜单(最后添加显示在顶层)
    _accountListVC = [[AccountTableViewController alloc] init];
    // 设置弹出菜单的代理为当前这个类
    _accountListVC.delegate = self;
    // 数据
    _accountListVC.accountSource = _dataSource;
    // 初始化frame
    [self updateListH];
    // 隐藏下拉菜单
    _accountListVC.view.frame = _listHiddenFrame;
    // 将下拉列表作为子页面添加到当前视图，同时添加子控制器
    [self addChildViewController:_accountListVC];
    [self.view addSubview:_accountListVC.view];
}

/**
 *  监听代理更新下拉菜单
 */
- (void)updateListH {
    CGFloat listH;
    // 数据大于3个现实3个半的高度，否则显示完整高度
    if (_dataSource.count > 3) {
        listH = inputH * 3.5;
    }else{
        listH = inputH * _dataSource.count;
    }
    _listFrame = CGRectMake(_currentAccount.frame.origin.x, _currentAccount.frame.origin.y + _currentAccount.frame.size.height, inputW, listH);
    _listHiddenFrame = CGRectMake(_currentAccount.frame.origin.x, _currentAccount.frame.origin.y + _currentAccount.frame.size.height, 0, 0);
    _accountListVC.view.frame = _listFrame;
}

/**
 * 弹出关闭账号选择列表
 */
- (void)openAccountList {
    _accountListVC.isOpen = !_accountListVC.isOpen;
    if(_accountListVC.isOpen){
        CGRect rect = CGRectMake(_currentAccount.frame.origin.x, _currentAccount.frame.origin.y + _currentAccount.frame.size.height, inputW, 0);
        _accountListVC.view.frame = rect;
        [UIView animateWithDuration:0.25 animations:^{
            _accountListVC.view.frame = _listFrame;
        }];
    }
    else{
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = CGRectMake(_currentAccount.frame.origin.x, _currentAccount.frame.origin.y + _currentAccount.frame.size.height, inputW, 0);
            _accountListVC.view.frame = rect;
        }];
    }
}

/**
 * 监听代理选定cell获取选中账号
 */
- (void)selectedCell:(NSInteger)index {
    // 更新当前选中账号
    AccountModel *acc = _dataSource[index];
    [_icon setImage:[UIImage imageNamed:acc.avatar]];
    [_currentAccount setTitle:acc.account forState:UIControlStateNormal];
    // 关闭菜单
    [self openAccountList];
}

@end

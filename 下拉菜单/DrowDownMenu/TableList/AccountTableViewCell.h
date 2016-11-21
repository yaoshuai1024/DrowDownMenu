//
//  AccountTableViewCell.h
//  DrowDownMenu
//
//  Created by yaoshuai on 2016/11/21.
//  Copyright © 2016年 yaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AccountModel;

@interface AccountTableViewCell : UITableViewCell

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *avatar;

/**
 *  账号
 */
@property (nonatomic, strong) UILabel *account;

@property (nonatomic, strong) AccountModel *accountModel;

@end

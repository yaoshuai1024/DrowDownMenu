//
//  AccountTableViewCell.m
//  DrowDownMenu
//
//  Created by yaoshuai on 2016/11/21.
//  Copyright © 2016年 yaoshuai. All rights reserved.
//

#import "AccountTableViewCell.h"
#import "AccountModel.h"

#define inputW 230 // 输入框宽度
#define inputH 35  // 输入框高度

@implementation AccountTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 头像
        _avatar = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, inputH-10, inputH-10)];
        _avatar.layer.cornerRadius = (inputH-10)/2;
        [self.contentView addSubview:_avatar];
        
        // 账号
        _account = [[UILabel alloc]initWithFrame:CGRectMake(inputH, 0, inputW - inputH, inputH)];
        _account.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_account];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setAccountModel:(AccountModel *)accountModel{
    _accountModel = accountModel;
    self.avatar.image = [UIImage imageNamed:accountModel.avatar];
    self.account.text = accountModel.account;
}

@end

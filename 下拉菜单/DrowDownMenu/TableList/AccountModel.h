//
//  AccountModel.h
//  DrowDownMenu
//
//  Created by yaoshuai on 2016/11/21.
//  Copyright © 2016年 yaoshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject

/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *avatar;

/**
 *  账号
 */
@property (nonatomic, copy) NSString *account;

/**
 *  密码
 */
@property (nonatomic, copy) NSString *password;

@end

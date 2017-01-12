//
//  SSKeychain+Helper.h
//  CDOTO
//
//  Created by yier on 15/12/7.
//  Copyright © 2015年 newdoone. All rights reserved.
//

#import <SSKeychain/SSKeychain.h>

@interface SSKeychain (Helper)

+ (NSString *)login;
+ (NSString *)password;
+ (NSString *)accessToken;

+ (BOOL)setLogin:(NSString *)login;
+ (BOOL)setPassword:(NSString *)password;
+ (BOOL)setAccessToken:(NSString *)accessToken;

+ (BOOL)deleteLogin;
+ (BOOL)deletePassword;
+ (BOOL)deleteAccessToken;


@end

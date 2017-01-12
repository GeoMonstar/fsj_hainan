//
//  SSKeychain+Helper.m
//  CDOTO
//
//  Created by yier on 15/12/7.
//  Copyright © 2015年 newdoone. All rights reserved.
//

#import "SSKeychain+Helper.h"

@implementation SSKeychain (Helper)

+ (NSString *)login {
    NSString * login = [self passwordForService:SSServer_Name account:SSLogin];
    if (login) {
        return login;
    }
    else
    {
        return @"";
    }
}

+ (NSString *)password {
    NSString * password = [self passwordForService:SSServer_Name account:SSPassword];
    if (password) {
        return password;
    }
    else
    {
        return @"";
    }
}

+ (NSString *)accessToken {
    NSString * password = [self passwordForService:SSServer_Name account:SSAccess_Token];
    if (password) {
        return password;
    }
    else
    {
        return @"";
    }
}

+ (BOOL)setLogin:(NSString *)login {
    return [self setPassword:login forService:SSServer_Name account:SSLogin];

}

+ (BOOL)setPassword:(NSString *)password {
    return [self setPassword:password forService:SSServer_Name account:SSPassword];
}

+ (BOOL)setAccessToken:(NSString *)accessToken {
    return [self setPassword:accessToken forService:SSServer_Name account:SSAccess_Token];
}

+ (BOOL)deleteLogin {
    return [self deletePasswordForService:SSServer_Name account:SSLogin];

}

+ (BOOL)deletePassword {
    return [self deletePasswordForService:SSServer_Name account:SSPassword];
}

+ (BOOL)deleteAccessToken {
    return [self deletePasswordForService:SSServer_Name account:SSAccess_Token];
}


@end

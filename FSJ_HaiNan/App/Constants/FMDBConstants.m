//
//  FMDBConstants.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/11.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import "FMDBConstants.h"


NSString *const CreatTable = @"\
DROP TABLE IF EXISTS User;\
DROP TABLE IF EXISTS System;\
\
CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY, jwt TEXT,userName TEXT,userId  TEXT,name  TEXT,photo Text,loginName Text,money Text);\
CREATE TABLE IF NOT EXISTS System (id INTEGER PRIMARY KEY, splashImageMD5 TEXT, splashImageURL TEXT)";

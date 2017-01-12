//
//  FMDatabaseQueue+Helper.h
//  CDOTO
//
//  Created by yier on 15/12/7.
//  Copyright © 2015年 newdoone. All rights reserved.
//

#import <FMDB/FMDB.h>
#import "FMDBConstants.h"

/**
 *不加密使用数据库
 */

@interface FMDatabaseQueue (Helper)

+ (instancetype)sharedInstance;

@end

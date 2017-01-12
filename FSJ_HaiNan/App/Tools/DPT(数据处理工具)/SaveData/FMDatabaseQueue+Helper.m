//
//  FMDatabaseQueue+Helper.m
//  CDOTO
//
//  Created by yier on 15/12/7.
//  Copyright © 2015年 newdoone. All rights reserved.
//

#import "FMDatabaseQueue+Helper.h"

@implementation FMDatabaseQueue (Helper)

+ (instancetype)sharedInstance {
    static FMDatabaseQueue *databaseQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseQueue = [FMDatabaseQueue databaseQueueWithPath:FMDB_Path];
    });
    return databaseQueue;
}

@end

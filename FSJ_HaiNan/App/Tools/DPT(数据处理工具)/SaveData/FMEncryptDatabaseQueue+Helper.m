//
//  FMEncryptDatabaseQueue+Helper.m
//  FmdbDemo
//
//  Created by yier on 15/12/10.
//  Copyright © 2015年 newdoone. All rights reserved.
//

#import "FMEncryptDatabaseQueue+Helper.h"

@implementation FMEncryptDatabaseQueue(Helper)

+ (instancetype)sharedInstance {
    
    static FMEncryptDatabaseQueue *databaseQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseQueue = (FMEncryptDatabaseQueue*)[FMDatabaseQueue databaseQueueWithPath:FMDB_Path];
    });
    
    return databaseQueue;
    
}
@end

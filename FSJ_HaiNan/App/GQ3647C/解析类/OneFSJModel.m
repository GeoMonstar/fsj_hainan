//
//  OneFSJModel.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/16.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import "OneFSJModel.h"

@implementation OneFSJModel


- (instancetype)initWithfsjHost:(NSString *)fsjHost
                     andfsjPort:(UInt16)fsjPort
                    andreadData:(NSData *)readData
                    andsendData:(NSData *)senddData{

        self = [super init];
        if (self) {
            self.fsjHost = fsjHost;
            self.fsjPort = fsjPort;
            ReadFrameBody *model = [[ReadFrameBody alloc]init];
            NSDictionary *dic =  [model responsReadDataWithData:readData andFSJID:fsjHost];
            self.bodyValueDic = [dic objectForKey:@"body"];
            self.headValueDic = [dic objectForKey:@"head"];
            self.sendData = senddData;
        }
        return self;

}
- (NSString *)getHeadbyParno:(NSString *)parno{
    for (NSString *key in self.headValueDic.allKeys) {
        if ([key isEqualToString:parno]) {
            return [self.headValueDic valueForKey:parno];
        }
    }
    return nil;
}


- (NSString *)getBodybyParno:(NSString *)parno{
    for (NSString *key in self.bodyValueDic.allKeys) {
        if ([key isEqualToString:parno]) {
            return [self.bodyValueDic valueForKey:parno];
        }
    }
    return nil;
}
- (NSDictionary *)getNameDic{
    
    NSMutableDictionary *mutDic = @{}.mutableCopy;
    NSDictionary *mapDic = (NSDictionary *)[[EGOCache globalCache]objectForKey:kMapDic];
    for (NSString *tempKey in self.bodyValueDic.allKeys) {
        for (NSString *mapKey  in mapDic.allKeys) {
            if ([mapKey isEqualToString:tempKey]) {
                [mutDic setObject:[self.bodyValueDic objectForKey:tempKey] forKey:[mapDic objectForKey:mapKey]];
                // [mutDic setObject:[mapDic objectForKey:mapKey] forKey:tempKey];
            }
        }
    }
    return mutDic;
    
}

- (void)updateFSJModel{
   FSJTcpSocketTool* tcptool = [[FSJTcpSocketTool alloc]init];
    tcptool.socketHost = self.fsjHost;
    tcptool.socketPort = self.fsjPort;
    [tcptool DisconnectSocket];
    [tcptool socketConHost];
    [tcptool tcpSendData:self.sendData];
    tcptool.reciveTcpDataBlock = ^(NSData *data,NSString *host,UInt16 port){
        //NSLog(@"recv data from %@:%d -- %@   %ld", host, port,str,str.length);
        OneFSJModel *model = [[OneFSJModel alloc]initWithfsjHost:host andfsjPort:port andreadData:data andsendData:self.sendData];
        //保存本地 可以加入数据了操作
        [[EGOCache globalCache]setObject:(OneFSJModel *)model forKey:host];
       // VVDLog(@"模型已经更新 == %@",[model getNameDic]);
    };
    
}
// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}
- (NSUInteger)hash {
    return [self yy_modelHash];
}
- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}
- (NSString *)description {
    return [self yy_modelDescription];
}

+ (OneFSJModel *)getOneFSJWithFsjID:(NSString *)fsjID{

    OneFSJModel *model = (OneFSJModel *)[[EGOCache globalCache]objectForKey:fsjID];

    return model;
}
@end

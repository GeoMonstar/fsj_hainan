//
//  OneFSJModel.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2017/1/16.
//  Copyright © 2017年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneFSJModel : NSObject<NSCoding>

@property (nonatomic, copy)NSString  *fsjHost;

@property (nonatomic, assign)UInt16  fsjPort;

/**
 *  保存返回数据
 */
@property (nonatomic, strong)NSDictionary  *bodyValueDic;

@property (nonatomic, strong)NSDictionary  *headValueDic;
/**
 *  保存发送数据
 */
@property (nonatomic, strong)NSData  *sendData;

- (instancetype)initOneFSJModelWithID:(NSString *)ID
                   andHeadValueDictionary:(NSDictionary *)HeadValuedictionary
                   andBodyValueDictionary:(NSDictionary *)BodyValuedictionary;
- (instancetype)initWithfsjHost:(NSString *)fsjHost
                     andfsjPort:(UInt16 )fsjPort
                    andreadData:(NSData *)readData
                    andsendData:(NSData *)senddData;


/**
 *  获取Head值
 *
 *  @param parno 参数序号
 *  @return 参数name
 */
- (NSString *)getHeadbyParno:(NSString *)parno;

/**
 *  获取Body值
 *
 *  @param parno 参数序号
 *  @return 参数值
 */
- (NSString *)getBodybyParno:(NSString *)parno;
/**
 *  获取Body值 汉字名称
 *
 *  @return Key为name的字典
 */
- (NSDictionary *)getNameDic;
/**
 *  获取Body值 汉字名称
 *
 *  @return Key为name的字典
 */
- (void)updateFSJModel;
@end

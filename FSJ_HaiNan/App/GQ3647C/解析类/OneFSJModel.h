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
 *  @brief 保存返回数据
 */
@property (nonatomic, strong)NSDictionary  *bodyValueDic;

@property (nonatomic, strong)NSDictionary  *headValueDic;
/**
 *  @brief 保存发送数据
 */
@property (nonatomic, strong)NSData  *sendData;

- (instancetype)initWithfsjHost:(NSString *)fsjHost
                     andfsjPort:(UInt16 )fsjPort
                    andreadData:(NSData *)readData
                    andsendData:(NSData *)senddData;


/**
 *  @brief 获取Head值
 *
 *  @param parno 参数序号
 *  @return 参数name
 */
- (NSString *)getHeadbyParno:(NSString *)parno;

/**
 *  @brief 获取Body值
 *
 *  @param parno 参数序号
 *  @return 参数值
 */
- (NSString *)getBodybyParno:(NSString *)parno;
/**
 *  @brief 获取Body值 汉字名称
 *
 *  @return Key为name的字典
 */
- (NSDictionary *)getNameDic;
/**
 *  @brief 根据发射机host获取模型
 *
 *  @param  fsjID 发射机host
 *
 *  @return 发射机模型
 */
+ (OneFSJModel *)getOneFSJWithFsjID:(NSString *)fsjID;
/**
 *  更新发射机
 *
 */
- (void)updateFSJModel;

@end

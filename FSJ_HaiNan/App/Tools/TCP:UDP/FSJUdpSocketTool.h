//
//  FSJUdpSocketTool.h
//  FSJ
//
//  Created by Monstar on 2016/12/6.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncUdpSocket.h"



typedef void(^ReciveDataBlock)(NSData *data,NSString *host,UInt16 prot);

@interface FSJUdpSocketTool : NSObject<AsyncUdpSocketDelegate>
/**
 *  udpSocket
 */
@property (nonatomic, strong)   AsyncUdpSocket *udpSocket;
/**
 *  接收udp数据Block
 */
@property (nonatomic, copy)     ReciveDataBlock reciveDataBlock;
/**
 *  ip地址
 */
@property (nonatomic, copy)     NSString *hostAddress;
/**
 *  端口号
 */
@property (nonatomic, assign)   UInt16    serverPort;

+ (FSJUdpSocketTool *)sharedInstance;
/**
 *  UDP连接
 */
- (void)socketConnectHost;
/**
 *  UDP断开连接
 */
- (void)cutOffSocket;
/**
 *  UDP发送数据
 *
 *  @param data 数据
 */
- (void)udpSendData:(NSData *) data;



/*
 功能需求:建立多个udp/tcp连接
 功能分析:多个udp连接
 点击注册 - 获得ip和端口号 - udptool - addsocket 
 */

@end

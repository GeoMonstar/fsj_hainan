//
//  FSJTcpSocketTool.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/12.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
enum {
    SocketServerDrops, //服务器掉线
    SocketUserDrops,   //用户主动掉线
    SocketWIFIDrops,   //wifi
};
typedef void(^ReciveTcpDataBlock)(NSData *data,NSString *host,UInt16 prot);

@interface FSJTcpSocketTool : NSObject<AsyncSocketDelegate>
/**
 *  tcpSocket
 */
@property (nonatomic, strong)   AsyncSocket *tcpSocket;
/**
 *  接收tcp数据Block
 */
@property (nonatomic, copy)     ReciveTcpDataBlock reciveTcpDataBlock;
/**
 *  ip地址
 */
@property (nonatomic, copy)     NSString  *socketHost;
/**
 *  端口号
 */
@property (nonatomic, assign)   UInt16  socketPort;
/**
 *  长连接计时器
 */
@property (nonatomic, strong)   NSTimer *socketTimer;

+ (FSJTcpSocketTool *)sharedInstance;
/**
 *  TCP连接
 */
- (void)socketConHost;
/**
 *  TCP发送数据
 *
 *  @param data 数据
 */
- (void)tcpSendData:(NSData *)data;
/**
 *  TCP断开连接
 */
- (void)DisconnectSocket;


@end

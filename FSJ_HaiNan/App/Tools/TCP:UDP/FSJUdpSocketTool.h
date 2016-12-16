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

@property (nonatomic, copy)     ReciveDataBlock reciveDataBlock;
@property (nonatomic, strong)   AsyncUdpSocket *udpSocket;
@property (nonatomic, copy)     NSString *hostAddress;
@property (nonatomic, assign)   UInt16    serverPort;

+ (FSJUdpSocketTool *)sharedInstance;
/*
 *  socket 连接
 */
- (void)socketConnectHost;
/*
 *  断开socket连接
 */
- (void)cutOffSocket;
/*
 *  发送数据
 */
- (void)sendMsg:(NSData *) data;


@end

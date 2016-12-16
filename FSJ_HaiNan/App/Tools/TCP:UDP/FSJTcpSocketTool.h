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

@property (nonatomic, strong)   AsyncSocket *tcpSocket;
@property (nonatomic, strong)   NSTimer *socketTimer;
@property (nonatomic, copy)     NSString  *socketHost;
@property (nonatomic, assign)   UInt16  socketPort;
@property (nonatomic, copy)     ReciveTcpDataBlock  reciveTcpDataBlock;

+ (FSJTcpSocketTool *)sharedInstance;
- (void)tcpSendData:(NSData *)data;
- (void)socketConHost;
- (void)DisconnectSocket;


@end

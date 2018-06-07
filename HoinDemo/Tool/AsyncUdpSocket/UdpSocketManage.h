//
//  UdpSocketManage.h
//  HoinDemo
//
//  Created by 帝青的Mac on 2018/6/7.
//  Copyright © 2018年 帝青的Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncUdpSocket.h"
#import <CommonCrypto/CommonDigest.h>


typedef void(^returnReciveBlock)(NSString *reciveStr);

@interface UdpSocketManage : NSObject<AsyncUdpSocketDelegate>

@property (nonatomic, strong) AsyncUdpSocket *reciveSocket;

@property (nonatomic, strong) AsyncUdpSocket *sendSocket;

@property (nonatomic, strong) NSString *socketHost;

@property (nonatomic, strong) NSTimer *heartBeatTimer;

@property (nonatomic, copy) returnReciveBlock block;

+ (UdpSocketManage *)sharedInstance;

- (void)socketConnectHost;

- (void)cutOffSocket;

- (void)sendMessageWithString:(NSString *)text;

- (void)returnReciveBlock:(returnReciveBlock)block;

@end

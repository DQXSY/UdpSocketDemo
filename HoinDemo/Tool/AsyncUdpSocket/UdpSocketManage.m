//
//  UdpSocketManage.m
//  HoinDemo
//
//  Created by 帝青的Mac on 2018/6/7.
//  Copyright © 2018年 帝青的Mac. All rights reserved.
//

#import "UdpSocketManage.h"
#import "IPHelper.h"

@implementation UdpSocketManage

static UdpSocketManage *sharedInstance = nil;
+ (UdpSocketManage *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (void)socketConnectHost
{
    //收
    self.reciveSocket = [[AsyncUdpSocket alloc] initIPv4];
    [self.reciveSocket setDelegate:self];
    [self.reciveSocket bindToPort:1917 error:nil];
    [self.reciveSocket receiveWithTimeout:-1 tag:0];

    //发
    self.sendSocket = [[AsyncUdpSocket alloc] initIPv4];
    [self.sendSocket setDelegate:self];
    [self.sendSocket connectToHost:self.socketHost onPort:1918 error:nil];
    [self.sendSocket enableBroadcast:YES error:nil];
//    [self.sendSocket joinMulticastGroup:@"255.255.255.255" error:nil];

    self.heartBeatTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(heartBeatToSocket) userInfo:nil repeats:YES];
    [self.heartBeatTimer fire];

}

- (void)cutOffSocket {
    [self.sendSocket close];
    [self.reciveSocket close];
}

- (void)heartBeatToSocket
{
    NSString *heartBeat = @"heartBeat";
    NSData *sendData = [heartBeat dataUsingEncoding:NSUTF8StringEncoding];
    if ([self.sendSocket sendData:sendData toHost:@"255.255.255.255" port:1917 withTimeout:-1 tag:1]) {
        NSLog(@"发送指令成功");
    }else {
        NSLog(@"发送指令失败");
    }
    [self.sendSocket receiveWithTimeout:-1 tag:1];
    [self.reciveSocket receiveWithTimeout:-1 tag:0];
}

- (void)sendMessageWithString:(NSString *)text
{
    NSData *sendData = [text dataUsingEncoding:NSUTF8StringEncoding];
    if ([self.sendSocket sendData:sendData toHost:self.socketHost port:1917 withTimeout:-1 tag:1]) {
        NSLog(@"发送指令成功");
    }else {
        NSLog(@"发送指令失败");
    }
    [self.sendSocket receiveWithTimeout:-1 tag:1];
    [self.reciveSocket receiveWithTimeout:-1 tag:0];
}

#pragma mark - AsyncUDPSocketDelegate
- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    //!<信息发送成功
}

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    //过滤来自本机的消息 继续监听接收消息
    NSString *IPAdress = host;
    if ([IPAdress isEqualToString:[IPHelper deviceIPAdress]]) {
        [self.reciveSocket receiveWithTimeout:-1 tag:0];
        return YES;
    }

    self.socketHost = host;
    //!<接收到了信息  在这里解包
    NSString *reciveStr  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([reciveStr isEqualToString:@"heartBeat"]) {
        [self heartBeatTimer];//收到心跳包后回应一个心跳包
    }else {
        if (self.block) {
            self.block(reciveStr);
        }
    }
    return YES;
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"发送失败：%@",error);
}

-(void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"接受失败：%@",error);
}

#pragma mark - block
- (void)returnReciveBlock:(returnReciveBlock)block
{
    self.block = block;
}

@end

//
//  UDPDemoController.m
//  HoinDemo
//
//  Created by 帝青的Mac on 2018/6/7.
//  Copyright © 2018年 帝青的Mac. All rights reserved.
//

#import "UDPDemoController.h"
#import "UdpSocketManage.h"

@interface UDPDemoController ()

@property (nonatomic, strong) UIView *sendView;

@property (nonatomic, strong) UITextField *sendTF;

@property (nonatomic, strong) UIButton *sendBt;

@property (nonatomic, strong) UILabel *receiveL;

@end

@implementation UDPDemoController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[UdpSocketManage sharedInstance] socketConnectHost];
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI
{
    self.navigationItem.title = LocalString(@"UDPDemo");
    self.view.backgroundColor = KBackgroundColor;

    [self.view addSubview:self.sendView];
    [self.sendView addSubview:self.sendTF];
    [self.view addSubview:self.sendBt];
    [self.view addSubview:self.receiveL];

    [[UdpSocketManage sharedInstance] returnReciveBlock:^(NSString *reciveStr) {

        self.receiveL.text = reciveStr;
    }];
}

- (UIView *)sendView
{
    if (!_sendView) {

        _sendView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _sendView.backgroundColor = KWhiteColor;
    }
    return _sendView;
}

- (UITextField *)sendTF
{
    if (!_sendTF) {
        _sendTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, 40)];
        _sendTF.borderStyle = UITextBorderStyleNone;
        _sendTF.placeholder = LocalString(@"要发送的内容");
        _sendTF.keyboardType = UIKeyboardTypeDefault;
    }
    return _sendTF;
}

- (UIButton *)sendBt
{
    if (!_sendBt) {

        _sendBt = [[UIButton alloc] initWithFrame:CGRectMake(0, self.sendView.bottom + 20, SCREEN_WIDTH, KButtonHeihgt)];
        [_sendBt setBackgroundColor:RandomColor];
        [_sendBt setTitle:LocalString(@"发送") forState:UIControlStateNormal];
        [_sendBt setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_sendBt addTarget:self action:@selector(sendBtClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBt;
}

- (UILabel *)receiveL
{
    if (!_receiveL) {

        _receiveL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.sendBt.bottom + 20, SCREEN_WIDTH, KButtonHeihgt)];
        _receiveL.backgroundColor = [UIColor lightGrayColor];
        _receiveL.textAlignment = NSTextAlignmentCenter;
        _receiveL.textColor = KWhiteColor;
        _receiveL.font = kFontSystem(16);
    }
    return _receiveL;
}

#pragma mark - Click
- (void)sendBtClick
{
    if ([UdpSocketManage sharedInstance].socketHost == nil && [[UdpSocketManage sharedInstance].socketHost isEqualToString:@""]) {

        [self showMessage:@"请连接--"];
    }else {
        [[UdpSocketManage sharedInstance] sendMessageWithString:self.sendTF.text];
    }
}

@end

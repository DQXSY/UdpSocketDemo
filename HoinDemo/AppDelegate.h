//
//  AppDelegate.h
//  HoinDemo
//
//  Created by 帝青的Mac on 2018/5/28.
//  Copyright © 2018年 帝青的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MainTableController *mainVc;

+ (AppDelegate *)sharedAppDelegate;

- (void)showMainTableVc;

@end


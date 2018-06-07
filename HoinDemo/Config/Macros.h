//
//  Macros.h
//  HoinDemo
//
//  Created by 帝青的Mac on 2018/5/28.
//  Copyright © 2018年 帝青的Mac. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#pragma mark - LocalString
#define LocalString(str) NSLocalizedString(str,@"")

#pragma mark - Color
#define RGBColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RandomColor     [UIColor colorWithHue:( arc4random() % 256 / 256.0 ) saturation:(( arc4random() % 128 / 256.0 ) + 0.5) brightness:(( arc4random() % 128 / 256.0 ) + 0.5) alpha:1]
#define KNavColor           RGBColor(0,0,0,1)
#define KWhiteColor         RGBColor(255,255,255,1)
#define KClearColor         [UIColor clearColor]
#define KBackgroundColor    RGBColor(238,238,238,1)
#define KTintColor          RGBColor(0,0,0,1)


#pragma mark - Font
#define kFontSystem(size)     [UIFont systemFontOfSize:size]

#pragma mark - UIScreen
#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE5           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define UI_IS_IPHONE6           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define UI_IS_IPHONE6PLUS       (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define UI_IS_IPhoneNewX        (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)
#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height
#define KStaHeight      (UI_IS_IPhoneNewX?44:20)
#define KNavHeight       44
#define KStaAndNavHeight (UI_IS_IPhoneNewX?88:64)
#define KTabBarHeight    (UI_IS_IPhoneNewX?83:49)
#define KButtonHeihgt    (UI_IS_IPhoneNewX || UI_IS_IPHONE6PLUS || UI_IS_IPHONE6?42:40)




#endif /* Macros_h */

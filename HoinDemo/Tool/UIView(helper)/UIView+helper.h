//
//  UIView+helper.h
//  Fangmm
//
//  Created by luo on 16/5/23.
//  Copyright © 2016年 Ymz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (helper)

- (void)cutWithCnRadius:(CGFloat)radius BdW:(CGFloat)width BdC:(UIColor *)color;

- (void)showShadowWithColor:(UIColor *)color Offset:(CGSize)offset Opacity:(CGFloat)opacity Radius:(CGFloat)radius;

- (void)cutWithRectCorner:(UIRectCorner)corner Radius:(CGFloat)radius;

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

- (UIImage *)snapshot;

@end

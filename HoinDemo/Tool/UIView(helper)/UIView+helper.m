//
//  UIView+helper.m
//  Fangmm
//
//  Created by luo on 16/5/23.
//  Copyright © 2016年 Ymz. All rights reserved.
//

#import "UIView+helper.h"

@implementation UIView (helper)

- (void)cutWithCnRadius:(CGFloat)radius BdW:(CGFloat)width BdC:(UIColor *)color
{
    self.layer.cornerRadius  = radius;
    self.layer.borderWidth   = width;
    if (color) {
        self.layer.borderColor   = color.CGColor;
    }
    self.layer.masksToBounds = YES;
}

- (void)showShadowWithColor:(UIColor *)color Offset:(CGSize)offset Opacity:(CGFloat)opacity Radius:(CGFloat)radius
{
    self.layer.shadowColor  = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity= opacity;
    self.layer.shadowRadius = radius;
}

- (void)cutWithRectCorner:(UIRectCorner)corner Radius:(CGFloat)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

- (UIImage *)snapshot
{
    CGRect rect = self.bounds;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //该方法相当于把原来位于(0, 0)位置的坐标原点平移到(tx, ty)点。在平移后的坐标系统上绘制图形时，所有坐标点的 X 坐标都相当于增加了 tx，所有点的 Y 坐标都相当于增加了 ty。
    CGContextTranslateCTM(currentContext, - CGRectGetMinX(rect), - CGRectGetMinY(rect));
    [self.layer renderInContext:currentContext];
    
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return snapshotImage;
    
    //    UIImageView *snapshotView = [[UIImageView alloc] initWithFrame:rect];
    //
    //    snapshotView.image = [snapshotImage resizableImageWithCapInsets:capInsets];
    //
    //    return snapshotView.image;
}
@end

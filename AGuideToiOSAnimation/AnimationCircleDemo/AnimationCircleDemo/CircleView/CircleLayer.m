//
//  CircleLayer.m
//  AnimationCircleDemo
//
//  Created by LX on 17/3/20.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "CircleLayer.h"
#import <UIKit/UIKit.h>
typedef enum Movingpoint{
    POINT_B,
    POINT_D,
} Movingpoint;

#define outsideRectSize 90

@interface CircleLayer ()
@property (nonatomic, assign)CGRect outsideRect;
@property (nonatomic, assign)CGFloat lastProgress;
@property (nonatomic, assign)Movingpoint movePoint;
@end

@implementation CircleLayer
- (instancetype)init{
    if (self=[super  init]) {
        self.lastProgress=0.5;
        
    }
    return self;
}

- (instancetype)initWithLayer:(CircleLayer*)layer{
    if (self=[super initWithLayer:layer]) {
        self.progress=layer.progress;
        self.outsideRect=layer.outsideRect;
        self.lastProgress=layer.lastProgress;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress{
    _progress=progress;//属性直接访问
    if (progress<=0.5) {
        NSLog(@"B点不动");
        self.movePoint= POINT_D;
    }else{
        NSLog(@"D点不动");
        self.movePoint=POINT_B;
    }
    self.lastProgress=progress;
    CGFloat origin_x=self.position.x-outsideRectSize/2+(progress-0.5)*(self.frame.size.width-outsideRectSize);
    CGFloat origin_y = self.position.y - outsideRectSize/2;
    
    self.outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize);
    [self setNeedsDisplay];//自动调用DrawInContext
}

- (void)drawInContext:(CGContextRef)ctx{//
    CGFloat offset=self.outsideRect.size.width/3.6;
    CGFloat moveDistance=(self.outsideRect.size.width*1/6)*fabs(self.progress-0.5)*2;
    CGPoint rectCenter=CGPointMake(self.outsideRect.origin.x+self.outsideRect.size.width/2, self.outsideRect.origin.y+self.outsideRect.size.height/2);
    CGPoint A=CGPointMake(rectCenter.x, self.outsideRect.origin.y+moveDistance);
    CGPoint B=CGPointMake(self.movePoint==POINT_B?rectCenter.x+self.outsideRect.size.width/2+moveDistance*2:rectCenter.x+self.outsideRect.size.width/2, rectCenter.y);
    CGPoint C=CGPointMake(rectCenter.x, rectCenter.y+self.outsideRect.size.height/2-moveDistance);
    CGPoint D=CGPointMake(self.movePoint==POINT_B?self.outsideRect.origin.x:self.outsideRect.origin.x-moveDistance*2, rectCenter.y);
    CGPoint c1=CGPointMake(A.x+offset, A.y);
    CGPoint c2=CGPointMake(B.x, self.movePoint==POINT_B?B.y-offset+moveDistance:B.y-offset);
    CGPoint c3=CGPointMake(B.x, self.movePoint==POINT_B?B.y+offset-moveDistance:B.y+offset);
    CGPoint c4=CGPointMake(C.x+offset, C.y);
    CGPoint c5=CGPointMake(C.x-offset, C.y);
    CGPoint c6=CGPointMake(D.x, self.movePoint==POINT_B?D.y+offset:D.y+offset-moveDistance);
    CGPoint c7=CGPointMake(D.x, self.movePoint==POINT_B?D.y-offset:D.y-offset+moveDistance);
    CGPoint c8=CGPointMake(A.x-offset, A.y);
    
    //外界虚线矩形
    UIBezierPath * rectPath=[UIBezierPath bezierPath];
    CGContextAddPath(ctx, rectPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGFloat dash[]={5.0,5.0};
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextSetLineDash(ctx, 0.0, dash, 2);
    CGContextStrokePath(ctx);
    //
    UIBezierPath * ovalPath=[UIBezierPath bezierPath];
    [ovalPath moveToPoint:A];
    [ovalPath addCurveToPoint:B controlPoint1:c1 controlPoint2:c2];
    [ovalPath addCurveToPoint:C controlPoint1:c3 controlPoint2:c4];
    [ovalPath addCurveToPoint:D controlPoint1:c5 controlPoint2:c6];
    [ovalPath addCurveToPoint:A controlPoint1:c7 controlPoint2:c8];
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    CGContextDrawPath(ctx, kCGPathFillStroke); //同时给线条和线条包围的内部区域填充颜色
    //连接辅助线
    UIBezierPath *helperline = [UIBezierPath bezierPath];
    [helperline moveToPoint:A];
    [helperline addLineToPoint:c1];
    [helperline addLineToPoint:c2];
    [helperline addLineToPoint:B];
    [helperline addLineToPoint:c3];
    [helperline addLineToPoint:c4];
    [helperline addLineToPoint:C];
    [helperline addLineToPoint:c5];
    [helperline addLineToPoint:c6];
    [helperline addLineToPoint:D];
    [helperline addLineToPoint:c7];
    [helperline addLineToPoint:c8];
    [helperline closePath];
    
    CGContextAddPath(ctx, helperline.CGPath);
    
    CGFloat dash2[] = {2.0, 2.0};
    CGContextSetLineDash(ctx, 0.0, dash2, 2);
    CGContextStrokePath(ctx); //给辅助线条填充颜色
}
@end

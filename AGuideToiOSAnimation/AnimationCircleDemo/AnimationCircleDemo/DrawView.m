//
//  DrawView.m
//  AnimationCircleDemo
//
//  Created by LX on 17/3/20.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath * _path=[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];
    CGContextRef ref=UIGraphicsGetCurrentContext();
    CGContextAddPath(ref, _path.CGPath);
    CGContextSetFillColorWithColor(ref, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(ref, [UIColor blackColor].CGColor);
    CGFloat dash[]={10,10};
    CGContextSetLineDash(ref, 0.0, dash, 2);
    
    CGContextDrawPath(ref, kCGPathFillStroke);
    
    //和CASHAperLayer里的方法相似，但是不可以做动画了！
    
}


@end

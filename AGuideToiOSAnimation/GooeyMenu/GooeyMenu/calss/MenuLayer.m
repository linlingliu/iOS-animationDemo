//
//  MenuLayer.m
//  GooeyMenu
//
//  Created by LX on 17/4/13.
//  Copyright © 2017年 LX. All rights reserved.
//
/*
 通过CAKeyFrameAnimation来改变一个layer的自定义的属性，在这个layer的类中监听此属性的变化，一旦改属性发生变化，立即重绘
 */
#import "MenuLayer.h"
#define OFF 30

@implementation MenuLayer


- (instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}

- (instancetype)initWithLayer:(MenuLayer*)layer{
    if (self=[super initWithLayer:layer]) {
      //在这里拷贝layer的所有属性
        self.showDebug=layer.showDebug;
        self.xAxisPercent=layer.xAxisPercent;
        self.animState=layer.animState;
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key{// 重绘layer的自定义属性
    if ([key isEqualToString:@"xAxisPercent"]) {
        return YES;
    }
    return [super needsDisplayForKey: key];
}

- (void)drawInContext:(CGContextRef)ctx{
    CGRect real_rect=CGRectInset(self.frame, OFF, OFF);
    CGFloat offset=real_rect.size.width/3.6;
    CGPoint center=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    CGFloat moveDistance_1;
    CGFloat move_Distance_2;
    CGPoint top_left;
    CGPoint top_center;
    CGPoint top_right;
    if (_animState==STATE1) {
        moveDistance_1=_xAxisPercent*((real_rect.size.width-offset)/2);
        top_left=CGPointMake(center.x-offset-moveDistance_1*2, OFF);
        top_center=CGPointMake(center.x-moveDistance_1, OFF);
        top_right=CGPointMake(center.x+offset, OFF);
    }else if (_animState==STATE2){
        CGFloat heighFactor;
        if (_xAxisPercent>=0.2) {
            heighFactor=1-_xAxisPercent;
        }else{
            heighFactor=_xAxisPercent;
        }
        
    }
}
@end

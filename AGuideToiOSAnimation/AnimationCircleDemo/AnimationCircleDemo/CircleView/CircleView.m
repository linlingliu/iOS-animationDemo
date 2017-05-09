//
//  CircleView.m
//  AnimationCircleDemo
//
//  Created by LX on 17/3/20.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

+(Class)layerClass{
    return [CircleLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.circleLayer=[CircleLayer layer];
        self.circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.circleLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:self.circleLayer];
    }
    return self;
}

@end

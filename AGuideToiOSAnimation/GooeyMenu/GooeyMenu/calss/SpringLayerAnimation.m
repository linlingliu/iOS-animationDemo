//
//  SpringLayerAnimation.m
//  GooeyMenu
//
//  Created by LX on 2017/4/14.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "SpringLayerAnimation.h"

@implementation SpringLayerAnimation

+ (instancetype)sharedAnimManager{
    static SpringLayerAnimation *managerAnima=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerAnima=[[SpringLayerAnimation alloc]init];
    });
    return managerAnima;
}

- (CAKeyframeAnimation*)createBasicAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)frmoValue toValue:(id)toValue{
    CAKeyframeAnimation * _keyAnima=[CAKeyframeAnimation animationWithKeyPath:keypath];//可以定义动画的过程
    _keyAnima.values=[self basicAniamtionValues:frmoValue toValue:toValue duration:duration];
    _keyAnima.duration=duration;
    _keyAnima.removedOnCompletion=NO;
    _keyAnima.fillMode=kCAFillModeForwards;
    return _keyAnima;
}

- (CAKeyframeAnimation *)createSpringAnima:(NSString *)keypath duration:(CFTimeInterval)duration Damping:(CGFloat)damping initialVelocity:(CGFloat)velocity fromValue:(id)fromValue toValue:(id)toValue{
    CGFloat dampingFactor  = 10.0;
    CGFloat velocityFactor = 10.0;
    NSMutableArray *values = [self springAnima:fromValue toValue:toValue Damping:dampingFactor velocity:velocityFactor duration:duration];
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    anim.values = values;
    anim.duration = duration;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    return anim;
}


- (CAKeyframeAnimation *)createCurveAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    anim.values = [self curveAnimationValues:fromValue toValue:toValue duration:duration];
    anim.duration = duration;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    return anim;
}

- (CAKeyframeAnimation *)createHelfCurveAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    anim.values = [self halfCurveAnimationValues:fromValue toValue:toValue duration:duration];
    anim.duration = duration;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    return anim;
}

#pragma mark-- helper Method
- (NSMutableArray *)basicAniamtionValues:(id)fromVlaue toValue:(id)toValue duration:(CGFloat)duration{
    NSInteger numOfFrame=60*duration;//帧,1秒钟刷新60次
    NSMutableArray * values=[NSMutableArray arrayWithCapacity:numOfFrame];
    for (NSInteger i=0; i<numOfFrame; i++) {
        [values addObject:@(0.0)];//初始化
    }
    CGFloat diff=[toValue floatValue]- [fromVlaue floatValue];
    for (NSInteger frame=0; frame<numOfFrame; frame++) {
        CGFloat x=(CGFloat)(frame)/numOfFrame;
        CGFloat value=[fromVlaue floatValue]+diff*x;
        values[frame]=@(value);
    }
    return values;
}

- (NSMutableArray *)springAnima:(id)fromValue toValue:(id)toValue Damping:(CGFloat)damping velocity:(CGFloat)velocity duration:(CGFloat)duration{
    //60个关键帧
    CGFloat numOfFrame=duration*60;
    NSMutableArray * _values=[NSMutableArray arrayWithCapacity:numOfFrame];
    for (int i=0;i<numOfFrame ; i++) {
        [_values addObject:@(0.0)];
    }
    CGFloat diff=[toValue floatValue]-[fromValue floatValue];
    for (NSInteger frame=0; frame<numOfFrame; frame++) {
        CGFloat x=(CGFloat)frame/(CGFloat)numOfFrame;
        CGFloat value=[toValue floatValue]-diff*(pow(M_E, -damping*x)*cos(velocity*x));//y = 1-e^{-5x} * cos(30x)
        _values[frame]=@(value);
    }
    return _values;
}

-(NSMutableArray *) halfCurveAnimationValues:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration{
    NSInteger numOfFrames = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfFrames];
    for (NSInteger i = 0; i < numOfFrames; i++) {
        [values addObject:@(0.0)];
    }
    
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger frame = 0; frame<numOfFrames; frame++) {
        
        CGFloat x = (CGFloat)frame / (CGFloat)numOfFrames;
        CGFloat value = [fromValue floatValue] + diff * (-x *(x-2));
        values[frame] = @(value);
    }
    return values;
}


-(NSMutableArray *) curveAnimationValues:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration{
    NSInteger numOfFrames = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfFrames];
    for (NSInteger i = 0; i < numOfFrames; i++) {
        [values addObject:@(0.0)];
    }
    
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger frame = 0; frame<numOfFrames; frame++) {
        
        CGFloat x = (CGFloat)frame / (CGFloat)numOfFrames;
        CGFloat value = [fromValue floatValue] + diff * (-4* x *(x-1));
        values[frame] = @(value);
    }
    return values;
}
@end

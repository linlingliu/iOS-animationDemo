//
//  SpringLayerAnimation.h
//  GooeyMenu
//
//  Created by LX on 2017/4/14.
//  Copyright © 2017年 LX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SpringLayerAnimation : NSObject

+(instancetype)sharedAnimManager;

//normal Anim --线性函数
- (CAKeyframeAnimation *)createBasicAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)frmoValue toValue:(id)toValue;

//弹性动画
- (CAKeyframeAnimation *)createSpringAnima:(NSString *)keypath duration:(CFTimeInterval)duration Damping:(CGFloat)damping initialVelocity:(CGFloat)velocity fromValue:(id)fromValue toValue:(id)toValue;

//Curve anim 二次平滑抛物函数
- (CAKeyframeAnimation *)createCurveAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue;

//Curve anim 抛到一半的二次平滑抛物函数
- (CAKeyframeAnimation *)createHelfCurveAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue;
@end

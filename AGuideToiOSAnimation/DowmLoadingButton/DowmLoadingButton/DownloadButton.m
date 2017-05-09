//
//  DownloadButton.m
//  DowmLoadingButton
//
//  Created by LX on 17/4/10.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "DownloadButton.h"

@implementation DownloadButton{
    BOOL animating;
    CGRect originFrame;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpSomething];
    }
    return self;
}

- (void)setUpSomething{
    UITapGestureRecognizer * _tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:_tap];
}


#pragma mark --UItapGesture

- (void)tapped:(UITapGestureRecognizer *)tapped{
    originFrame=self.frame;
    if (animating==YES) {
        return;
    }
    for (CALayer * subLayer in self.layer.sublayers) {
        [subLayer removeFromSuperlayer];
    }
    self.backgroundColor = [UIColor colorWithRed:0.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    
    animating = YES;
    //这个不是正确的方式，正确的方式是先改变model layer的属性，然后动画
    //    radiusAnimation.fillMode = kCAFillModeForwards;
    //    radiusAnimation.removedOnCompletion = NO;
    //WWDC 2011 视频 http://adcdownload.apple.com/videos/wwdc_2011__sd/session_421__core_animation_essentials.m4v
    self.layer.cornerRadius=self.progressBarHeight/2;
    //注意：［UIView aniamtion］的方法里只能对UIView的属性进行动画，对于layer的属性是无效的。比如你在这里想让self.animationView.layer.cornRadius=50,是什么任何意义的。无法做啦也让的动画，必须使用coreAniamtion
    CABasicAnimation * _radius=[CABasicAnimation animationWithKeyPath:@"cornRadius"];
    _radius.duration=0.2f;
    _radius.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    _radius.fromValue=@(originFrame.size.height/2);
    //不需要设置tovalue了,没有tovalue动画就运动到fromValue的状态
    _radius.delegate=self;
    [self.layer addAnimation:_radius forKey:@"cornRadiusAniamtion"];
}

- (void)animationDidStart:(CAAnimation *)anim{
    //这里介绍两种方式区分不同的anim 1、对于加在一个全局变量上的anima，比如例子里的self.AnimateView ，这是一个全局变量，所以我们在这里可以通过[self.AnimateView.layer animationForKey:]根据动画不同的key来区分
    //2、然而对于一个非全局的变量，比如demo中的progressLayer，可以用KVO:[pathAnimation setValue:@"strokeEndAnimation" forKey:@"animationName"];注意这个animationName是我们自己设定的。
    if ([anim isEqual:[self.layer animationForKey:@"cornRadiusAniamtion"]]) {
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bounds=CGRectMake(0, 0, _progressBarWidth, _progressBarHeight);//改变view的bounds，bounds(x,y)=(0,0),宽度和高度向两边均匀增加（减少），frame的x,y会变为原来的增加（减少）宽度和高度的一半；bounds(x,y)！=(0,0)，frame还是和上边一样变化，可见视图重新显示！总结：bounds的宽和高变化，frame的x,y会相应的变化
        } completion:^(BOOL finished) {
            [self.layer removeAllAnimations];
            [self progressBarAniamtion];
        }];
    }else if ([anim isEqual:[self.layer animationForKey:@"ExpandAniamtion"]]){
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.bounds=CGRectMake(0, 0, originFrame.size.width, originFrame.size.height);
            self.backgroundColor = [UIColor colorWithRed:0.1803921568627451 green:0.8 blue:0.44313725490196076 alpha:1.0];
        } completion:^(BOOL finished) {
            [self.layer removeAllAnimations];
            [self checkAniamtion];
            animating=NO;
        }];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"progressBarAnimation"]) {
        [UIView animateWithDuration:0.3 animations:^{
            for (CALayer * Layer in self.layer.sublayers) {
                [Layer removeFromSuperlayer];
            }
        } completion:^(BOOL finished) {
            if (finished) {
                for (CALayer *subLayer in self.layer.sublayers) {
                    [subLayer removeFromSuperlayer];
                }
                self.layer.cornerRadius=originFrame.size.height/2;
                CABasicAnimation * _radiusExpand=[CABasicAnimation animationWithKeyPath:@"cornerRadius"];
                _radiusExpand.duration=0.2f;
                _radiusExpand.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                _radiusExpand.fromValue=@(_progressBarHeight/2);
                _radiusExpand.delegate=self;
                [self.layer addAnimation:_radiusExpand forKey:@"ExpandAniamtion"];
            }
        }];
    }else if ([[anim valueForKey:@"animationName"] isEqualToString:@"checkAnimation"]){
        [self.layer removeAllAnimations];
        for (CALayer *subLayer in self.layer.sublayers) {
            [subLayer removeFromSuperlayer];
        }
    }
}


#pragma mark progress

- (void)progressBarAniamtion{
    CAShapeLayer * _progressLayer=[CAShapeLayer layer];
    UIBezierPath * _path=[UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(_progressBarHeight/2, self.bounds.size.height/2)];
    [_path addLineToPoint:CGPointMake(self.bounds.size.width-_progressBarHeight/2, self.bounds.size.height/2)];
    _progressLayer.path=_path.CGPath;
    _progressLayer.strokeColor=[UIColor whiteColor].CGColor;
    _progressLayer.lineWidth=_progressBarHeight-6;
    _progressLayer.lineCap=kCALineCapRound;
    //设置了KCALineCapRound，那么圆角弧度自然被设置成lineWidth／2，所以要想进度条距离外围的间距相等，起试点x坐标应该满足公式x=lineWidth/2+space;∵ lineWidth ＝ _progressBarHeight-space*2 ∴x = height/2.与 linewidth 是多少并没有关系
    [self.layer addSublayer:_progressLayer];
    CABasicAnimation * _pathAniamtion=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _pathAniamtion.duration=2.0f;
    _pathAniamtion.fromValue=@(0.0);
    _pathAniamtion.toValue=@(1.0f);
    _pathAniamtion.delegate=self;
    [_pathAniamtion setValue:@"progressBarAnimation" forKey:@"animationName"];
    [_progressLayer addAnimation:_pathAniamtion forKey:nil];
}

-(void)checkAniamtion{
    CAShapeLayer * _checkLayer=[CAShapeLayer layer];
    UIBezierPath * _path=[UIBezierPath bezierPath];
    CGRect rectIncircle=CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2);
    [_path moveToPoint:CGPointMake(rectIncircle.origin.x+rectIncircle.size.width/9, rectIncircle.origin.y+rectIncircle.size.height*2/3)];
    [_path addLineToPoint:CGPointMake(rectIncircle.origin.x+rectIncircle.size.width/3, rectIncircle.origin.y+rectIncircle.size.height*9/10)];
    [_path addLineToPoint:CGPointMake(rectIncircle.origin.x+rectIncircle.size.width*8/10, rectIncircle.origin.y+rectIncircle.size.height*2/10)];
    _checkLayer.path=_path.CGPath;
    _checkLayer.fillColor=[UIColor clearColor].CGColor;
    _checkLayer.strokeColor=[UIColor whiteColor].CGColor;
    _checkLayer.lineCap=kCALineCapRound;
    _checkLayer.lineJoin=kCALineCapRound;
    _checkLayer.lineWidth=10.0f;
    [self.layer addSublayer:_checkLayer];
    CABasicAnimation * _checkAniamtion=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _checkAniamtion.duration=0.3f;
    _checkAniamtion.fromValue=@(0.0f);
    _checkAniamtion.toValue=@(1.0f);
    _checkAniamtion.delegate=self;
    [_checkAniamtion setValue:@"checkAnimation" forKey:@"animationName"];//局部变量
    [_checkLayer addAnimation:_checkAniamtion forKey:nil];
}
@end

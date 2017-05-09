//
//  LoadingHUD.m
//  LoadingHUD
//
//  Created by myron on 2017/4/10.
//  Copyright © 2017年 Myron. All rights reserved.
//

#import "LoadingHUD.h"

#define ORIGIN_X self.frame.origin.x
#define ORigIN_Y self.frame.origin.y
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#define BALL_RADIUS 20

@interface LoadingHUD ()
@property (nonatomic, strong)NSTimer *timer;

@end
@implementation LoadingHUD{
    UIView *ball_1;
    UIView *ball_2;
    UIView *ball_3;
}

+(instancetype)sharedLoadingHUD{
    static dispatch_once_t onceToken;
    static LoadingHUD * sharedHUD;
    dispatch_once(&onceToken, ^{
        sharedHUD=[[LoadingHUD alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    });
    return sharedHUD;
}


- (instancetype)initWithEffect:(UIVisualEffect *)effect{
    if (self=[super initWithEffect:effect]) {
        self.frame=UIScreen.mainScreen.bounds;
        ball_2=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-BALL_RADIUS/2, HEIGHT/2-BALL_RADIUS/2, BALL_RADIUS, BALL_RADIUS)];
        ball_2.backgroundColor=[UIColor whiteColor];
        ball_2.layer.cornerRadius=ball_2.bounds.size.width/2;
        ball_1=[[UIView alloc]initWithFrame:CGRectMake(ball_2.frame.origin.x-BALL_RADIUS, ball_2.frame.origin.y, BALL_RADIUS, BALL_RADIUS)];
        ball_1.backgroundColor=[UIColor whiteColor];
        ball_1.layer.cornerRadius=ball_1.bounds.size.width/2;
        ball_3=[[UIView alloc]initWithFrame:CGRectMake(ball_2.frame.origin.x+BALL_RADIUS, ball_2.frame.origin.y, BALL_RADIUS, BALL_RADIUS)];
        ball_3.backgroundColor=[UIColor whiteColor];
        ball_3.layer.cornerRadius=ball_3.frame.size.width/2;
        [self addSubview:ball_1];
        [self addSubview:ball_2];
        [self addSubview:ball_3];
    }
    return self;
}

+(void)showHUD:(UIView *)bgView
{
    LoadingHUD *hud=[LoadingHUD sharedLoadingHUD];
    //UIWindow * window=[[[UIApplication sharedApplication] windows]firstObject];
    //window.backgroundColor=[UIColor redColor];
    if (bgView!=nil) {
        hud.alpha=0.0f;
        [bgView addSubview:hud];
        [UIView animateWithDuration:0.3f animations:^{
            hud.alpha=0.9;
        } completion:^(BOOL finished) {
            hud.alpha=0.9f;
            [hud startLoadingAnimation];
        }];
    }
}

+ (void)dismissHUD{
    LoadingHUD *hud=[LoadingHUD sharedLoadingHUD];
    [hud stopLoadingAniamtion];
    [hud.timer invalidate];
    [UIView animateWithDuration:0.3 animations:^{
        hud.alpha=0;
    } completion:^(BOOL finished) {
        [hud removeFromSuperview];
    }];
}
- (void)startLoadingAnimation{
    //1
    UIBezierPath * _circlePath_1=[UIBezierPath bezierPath];
    [_circlePath_1 moveToPoint:CGPointMake(WIDTH/2-BALL_RADIUS, HEIGHT/2)];
    [_circlePath_1 addArcWithCenter:CGPointMake(WIDTH/2, HEIGHT/2) radius:BALL_RADIUS startAngle:(180*M_PI)/180 endAngle:(360*M_PI)/180 clockwise:NO];
    UIBezierPath *circlePath_1_2=[UIBezierPath bezierPath];
    [circlePath_1_2 addArcWithCenter:CGPointMake(WIDTH/2, HEIGHT/2) radius:BALL_RADIUS startAngle:0 endAngle:M_PI clockwise:NO];
    [_circlePath_1 appendPath:circlePath_1_2];
    
   // CAKeyframeAnimation可以控制在动画的特定状态，可以吧动画分成几段，设置不同饿时间等属性来完成一个完整的动画
    CAKeyframeAnimation * _aniamtion=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    _aniamtion.path=_circlePath_1.CGPath;
    _aniamtion.removedOnCompletion=YES;
    _aniamtion.duration=1.4f;
    _aniamtion.repeatCount=INFINITY;
    _aniamtion.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//easeout开始快，in最后快
    [ball_1.layer addAnimation:_aniamtion forKey:@"aniamtion"];
    
    //2
    UIBezierPath *circlePath_2=[UIBezierPath bezierPath];
    [circlePath_2 moveToPoint:CGPointMake(WIDTH/2+BALL_RADIUS, HEIGHT/2)];
    [circlePath_2 addArcWithCenter:CGPointMake(WIDTH/2, HEIGHT/2) radius:BALL_RADIUS startAngle:0 endAngle:M_PI clockwise:NO];
    
    UIBezierPath *circlePath_2_2 = [UIBezierPath bezierPath];
    [circlePath_2_2 addArcWithCenter:CGPointMake(WIDTH/2, HEIGHT/2) radius:BALL_RADIUS startAngle:M_PI endAngle:(2*M_PI) clockwise:NO];
    [circlePath_2 appendPath:circlePath_2_2];
    
    CAKeyframeAnimation * _aniamtion_2=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    _aniamtion_2.path=circlePath_2.CGPath;
    _aniamtion_2.removedOnCompletion=YES;
    _aniamtion_2.repeatCount=INFINITY;
    _aniamtion_2.duration=1.4;
    _aniamtion_2.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [ball_3.layer addAnimation:_aniamtion_2 forKey:@"aniamtion"];
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(scaleAniamtion) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)scaleAniamtion{
   [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut| UIViewAnimationOptionBeginFromCurrentState animations:^{
       ball_1.transform=CGAffineTransformMakeTranslation(-BALL_RADIUS, 0);
       ball_1.transform=CGAffineTransformScale(ball_1.transform, 0.7, 0.7);
       ball_3.transform = CGAffineTransformMakeTranslation(BALL_RADIUS, 0);
       ball_3.transform = CGAffineTransformScale(ball_3.transform, 0.7, 0.7);
       ball_2.transform = CGAffineTransformScale(ball_2.transform, 0.7, 0.7);
   } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.3 animations:^{
           ball_1.transform = CGAffineTransformIdentity;
           ball_3.transform = CGAffineTransformIdentity;
           ball_2.transform = CGAffineTransformIdentity;
       }];
   }];
}

- (void)stopLoadingAniamtion{
    [ball_3.layer removeAllAnimations];
    [ball_2.layer removeAllAnimations];
    [ball_1.layer removeAllAnimations];
}
@end

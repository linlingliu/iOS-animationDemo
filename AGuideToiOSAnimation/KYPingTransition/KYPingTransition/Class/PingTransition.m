//
//  PingTransition.m
//  KYPingTransition
//
//  Created by LX on 17/3/31.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "PingTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface PingTransition ()
@property (nonatomic, strong)id<UIViewControllerContextTransitioning>transitionContext;

@end
@implementation PingTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.7f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext=transitionContext;
    ViewController * fromVC=(ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    SecondViewController * toVc=(SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewKey];
    UIView * contView=[transitionContext containerView];
    UIButton *button=fromVC.button;
    UIBezierPath * maskStartPath=[UIBezierPath bezierPathWithOvalInRect:button.frame];
    [contView addSubview:fromVC.view];
    [contView addSubview:toVc.view];
    //创建两个圆形的UIBezierPath实例，一个是button的size，另一个则拥有足够覆盖屏幕的半径，最终的动画则是在这两个
    CGPoint finalPoint;
    //判断触发点在那个象限
    if (button.frame.origin.x>(toVc.view.bounds.size.width/2)) {
        if (button.frame.origin.y<(toVc.view.bounds.size.height/2)) {
            //第一象限
            finalPoint=CGPointMake(button.center.x, button.center.y-CGRectGetMaxY(toVc.view.bounds)+30);
        }else{
            //第四象限
            finalPoint=CGPointMake(button.center.x-0, button.center.y-0);
        }
    }else{
        if (button.frame.origin.y<(toVc.view.bounds.size.height/2)) {
            //第二象限
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVc.view.bounds), button.center.y - CGRectGetMaxY(toVc.view.bounds)+30);
        }else{
            //第三象限
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVc.view.bounds), button.center.y - 0);
        }
    }
    CGFloat radius=sqrt(finalPoint.x * finalPoint.x)+(finalPoint.y*finalPoint.y);
    UIBezierPath * maskFinalBP=[UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    //创建一个CAShaperLayer来负责展示圆形遮罩
    CAShapeLayer * maskLayer=[CAShapeLayer layer];
    maskLayer.path=maskFinalBP.CGPath;//将它的Path指定为最终的path来避免在动画完成后会回弹
    toVc.view.layer.mask=maskLayer;
    
    
}
@end

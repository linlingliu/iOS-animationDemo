//
//  GradientController.m
//  SplashAnimationDemo
//
//  Created by LX on 17/3/30.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "GradientController.h"

@interface GradientController ()
{
    UILabel *_unlock;
    CAShapeLayer *_maskLayer;
}
@end

@implementation GradientController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor cyanColor];
    [self addUI3];
}

//iphone滑动解锁{
- (void)addUI3{
    CAGradientLayer *_gradientLayer=[CAGradientLayer layer];
    [self.view.layer addSublayer:_gradientLayer];
    _gradientLayer.frame=CGRectMake(0, 200, self.view.frame.size.width, 64);
    _gradientLayer.colors = @[
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor blackColor].CGColor,
                             ];
    _gradientLayer.locations = @[@0.25,@0.5,@0.75];
    _gradientLayer.startPoint = CGPointMake(0, 0.5);
    _gradientLayer.endPoint = CGPointMake(1, 0.5);
    // CAGradientLayer可用来处理颜色渐变，它的渐变色也可以做隐式动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    basicAnimation.fromValue = @[@0, @0, @0.25];
    basicAnimation.toValue = @[@0.75, @1, @1];
    basicAnimation.duration = 2.5;
    basicAnimation.repeatCount = HUGE;
    //[_gradientLayer addAnimation:basicAnimation forKey:nil];
    
    // 设置 gradientLayer  的 mask 为 unLock   有透明度的地方 就露出来了
    _unlock=[[UILabel alloc] initWithFrame:_gradientLayer.bounds];
    _unlock.text = @"滑动来解锁 >>";//设置了文字
    _unlock.textAlignment = NSTextAlignmentCenter;
    _unlock.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:_unlock];
    _gradientLayer.mask = _unlock.layer;
}
- (void)addUI1{
    CAGradientLayer * _gradinentLayer=[CAGradientLayer layer];
    _gradinentLayer.frame    = (CGRect){CGPointZero, CGSizeMake(200, 200)};
    _gradinentLayer.position=self.view.center;
    _gradinentLayer.colors=@[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor brownColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    _gradinentLayer.locations=@[@(0.25),@(0.45),@(0.90)];
    _gradinentLayer.startPoint=CGPointMake(0, 0);
    _gradinentLayer.endPoint=CGPointMake(0, 1);
    [self.view.layer addSublayer:_gradinentLayer];
    //colors locations startPoint endPoint 都是可以进行动画
}

- (void)addUI2{
    CAGradientLayer * _colorLayer=[CAGradientLayer layer];
    _colorLayer.backgroundColor=[UIColor blueColor].CGColor;
    _colorLayer.frame=(CGRect){CGPointZero,CGSizeMake(200, 200)};
    _colorLayer.position=self.view.center;
    [self.view.layer addSublayer:_colorLayer];
    _colorLayer.colors=@[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
    _colorLayer.locations=@[@(-0.2),@(-0.1),@(0)];
    _colorLayer.startPoint=CGPointMake(0, 0);
    _colorLayer.endPoint=CGPointMake(1, 0);
    CAShapeLayer *circle = [GradientController LayerWithCircleCenter:CGPointMake(102, 100)
                                                              radius:80
                                                          startAngle:0
                                                            endAngle:M_PI*2
                                                           clockwise:YES
                                                     lineDashPattern:nil];
    circle.strokeColor=[UIColor redColor].CGColor;
    [self.view.layer addSublayer:circle];
    circle.strokeEnd=1.0f;
    _colorLayer.mask=circle;
    
    
}

+ (CAShapeLayer *)LayerWithCircleCenter:(CGPoint)point
                                 radius:(CGFloat)radius
                             startAngle:(CGFloat)startAngle
                               endAngle:(CGFloat)endAngle
                              clockwise:(BOOL)clockwise
                        lineDashPattern:(NSArray *)lineDashPattern
{
    CAShapeLayer * layer=[CAShapeLayer layer];
    UIBezierPath * path=[UIBezierPath bezierPathWithArcCenter:CGPointZero radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    layer.path=path.CGPath;
    layer.position=point;
    layer.fillColor=[UIColor clearColor].CGColor;
    if (lineDashPattern) {
        layer.lineDashPattern=lineDashPattern;
    }
    return layer;
}
@end

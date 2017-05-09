//
//  TitleViewController.m
//  SplashAnimationDemo
//
//  Created by LX on 17/3/30.
//  Copyright © 2017年 LX. All rights reserved.
//
//文字渐变
/*
 *UIlabel的layer就是文字
 */
#import "TitleViewController.h"

@interface TitleViewController ()

@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor cyanColor];
    [self addUI3];
}

//文字背景渐变和图片透明部分渐变
- (void)addUI3{
    UILabel * _lb1=[[UILabel alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 70)];
    _lb1.text=@"雪灾是世界上最帅的";
    _lb1.font=[UIFont systemFontOfSize:30];
    [self.view addSubview:_lb1];
    CAGradientLayer * _gradientLayer=[CAGradientLayer layer];
    _gradientLayer.frame=_lb1.frame;
    _gradientLayer.colors=@[(id)[UIColor blackColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor blueColor].CGColor];
    _gradientLayer.locations = @[@0.25,@0.5,@0.75];
    _gradientLayer.startPoint=CGPointMake(0, 0);
    _gradientLayer.endPoint=CGPointMake(1, 1);
    [self.view.layer addSublayer:_gradientLayer];
    [_gradientLayer addSublayer:_lb1.layer];
    _lb1.layer.frame=_gradientLayer.bounds;
    CABasicAnimation * _aniamtion=[CABasicAnimation animationWithKeyPath:@"locations"];
    _aniamtion.fromValue=@[@(-0.2),@(-0.1),@(0)];
    _aniamtion.toValue=@[@(1),@(1.1),@(1.2)];
    _aniamtion.duration=4;
    _aniamtion.repeatCount=HUGE;
    [_gradientLayer addAnimation:_aniamtion forKey:@"locations"];
}
//文字渐变和图片不透明部分渐变
- (void)addUI2{
    UIImageView * _img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 70)];
    _img.image=[UIImage imageNamed:@"abc.png"];
    CAGradientLayer * _gradientLayer=[CAGradientLayer layer];
    _gradientLayer.frame=_img.frame;
    _gradientLayer.colors=@[(id)[UIColor blackColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor blueColor].CGColor];
    _gradientLayer.locations = @[@0.25,@0.5,@0.75];
    _gradientLayer.startPoint=CGPointMake(0, 0);
    _gradientLayer.endPoint=CGPointMake(1, 1);
    [self.view.layer addSublayer:_gradientLayer];
    _gradientLayer.mask=_img.layer;
    _img.layer.frame=_gradientLayer.bounds;
    CABasicAnimation * _aniamtion=[CABasicAnimation animationWithKeyPath:@"locations"];
    _aniamtion.fromValue=@[@(-0.2),@(-0.1),@(0)];
    _aniamtion.toValue=@[@(1),@(1.1),@(1.2)];
    _aniamtion.duration=4;
    _aniamtion.repeatCount=HUGE;
    [_gradientLayer addAnimation:_aniamtion forKey:@"locations"];

}
- (void)addUI1{
    UILabel * _lb1=[[UILabel alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 70)];
    _lb1.text=@"雪灾是世界上最帅的";
    _lb1.font=[UIFont systemFontOfSize:30];
    [self.view addSubview:_lb1];
    CAGradientLayer * _gradientLayer=[CAGradientLayer layer];
    _gradientLayer.frame=_lb1.frame;
    _gradientLayer.colors=@[(id)[UIColor blackColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor blueColor].CGColor];
    _gradientLayer.locations = @[@0.25,@0.5,@0.75];
    _gradientLayer.startPoint=CGPointMake(0, 0);
    _gradientLayer.endPoint=CGPointMake(1, 1);
    [self.view.layer addSublayer:_gradientLayer];
    _gradientLayer.mask=_lb1.layer;
    _lb1.layer.frame=_gradientLayer.bounds;
    CABasicAnimation * _aniamtion=[CABasicAnimation animationWithKeyPath:@"locations"];
    _aniamtion.fromValue=@[@(-0.2),@(-0.1),@(0)];
    _aniamtion.toValue=@[@(1),@(1.1),@(1.2)];
    _aniamtion.duration=4;
    _aniamtion.repeatCount=HUGE;
    [_gradientLayer addAnimation:_aniamtion forKey:@"locations"];
    
}

@end

//
//  AnimaController.m
//  GooeyMenu
//
//  Created by myron on 2017/4/15.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "AnimaController.h"
#import "SpringLayerAnimation.h"

@interface AnimaController ()
{
    UIImageView * _img;
    SpringLayerAnimation    *_anima;
}
@end

@implementation AnimaController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor cyanColor];
    _img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbarItem_group highlighted"]];
    _img.backgroundColor=[UIColor redColor];
    _img.center=self.view.center;
    _img.bounds=CGRectMake(0, 0, 100, 100);
    [self.view addSubview:_img];
    UITapGestureRecognizer * _tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_img addGestureRecognizer:_tap];
    _img.userInteractionEnabled=YES;
    
    
    _anima=[SpringLayerAnimation sharedAnimManager];
    
    
}

- (void)tap:(id)sender{
    //CAKeyframeAnimation * _keyAnima=[_anima createSpringAnima:@"position.y" duration:10 Damping:10 initialVelocity:10 fromValue:@(0) toValue:@(500)];
    CAKeyframeAnimation * _keyAnima=[_anima createCurveAnima:@"position.y" duration:5 fromValue:@(0) toValue:@(500)];
    [_img.layer addAnimation:_keyAnima forKey:@"center.y"];//layer的动画改变layer的位置
    CALayer * _animlayer=[_img.layer presentationLayer];
    NSLog(@"%f",_animlayer.position.y);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_img.layer removeAllAnimations];
    });
}

@end

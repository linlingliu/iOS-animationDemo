//
//  ViewController.m
//  InteractiveCardDemo
//
//  Created by LX on 17/4/11.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "ViewController.h"
#import "InteractiveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    InteractiveView * _interactiveView=[[InteractiveView alloc]initWithImage:[UIImage imageNamed:@"pic01"]];
    _interactiveView.center=self.view.center;
    _interactiveView.bounds=CGRectMake(0, 0, 200, 200);//改变bounds，frame页会相应的改变（变为改变值的1/2）
    _interactiveView.gestureView=self.view;
    
    //模糊图层
    UIBlurEffect * _blur=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * _blurView=[[UIVisualEffectView alloc]initWithEffect:_blur];
    _blurView.frame=self.view.bounds;
    [self.view addSubview:_blurView];
    _interactiveView.dimmingView=_blurView;
    
    ////interactiveView 的父视图。注意：interactiveView 和 blurView 不能添加到同一个父视图。否则透视效果会使 interactiveView 穿过 blurView
    UIView * backView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backView];
    [backView addSubview:_interactiveView];
    
}

@end

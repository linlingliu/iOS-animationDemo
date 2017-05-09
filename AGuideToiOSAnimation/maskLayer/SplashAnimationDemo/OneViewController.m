//
//  OneViewController.m
//  SplashAnimationDemo
//
//  Created by LX on 17/3/30.
//  Copyright © 2017年 LX. All rights reserved.
//
//mask图层定义了父图层的部分可见区域
#import "OneViewController.h"

@interface OneViewController ()
{
    UIImageView * _img;
    UIImageView * _img1;
    UILabel * unlock;
    UIImageView * _img3;
}
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor cyanColor];
    [self addUI3];
}

- (void)addUI3{
    _img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_demo"]];
    _img.frame=CGRectMake(0, 0, 200, 200);
    //_img.center=self.view.center;
    [self.view addSubview:_img];
    _img1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo1"]];
    _img1.frame=CGRectMake(0, 0, 100, 100);
    
    _img.layer.mask=_img1.layer;
}
- (void)addUI1{
    _img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo1"]];
    _img.frame=CGRectMake(0, 0, 200, 200);
    _img.center=self.view.center;
    [self.view addSubview:_img];
    
    CALayer * _maskLayer=[CALayer layer];
    _maskLayer.frame=CGRectMake(0, 0, 100, 100);
    _maskLayer.backgroundColor=[UIColor whiteColor].CGColor;//颜色属性无关紧要，把重叠部分的点的alpho为1，其余为0.
    _img.layer.mask=_maskLayer;
}

- (void)addUi2{
    _img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo1"]];
    _img.frame=CGRectMake(0, 0, 200, 200);
    _img.center=self.view.center;
    [self.view addSubview:_img];
    
    // 在上层的 图片 upGround
    _img1 = [[UIImageView alloc] initWithFrame:_img.frame];
    _img1.image        = [UIImage imageNamed:@"home_demo"];
    [self.view addSubview:_img1];
    
    UIView *mask=[[UIView alloc]initWithFrame:_img1.bounds];
    _img1.maskView=mask;
    
    UIImageView *picOne=[[UIImageView alloc]init];
    picOne.backgroundColor=[UIColor blueColor];
    picOne.frame=CGRectMake(0, 0, 100, 400);
    [mask addSubview:picOne];
    UIImageView *picTwo=[[UIImageView alloc]init];
    picTwo.frame=CGRectMake(100, -200, 100, 400);
    picTwo.backgroundColor=[UIColor blueColor];
    [mask addSubview:picTwo];
    //mask覆盖了——img1全显示，通过动画不覆盖_img1,显示下层的图片
    // 两个imageView的动画 使maskView的alpha通道由 1 变成 0 ，导致 上层图片消失， 达到切换的效果
    [UIView animateWithDuration:2.f delay:2.f options:0 animations:^{
        picOne.frame=CGRectMake(0,-400, 100, 400);
        picTwo.frame=CGRectMake(100, 200, 100, 400);
    } completion:^(BOOL finished) {
        
    }];
}
@end

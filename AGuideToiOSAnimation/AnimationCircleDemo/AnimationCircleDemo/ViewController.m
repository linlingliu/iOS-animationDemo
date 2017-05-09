//
//  ViewController.m
//  AnimationCircleDemo
//
//  Created by LX on 17/3/20.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
#import "DrawView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (nonatomic, strong)CircleView * circleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mySlider addTarget:self action:@selector(valuechanged:) forControlEvents:UIControlEventValueChanged];
    self.circleView=[[CircleView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 320/2, self.view.frame.size.height/2 - 320/2, 320, 320)];
    [self.view addSubview:self.circleView];
    self.circleView.circleLayer.progress=_mySlider.value;
    [self.view bringSubviewToFront:self.mySlider];
    
    DrawView * _drawView=[[DrawView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:_drawView];
}

-(void)valuechanged:(UISlider *)sender{
    
    self.currentValueLabel.text = [NSString stringWithFormat:@"Current:  %f",sender.value];
    self.circleView.circleLayer.progress = sender.value;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

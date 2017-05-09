//
//  ViewController.m
//  JumpStarDemo
//
//  Created by 林丹 on 2017/4/7.
//  Copyright © 2017年 Myron. All rights reserved.
//

#import "ViewController.h"
#import "JumpStarView.h"
@interface ViewController ()
@property (nonatomic,strong)JumpStarView *jumpStarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.jumpStarView];
    UIButton * _btn=[UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame=CGRectMake(0, 0, 50, 50);
    _btn.backgroundColor=[UIColor cyanColor];
    [_btn setTitle:@"jump" forState:UIControlStateNormal];
    _btn.center=CGPointMake(self.view.center.x, self.view.center.y+200);
    [self.view addSubview:_btn];
    [_btn addTarget:self  action:@selector(jumpClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)jumpClicked:(id)sender{
    [_jumpStarView aniamtion];
}

- (JumpStarView *)jumpStarView{
    if (!_jumpStarView) {
        _jumpStarView=[[JumpStarView alloc]initWithFrame:CGRectMake(0, 0, 19,19)];
        _jumpStarView.backgroundColor=[UIColor cyanColor];
        _jumpStarView.center=self.view.center;
        _jumpStarView.markedImage=[UIImage imageNamed:@"1"];
        _jumpStarView.non_markedImage=[UIImage imageNamed:@"2"];
        _jumpStarView.state=NOMark;
    }
    return _jumpStarView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  tvOSCardAnimation
//
//  Created by myron on 2017/4/12.
//  Copyright © 2017年 Myron. All rights reserved.
//

#import "ViewController.h"
#import "tvOSCardView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tvOSCardView * _cardIVew=[[tvOSCardView alloc]init];
    _cardIVew.center=self.view.center;
    _cardIVew.bounds=CGRectMake(0, 0, 150, 150);
    [self.view addSubview:_cardIVew];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  LoadingHUD
//
//  Created by myron on 2017/4/10.
//  Copyright © 2017年 Myron. All rights reserved.
//

#import "ViewController.h"
#import "LoadingHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [LoadingHUD showHUD:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  DowmLoadingButton
//
//  Created by LX on 17/4/10.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "ViewController.h"
#import "DownloadButton.h"

@interface ViewController ()

@property (nonatomic,strong)DownloadButton * downloadButton;

@end

@implementation ViewController
{
    BOOL animating;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.downloadButton=[[DownloadButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.downloadButton.backgroundColor=[UIColor cyanColor];
    self.downloadButton.center=self.view.center;
    [self.view addSubview:self.downloadButton];
    self.downloadButton.progressBarWidth=200;
    self.downloadButton.progressBarHeight=30;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

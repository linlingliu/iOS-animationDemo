//
//  ViewController.m
//  KYPingTransition
//
//  Created by LX on 17/3/31.
//  Copyright © 2017年 LX. All rights reserved.
//
/*
 *  UINavigationControllerDelegate(push)时使用   UIViewController- TransitioningDelegate（prersent）时使用
 */
#import "ViewController.h"
#import "SecondViewController.h"
#import "PingTransition.h"

@interface ViewController ()<UINavigationControllerDelegate>
- (IBAction)pushClicked:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate=self;
}

#pragma UINAvigationDeleagate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation==UINavigationControllerOperationPush) {
        PingTransition *_oing=[PingTransition new];
        return _oing;
    }else{
        return nil;
    }
}
- (IBAction)pushClicked:(UIButton *)sender {
    SecondViewController * _second=[SecondViewController new];
    [self.navigationController pushViewController:_second animated:YES];
}
@end

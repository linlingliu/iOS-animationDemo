//
//  SecondViewController.m
//  KYPingTransition
//
//  Created by LX on 17/3/31.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"
#import "PingInvertTransition.h"

@interface SecondViewController ()<UINavigationControllerDelegate>

@end

@implementation SecondViewController
{
    UIPercentDrivenInteractiveTransition *percentTransition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    self.navigationController.delegate=self;
    UIScreenEdgePanGestureRecognizer *degeGes=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self  action:@selector(efgePan:)];
    degeGes.edges=UIRectEdgeLeft;
    [self.view addGestureRecognizer:degeGes];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return percentTransition;
}

-(void)efgePan:(UIPanGestureRecognizer*)recognizer{
    CGFloat per = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
    per = MIN(1.0,(MAX(0.0, per)));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        percentTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [percentTransition updateInteractiveTransition:per];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (per > 0.3) {
            [percentTransition finishInteractiveTransition];
        }else{
            [percentTransition cancelInteractiveTransition];
        }
        percentTransition = nil;
    }

}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation==UINavigationControllerOperationPop) {
        PingInvertTransition * pingInvert=[PingInvertTransition new];
        return pingInvert;
    }else{
        return nil;
    }
}

- (IBAction)popClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

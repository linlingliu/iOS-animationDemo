//
//  AppDelegate.m
//  SplashAnimation
//
//  Created by LX on 17/3/31.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    UINavigationController * _nav=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController];
    self.window.rootViewController=_nav;
    
    
    //logo mask
    CALayer *maskLayer=[CALayer layer];
    maskLayer.contents=(id)[UIImage imageNamed:@"home_demo"].CGImage;
    maskLayer.position=_nav.view.center;
    maskLayer.bounds=CGRectMake(0, 0, 60, 60);
    _nav.view.layer.mask=maskLayer;//window上的内容显示出来了，_nav上的内容只能显示mask,加载完后_nav.view是viewController的view
    //logo mask background view
    UIView *maskBackGroundView=[[UIView alloc]initWithFrame:_nav.view.bounds];
    maskBackGroundView.backgroundColor=[UIColor whiteColor];
    [_nav.view addSubview:maskBackGroundView];
    [_nav.view bringSubviewToFront:maskBackGroundView];
    
    //logo mask aniamtion
    CAKeyframeAnimation *logoMskAniamtion=[CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    logoMskAniamtion.duration=1.0f;
    logoMskAniamtion.beginTime=CACurrentMediaTime()+1.0f;
    
    CGRect initalBounds=maskLayer.bounds;
    CGRect secondBounds=CGRectMake(0, 0, 50, 50);
    CGRect finalBounds=CGRectMake(0, 0, 2000, 2000);
    logoMskAniamtion.values=@[[NSValue valueWithCGRect:initalBounds],[NSValue valueWithCGRect:secondBounds],[NSValue valueWithCGRect:finalBounds]];
    logoMskAniamtion.keyTimes=@[@(0),@(0.5),@(1)];//总时间的比例
    logoMskAniamtion.timingFunctions=@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    logoMskAniamtion.removedOnCompletion=NO;//YES恢复到动画前
    logoMskAniamtion.fillMode=kCAFillModeForwards;
    [_nav.view.layer.mask addAnimation:logoMskAniamtion forKey:@"animation"];//mask覆盖的内容都会显示出来
    
    //最后让白色View的透明度变为0，显示出viewController
    [UIView animateWithDuration:0.1 delay:1.25 options:UIViewAnimationOptionCurveEaseIn animations:^{
        maskBackGroundView.alpha=0.0f;
    } completion:^(BOOL finished) {
        [maskBackGroundView removeFromSuperview];
    }];
   
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

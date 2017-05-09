//
//  InteractiveView.m
//  InteractiveCardDemo
//
//  Created by LX on 17/4/11.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "InteractiveView.h"

#define WIDTH     [UIScreen mainScreen].bounds.size.width
#define EIGHT    [UIScreen mainScreen].bounds.size.height
#define ANIMATEDURATION 0.5
#define ANIMATEDAMPING  0.6
#define SCROLLDISTANCE  200.0

@implementation InteractiveView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image{
    if (self=[super initWithImage:image]) {
        self.userInteractionEnabled=YES;
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.layer.cornerRadius=7.0f;
        self.layer.masksToBounds=YES;
    }
    return self;
}

- (void)setGestureView:(UIView *)gestureView{
    _gestureView=gestureView;
    UIPanGestureRecognizer * _pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
    [self addGestureRecognizer:_pan];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)gesture{
    static CGPoint initialPoint;
    CGFloat factorOfAngle=0.0f;
    CGFloat factorOfScale=0.0f;
    CGPoint translation=[gesture translationInView:self.superview];//在父视图中的移动距离
    if (gesture.state==UIGestureRecognizerStateBegan) {
        initialPoint=self.center;
    }else if (gesture.state==UIGestureRecognizerStateChanged){
        self.center=CGPointMake(initialPoint.x, initialPoint.y+translation.y);
        CGFloat Y=MIN(SCROLLDISTANCE, MAX(0, ABS(translation.y)));//abs函数求绝对值，y的移动值最大为ScrillDistanxce
        //一个开口向下，顶点（scrollDIstance／2，1），过（0，0），（ScrollDistance，0）的二次函数
        factorOfAngle=MAX(0, -4/(SCROLLDISTANCE * SCROLLDISTANCE)*Y*(Y-SCROLLDISTANCE));
        //一个开口向下，顶点（SCROLLDISTANCE，1），过（0，0），（2*SCROLLDISTANCE，0）的二次函数
        factorOfScale=MAX(0, -1/(SCROLLDISTANCE * SCROLLDISTANCE)* Y *(Y-2*SCROLLDISTANCE));
        CATransform3D t=CATransform3DIdentity;
        t.m34=1.0/-1000;
        //t=CATransform3DRotate(t, factorOfAngle*(M_PI/5), translation.y>0?-1:1, 0, 0);
        t=CATransform3DScale(t, 1-factorOfScale*0.2, 1-factorOfScale*0.2, 0);
        self.layer.transform=t;
        self.dimmingView.alpha=1.0-Y/SCROLLDISTANCE;
    }else if (gesture.state==UIGestureRecognizerStateEnded || gesture.state==UIGestureRecognizerStateCancelled){
        [UIView animateWithDuration:ANIMATEDURATION delay:0.0f usingSpringWithDamping:ANIMATEDAMPING initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.layer.transform=CATransform3DIdentity;
            self.center=initialPoint;
            self.dimmingView.alpha=1.0f;
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end

//
//  tvOSCardView.m
//  tvOSCardAnimation
//
//  Created by myron on 2017/4/12.
//  Copyright © 2017年 Myron. All rights reserved.
//

#import "tvOSCardView.h"

@implementation tvOSCardView{
    UIImageView * cardImageView;
    UIImageView * cardParallaxView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self setUp];
}

- (void)setUp{
    self.layer.shadowColor=[UIColor blackColor].CGColor;
    self.layer.shadowOffset=CGSizeMake(0, 10);
    self.layer.shadowRadius=10.0f;
    self.layer.shadowOpacity=0.3f;
    cardImageView=[[UIImageView alloc]initWithFrame:self.bounds];
    cardImageView.image=[UIImage imageNamed:@"poster"];
    cardImageView.layer.cornerRadius=5.0f;
    cardImageView.clipsToBounds=YES;
    [self addSubview:cardImageView];
    
    UIPanGestureRecognizer * _pan=[[UIPanGestureRecognizer alloc]initWithTarget:self  action:@selector(panInCard:)];
    [self addGestureRecognizer:_pan];
    
    cardParallaxView=[[UIImageView alloc]initWithFrame:cardImageView.frame];
    cardParallaxView.image=[UIImage imageNamed:@"5"];
    cardParallaxView.layer.transform=CATransform3DTranslate(self.layer.transform, 0, 0, 200);
    [self insertSubview:cardParallaxView aboveSubview:cardImageView];
    
}

- (void)panInCard:(UIPanGestureRecognizer *)gesture{
    
}

@end

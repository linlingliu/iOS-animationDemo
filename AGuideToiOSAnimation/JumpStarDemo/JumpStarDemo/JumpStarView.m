//
//  JumpStarView.m
//  JumpStarDemo
//
//  Created by 林丹 on 2017/4/7.
//  Copyright © 2017年 Myron. All rights reserved.
//

#import "JumpStarView.h"

#define jumpDuration 3
#define doumDuraton 3.5

@interface JumpStarView ()<CAAnimationDelegate>
@property(nonatomic,strong)UIImageView * startView;
@property (nonatomic,strong)UIImageView *shadowView;
@property (nonatomic,strong)CADisplayLink * displayLink;
@end


@implementation JumpStarView{
    BOOL aniamting;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.startView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - (self.bounds.size.width-6)/2, 0, self.bounds.size.width-6, self.bounds.size.height - 6)];
        self.startView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.startView];
        self.shadowView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - 10/2, self.bounds.size.height - 3, 10, 3)];
        self.shadowView.backgroundColor=[UIColor redColor];
        self.shadowView.alpha = 0.2;
        self.shadowView.image = [UIImage imageNamed:@"shadow_new"];
        [self addSubview:self.shadowView];
        _displayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(linkClicked:)];
    }
    return self;
}

- (void)linkClicked:(id)sender{
    NSLog(@"%fd",self.startView.center.y);
}
- (void)setState:(START)state{
    _state=state;
    self.startView.image=_state==Mark?_markedImage:_non_markedImage;
}

//上弹动画
- (void)aniamtion{
    if (aniamting==YES) {
        return;
    }
    //[self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    aniamting=YES;
    CABasicAnimation * _transformY=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    _transformY.fromValue=@(0);
    _transformY.toValue=@(M_PI_2);
    _transformY.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation * _positionY=[CABasicAnimation animationWithKeyPath:@"position.y"];
    _positionY.fromValue=@(self.startView.center.y);
    _positionY.toValue=@(self.startView.center.y-40);
    _positionY.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    CAAnimationGroup *_group=[CAAnimationGroup animation];
    _group.duration=jumpDuration;
    _group.fillMode=kCAFillModeForwards;
    _group.removedOnCompletion=NO;
    _group.delegate=self;
    _group.animations=@[_transformY,_positionY];
    [self.startView.layer addAnimation:_group forKey:@"jumpUp"];
    
}

//- (void)animationDidStart:(CAAnimation *)anim{
//    CALayer * _present=[self.startView.layer presentationLayer];
//    NSLog(@"%f",_present.position.y);
//}
//
//
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    CALayer * _present=[self.startView.layer presentationLayer];
//    NSLog(@"%f",_present.position.y);
//    [self.startView.layer removeAllAnimations];
//    aniamting=NO;
//    CALayer * _present1=[self.startView.layer presentationLayer];
//    NSLog(@"%f",_present1.position.y);
//}
- (void)animationDidStart:(CAAnimation *)anim{
    if ([anim isEqual:[self.startView.layer animationForKey:@"jumpUp"]]) {
        [UIView animateWithDuration:jumpDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            _shadowView.alpha=0.2;
            _shadowView.bounds=CGRectMake(0, 0, _shadowView.bounds.size.width*1.6, _shadowView.bounds.size.height);
        } completion:NULL];
    }else if ([anim isEqual:[self.startView.layer animationForKey:@"jumpDown"]]){
        [UIView animateWithDuration:jumpDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            _shadowView.alpha=0.4;
            _shadowView.bounds=CGRectMake(0, 0, _shadowView.bounds.size.width/1.6, _shadowView.bounds.size.height);
        } completion:NULL];
    }
}

//下落动画
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim isEqual:[self.startView.layer animationForKey:@"jumpUp"]]) {
        self.state=self.state==Mark?NOMark:Mark;
        NSLog(@"%ld",self.state);
        
        CABasicAnimation * _transformY=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        _transformY.fromValue=@(M_PI_2);
        _transformY.toValue=@(M_PI);
        _transformY.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        CABasicAnimation * _positionY=[CABasicAnimation animationWithKeyPath:@"position.y"];
        _positionY.fromValue=@(self.startView.center.y-40);
        _positionY.toValue=@(self.startView.center.y);
        _positionY.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        CAAnimationGroup * _group=[CAAnimationGroup animation];
        _group.duration=doumDuraton;
        _group.fillMode=kCAFillModeForwards;
        _group.removedOnCompletion=NO;
        _group.delegate=self;
        _group.animations=@[_transformY,_positionY];
        [self.startView.layer addAnimation:_group forKey:@"jumpDown"];
        
    }else if ([anim isEqual:[self.startView.layer animationForKey:@"jumpDown"]])
    {
        [self.startView.layer removeAllAnimations];
        aniamting=NO;
    }
}
@end

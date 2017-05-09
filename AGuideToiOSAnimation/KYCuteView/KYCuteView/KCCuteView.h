//
//  KCCuteView.h
//  KYCuteView
//
//  Created by LX on 17/3/24.
//  Copyright © 2017年 LX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCCuteView : UIView

@property (nonatomic,strong)UIView  * containerView;
@property (nonatomic,strong)UILabel * bubbleLabel;
@property (nonatomic,assign)CGFloat bubbleWidth;
@property (nonatomic,assign)CGFloat viscosity;//气泡粘性系数，越大可以拉的越长
@property (nonatomic,strong)UIColor   *bubbleColor;
@property (nonatomic,strong)UIView *frontView;//需要隐藏气泡时候可以使用这个属性
- (instancetype)initWithPoint:(CGPoint)point superView:(UIView *)view;
- (void)setUp;

@end

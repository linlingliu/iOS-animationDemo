//
//  MenuLayer.h
//  GooeyMenu
//
//  Created by LX on 17/4/13.
//  Copyright © 2017年 LX. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef enum:NSInteger{
    STATE1,
    STATE2,
    STATE3,
}STATE;

@interface MenuLayer : CALayer

@property (nonatomic, assign)BOOL showDebug;
@property (nonatomic, assign)STATE animState;
@property (nonatomic, assign)CGFloat xAxisPercent;

@end

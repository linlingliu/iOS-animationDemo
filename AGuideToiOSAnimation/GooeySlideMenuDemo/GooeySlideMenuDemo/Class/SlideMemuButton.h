//
//  SlideMemuButton.h
//  GooeySlideMenuDemo
//
//  Created by LX on 17/3/22.
//  Copyright © 2017年 LX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMemuButton : UIView
- (instancetype)initWithTitle:(NSString *)title;
@property (nonatomic, strong)UIColor * buttonColor;
@property (nonatomic, copy)void(^buttonClickBlock)(void);
@end

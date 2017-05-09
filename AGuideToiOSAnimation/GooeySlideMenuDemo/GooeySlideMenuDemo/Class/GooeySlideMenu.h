//
//  GooeySlideMenu.h
//  GooeySlideMenuDemo
//
//  Created by LX on 17/3/22.
//  Copyright © 2017年 LX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MenuButtonClickedBlock)(NSInteger index,NSString * title,NSInteger titleCounts);


@interface GooeySlideMenu : UIView

- (instancetype)initWithTitles:(NSArray *)titles;

-(id)initWithTitles:(NSArray *)titles withButtonHeight:(CGFloat)height withMenuColor:(UIColor *)menuColor withBackBlurStyle:(UIBlurEffectStyle)style;

- (void)trigger;

@property (nonatomic, copy)MenuButtonClickedBlock menuClickBlock;
@end

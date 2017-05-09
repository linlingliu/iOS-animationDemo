//
//  GooeyMenu.h
//  GooeyMenu
//
//  Created by LX on 17/4/13.
//  Copyright © 2017年 LX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GooeyMenuDelegate <NSObject>

- (void)menuDidSelected:(NSInteger)index;

@end

@interface GooeyMenu : UIView


/**
 items的个数
 */
@property (nonatomic, assign) NSInteger MenuCount;

/**
 items的Radius
 */
@property (nonatomic, assign)CGFloat radius;

/**
 *  这里的距离是指 除了"R+r" 额外的高度，也就是中间空白的距离，如果distance设为0，你将看到它们相切
 */
@property(nonatomic,assign)CGFloat extraDistance;

/**
 *  隐藏gooeyMenu，或translation用这个属性
 */

@property (nonatomic, strong)UIView * mainView;

/**
 *  item的images
 */
@property (nonatomic, strong)NSMutableArray *menuImagesArray;

/**
 *  Initialize
 *
 *  @param origin     the origin of menu
 *  @param diameter   diameter直径
 *  @param superView  superView
 *  @param themeColor the theme color of menu and item
 *
 *  @return self
 */
-(id)initWithOrigin:(CGPoint)origin andDiameter:(CGFloat)diameter andSuperView:(UIView *)superView themeColor:(UIColor *)themeColor;


/**
 *  The delegate of KYGooeyMenu
 */
@property(nonatomic,weak)id<GooeyMenuDelegate> menuDelegate;

@end

//
//  JumpStarView.h
//  JumpStarDemo
//
//  Created by 林丹 on 2017/4/7.
//  Copyright © 2017年 Myron. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,START){
    NOMark,
    Mark
};


@interface JumpStarView : UIView

- (void)aniamtion;

@property (nonatomic,assign,setter=setState:)START state;
@property (nonatomic,strong)UIImage * markedImage;
@property (nonatomic, strong)UIImage *non_markedImage;

@end

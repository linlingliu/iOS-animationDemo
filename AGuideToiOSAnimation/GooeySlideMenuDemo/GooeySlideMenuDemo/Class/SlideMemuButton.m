//
//  SlideMemuButton.m
//  GooeySlideMenuDemo
//
//  Created by LX on 17/3/22.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "SlideMemuButton.h"

@interface SlideMemuButton ()
@property (nonatomic, strong)NSString * buttonTitle;

@end
@implementation SlideMemuButton

- (instancetype)initWithTitle:(NSString *)title{
    if (self=[super init]) {
        _buttonTitle=title;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);
    [self.buttonColor set];
    CGContextFillPath(context);
    UIBezierPath * _path=[UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1, 1) cornerRadius:rect.size.height/2];
    [self.buttonColor setFill];
    [_path fill];
    [[UIColor whiteColor]setStroke];
    _path.lineWidth=1;
    [_path stroke];//画线
    
    NSMutableParagraphStyle * _paragraphStyle=[[NSParagraphStyle defaultParagraphStyle]mutableCopy];
    _paragraphStyle.alignment=NSTextAlignmentCenter;
    NSDictionary * _att=@{NSParagraphStyleAttributeName:_paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:24.0],NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGSize size=[self.buttonTitle sizeWithAttributes:_att];
    CGRect r = CGRectMake(rect.origin.x,
                          rect.origin.y + (rect.size.height - size.height)/2.0,
                          rect.size.width,
                          size.height);
    [self.buttonTitle drawInRect:r withAttributes:_att];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    NSUInteger tapCount=touch.tapCount;
    switch (tapCount) {
        case 1:
            self.buttonClickBlock();
            break;
            
        default:
            break;
    }
}

@end

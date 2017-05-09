//
//  ViewController.m
//  GooeySlideMenuDemo
//
//  Created by LX on 17/3/22.
//  Copyright © 2017年 LX. All rights reserved.
//

/*
 CADisplayLink是一个定时器，每隔1/60秒刷新屏幕，要加入到runloop中
 duratiin:每帧的间隔
 frameInterval：隔多少针吊用一侧方法，如果是一每秒钟＝调用方法60次
 invalidate：结束，移除runloop和方法
 */
#import "ViewController.h"
#import "GooeySlideMenu.h"
#import "SlideMemuButton.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController
{
    GooeySlideMenu *menu;
    SlideMemuButton * _btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"首页";
    self.view.backgroundColor=[UIColor whiteColor];
    menu = [[GooeySlideMenu alloc]initWithTitles:@[@"首页",@"消息",@"发布",@"发现",@"个人",@"设置"]];
    menu.menuClickBlock = ^(NSInteger index,NSString *title,NSInteger titleCounts){
        NSLog(@"index:%ld title:%@ titleCounts:%ld",index,title,titleCounts);
    };

    _btn=[[SlideMemuButton alloc]initWithTitle:@"trigger"];
    _btn.frame=CGRectMake(100, 500, 200, 50);
    _btn.buttonColor=[UIColor cyanColor];
    _btn.buttonClickBlock=^{
        [menu trigger];
    };
    [self.view addSubview:_btn];

}

#pragma mark -- UITabel View Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"NO.%ld",(long)indexPath.row];
    return cell;
}



@end

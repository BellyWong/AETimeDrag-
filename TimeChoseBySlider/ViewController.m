//
//  ViewController.m
//  TimeChoseBySlider
//
//  Created by carshoel on 16/11/8.
//  Copyright © 2016年 carshoel. All rights reserved.
//

#import "ViewController.h"
#import "DateItemPickView.h"

@interface ViewController ()<DateItemPickViewDelegate>
@property (nonatomic, weak)UILabel *titleLbl;//时间标题
@property (nonatomic, weak)DateItemPickView *timeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1设置控制器view背景色
    self.view.backgroundColor = [UIColor redColor];
    
    //2 设置结果显示
    [self setUpResultShow];
    
    // 3 设置滑块式时间选择器
    [self setUpTimePicker];
    
}

//设置结果显示
- (void)setUpResultShow{
    CGFloat x = 30;
    CGFloat w = CGRectGetWidth(self.view.frame) - x * 2;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(x, 64, w, 64)];
    title.textAlignment = NSTextAlignmentCenter;
    title.numberOfLines = 0;
    title.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:title];
    self.titleLbl = title;
}

//设置滑块式时间选择器
- (void)setUpTimePicker{
    DateItemPickView *v = [[DateItemPickView alloc] init];
    v.delegate =self;
    [v work];
    self.timeView = v;
    CGRect frame = v.frame;
    frame.origin.y = CGRectGetMaxY(self.titleLbl.frame) + 20;
    v.frame = frame;
    [self.view addSubview:v];
}

#pragma mark - 代理
- (void)dateItemPickViewTimeChanged:(DateItemPickView *)view{
    self.titleLbl.text = [NSString stringWithFormat:@"通过拖动滑块来选择时间\n%@--%@",view.beginTime,view.endTime];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

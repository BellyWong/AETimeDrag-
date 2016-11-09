

//
//  DateItemView.m
//  DLZhiYuanMao
//
//  Created by carshoel on 16/9/29.
//  Copyright © 2016年 carshoel. All rights reserved.
//

#import "DateItemView.h"
#import "AEObjButton.h"
#import "UIImage+Color.h"
//获得RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define k3Font [UIFont systemFontOfSize:15]

@interface DateItemView ()

@property (nonatomic, weak)UILabel *titleL;



@end

@implementation DateItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleH = 16;
    }
    return self;
}

-(void)setIndex:(int)index{
    _index = index;
    self.titleL.text = [NSString stringWithFormat:@"%d",index];
    self.leftBtn.objs = @[@(index)];
    self.rightBtn.objs = @[@(index)];
}

-(void)setWidth:(CGFloat)width{
    _width = width;
    //标题
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = width;
    CGFloat h = _titleH;
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    titleL.font = k3Font;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.backgroundColor = [UIColor grayColor];
    [self addSubview:titleL];
    _titleL = titleL;
    
    
    //left
    y = CGRectGetMaxY(_titleL.frame);
    w = _width * 0.5;
    h = w;
    AEObjButton *leftBtn = [[AEObjButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
    leftBtn.tag = 1;

    leftBtn.backgroundColor = [UIColor whiteColor];
    leftBtn.userInteractionEnabled = NO;

    [leftBtn setImage:[UIImage imageWithColor:RGBColor(188, 212, 235) size:CGSizeMake(w, h)] forState:UIControlStateSelected];
    [self addSubview:leftBtn];
    _leftBtn = leftBtn;
    
    
    //right
    x = CGRectGetMaxX(leftBtn.frame);
    AEObjButton *rightBtn = [[AEObjButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
    rightBtn.tag = 2;
    rightBtn.backgroundColor = [UIColor whiteColor];
    rightBtn.userInteractionEnabled = NO;
     [rightBtn setImage:[UIImage imageWithColor:RGBColor(188, 212, 235) size:CGSizeMake(w, h)] forState:UIControlStateSelected];
    [self addSubview:rightBtn];
    _rightBtn = rightBtn;
    
    
    //画中间线条
    h = 20;
    y = CGRectGetMaxY(self.titleL.frame) + (w - h ) * 0.5;
    w = 1;
    CALayer *midLine = [[CALayer alloc] init];
    midLine.backgroundColor = [UIColor grayColor].CGColor;
    midLine.frame = CGRectMake(x, y, w, h);
    [self.layer addSublayer:midLine];
    
    //画左边
    x = -1;
    CALayer *lefLine = [[CALayer alloc] init];
    lefLine.backgroundColor = [UIColor grayColor].CGColor;
    lefLine.frame = CGRectMake(x, y, w, h);
    [self.layer addSublayer:lefLine];

}

-(CGRect)superFrameForLeftBtn{
    CGRect frame = self.leftBtn.frame;
    frame.origin.x += self.frame.origin.x;
    frame.origin.y += self.frame.origin.y;
    return frame;
}
- (CGRect)superFrameForRightBtn{
    CGRect frame = self.rightBtn.frame;
    frame.origin.x += self.frame.origin.x;
    frame.origin.y += self.frame.origin.y;
    return frame;
}





@end


//
//  DateItemPickView.m
//  DLZhiYuanMao
//
//  Created by carshoel on 16/9/29.
//  Copyright © 2016年 carshoel. All rights reserved.
//

#import "DateItemPickView.h"
#import "DateItemView.h"
#import "AEObjButton.h"

#define DEVICE_Width  [UIScreen mainScreen].bounds.size.width

@interface DateItemPickView ()

@property (nonatomic, strong)NSMutableArray <DateItemView *>*itemViews;

@property (nonatomic, weak)AEObjButton *beginBtn;
@property (nonatomic, weak)AEObjButton *endBtn;
@property (nonatomic, strong)NSArray *midBtns;

@property (nonatomic, weak)UIImageView *btn1;
@property (nonatomic, weak)UIImageView *btn2;

@property (nonatomic, weak)UIImageView *curentMoveView;

@end



@implementation DateItemPickView

-(NSString *)beginTime{
    NSNumber *i = self.beginBtn.objs.firstObject;
    NSString *str = [NSString stringWithFormat:@"%d:%02d",i.intValue,self.beginBtn.tag == 1 ? 00 : 30];
    return str;
}

-(NSString *)endTime{
    NSNumber *i = self.endBtn.objs.firstObject;
    NSString *str = [NSString stringWithFormat:@"%d:%02d",i.intValue,self.endBtn.tag == 1 ? 00 : 30];
    return str;
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //修正位置
    CGRect frame = self.curentMoveView.frame;
    DateItemView *selectedView = nil;//当前选中的view
    CGFloat x = self.curentMoveView.center.x;
    CGFloat y = self.curentMoveView.center.y;
    for (DateItemView *itemView in self.itemViews) {
        if(x >= CGRectGetMinX(itemView.frame) && x <= CGRectGetMaxX(itemView.frame) && y >= CGRectGetMinY(itemView.frame) && y <= CGRectGetMaxY(itemView.frame)){
            
            selectedView = itemView;
            break;
        }
    }
    
    if(x < selectedView.center.x){
        if(self.curentMoveView.tag == 1){
            self.beginBtn = selectedView.leftBtn;
        }else if(self.curentMoveView.tag == 2){
            self.endBtn = selectedView.leftBtn;
        }
        self.curentMoveView.frame = selectedView.superFrameForLeftBtn;

    }else{
        if(self.curentMoveView.tag == 1){
            self.beginBtn = selectedView.rightBtn;
        }else if(self.curentMoveView.tag == 2){
            self.endBtn = selectedView.rightBtn;
        }
        self.curentMoveView.frame = selectedView.superFrameForRightBtn;
    }
    [self resetMidBtns];
}

//计算两个点的位置
-(float)distanceFromPointX:(CGPoint)start distanceToPointY:(CGPoint)end{
    float distance;
    //下面就是高中的数学，不详细解释了
    CGFloat xDist = (end.x - start.x);
    CGFloat yDist = (end.y - start.y);
    distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    // Retrieve the touch point
    CGPoint beginPoint = [[touches anyObject] locationInView:self]; //记录第一个点，以便计算移动距离
//    NSLog(@"%f,%f",beginPoint.x,beginPoint.y);
    if(beginPoint.x > CGRectGetMinX(self.btn1.frame) && beginPoint.x < CGRectGetMaxX(self.btn1.frame) &&beginPoint.y > CGRectGetMinY(self.btn1.frame) && beginPoint.y < CGRectGetMaxY(self.btn1.frame)){
    
        self.curentMoveView = self.btn1;
    }
    
    if(beginPoint.x > CGRectGetMinX(self.btn2.frame) && beginPoint.x < CGRectGetMaxX(self.btn2.frame) &&beginPoint.y > CGRectGetMinY(self.btn2.frame) && beginPoint.y < CGRectGetMaxY(self.btn2.frame)){
        
        self.curentMoveView = self.btn2;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%@", touches);
    UITouch *touch = [touches anyObject];
    
    //当前的point
    CGPoint currentP = [touch locationInView:self];
    
    //以前的point
    CGPoint preP = [touch previousLocationInView:self];
    
    //x轴偏移的量
    CGFloat offsetX = currentP.x - preP.x;
    
    //Y轴偏移的量
    CGFloat offsetY = currentP.y - preP.y;
//
//    self.curentMoveView.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    
    CGRect frame = self.curentMoveView.frame;
    frame.origin.x += offsetX;
    frame.origin.y += offsetY;
    if(frame.origin.x < 0)return;
    if(frame.origin.x > DEVICE_Width - CGRectGetWidth(frame))return;
    
    frame.origin.y = currentP.y - frame.size.height * 0.5;
    if(frame.origin.y < 0)return;
    DateItemView *lastView = self.itemViews.lastObject;
    CGFloat lastY = CGRectGetMinY(lastView.frame) + lastView.titleH;
    if(frame.origin.y > lastY + 20)return;
    
    //当前拖拽
    if(self.curentMoveView.tag == 1){
        if(CGRectGetMaxX(frame) > self.btn2.frame.origin.x){//
            if(CGRectGetMaxY(frame) >= self.btn2.frame.origin.y + 20)return;
        }
        if(CGRectGetMinY(frame) > self.btn2.frame.origin.y + 20)return;//提供20的偏移量
    }else{
        if(CGRectGetMinX(frame) < CGRectGetMaxX(self.btn1.frame)){//
            if(CGRectGetMinY(frame) < CGRectGetMaxY(self.btn1.frame) - 20){
                return;
            }
        }
        if(CGRectGetMinY(frame) < CGRectGetMinY(self.btn1.frame) - 20){

            return;
        }
    }
    
    
    self.curentMoveView.frame = frame;
    
    
}

-(UIImageView *)btn1{
    if(!_btn1){
        UIImageView *btn1 = [[UIImageView alloc] init];
        btn1.tag = 1;
        btn1.userInteractionEnabled = YES;
        btn1.image = [UIImage imageNamed:@"btn_time_left"];
        [self addSubview:btn1];
        _btn1 = btn1;
    }
    return _btn1;
}

-(UIImageView *)btn2{
    if(!_btn2){
        UIImageView *btn2 = [[UIImageView alloc] init];
        btn2.tag = 2;
        btn2.userInteractionEnabled = YES;
        btn2.image = [UIImage imageNamed:@"btn_time_right"];
        [self addSubview:btn2];
        _btn2 = btn2;
    }
    return _btn2;
}


-(void)setBeginBtn:(AEObjButton *)beginBtn{
    _beginBtn = beginBtn;
    //更新中间状态
//    [self resetMidBtns];
    if([self.delegate respondsToSelector:@selector(dateItemPickViewTimeChanged:)]){
        [self.delegate dateItemPickViewTimeChanged:self];
    }
}

-(void)setEndBtn:(AEObjButton *)endBtn{
    _endBtn = endBtn;
//    [self resetMidBtns];
    if([self.delegate respondsToSelector:@selector(dateItemPickViewTimeChanged:)]){
        [self.delegate dateItemPickViewTimeChanged:self];
    }
}

- (void)resetMidBtns{
    
    NSNumber *beginNum = self.beginBtn.objs.firstObject;
    NSNumber *endNum = self.endBtn.objs.firstObject;
    
    
    for (DateItemView *itemView in self.itemViews) {
    
        if(itemView.index < beginNum.intValue){
            itemView.leftBtn.selected = NO;
            itemView.rightBtn.selected = NO;
        }
        
        if(itemView.index == beginNum.intValue){
            
            if(self.beginBtn.tag == 1){
                itemView.rightBtn.selected = YES;
            }else{
                itemView.leftBtn.selected = NO;
            }
        }
        
        if(itemView.index == endNum.intValue){
            
            if(self.endBtn.tag == 2){
                itemView.leftBtn.selected = YES;
            }else{
                itemView.rightBtn.selected = NO;
            }
        }
        
        if(itemView.index > endNum.intValue){
            itemView.leftBtn.selected = NO;
            itemView.rightBtn.selected = NO;
        }
        
        if(itemView.index > beginNum.intValue && itemView.index < endNum.intValue){
            itemView.leftBtn.selected = YES;
            itemView.rightBtn.selected = YES;
        }
    }
}


- (void)work{
    [self setAllItems];
}

- (NSMutableArray<DateItemView *> *)itemViews{

    if(!_itemViews){
        _itemViews = [NSMutableArray array];
    }
    return _itemViews;
}


- (void)setAllItems{

    int columns = 4;//每列显示4个
    CGFloat w = DEVICE_Width * 0.25;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat h = w * 0.5;
    
    int allCout = 24;
    
    for (int i = 0; i < allCout; i++) {
        
        DateItemView *v = [[DateItemView alloc] init];
        v.width  = w;
        v.index  = i;
        
        x = w * (i % columns);
        y = (h + v.titleH) * (i / columns);
        v.frame = CGRectMake(x, y, w, h + v.titleH);
        [self addSubview:v];
        [self.itemViews addObject:v];

        if(i == allCout - 1){//最后一个
        
            self.frame = CGRectMake(0, 0, DEVICE_Width, CGRectGetMaxY(v.frame));
            
        }
        
    }
    
    
    DateItemView *v = self.itemViews[9];
    self.btn1.frame = v.superFrameForLeftBtn;
    self.beginBtn = v.leftBtn;
    self.btn2.frame = v.superFrameForRightBtn;
    self.endBtn = v.rightBtn;
    
}



@end

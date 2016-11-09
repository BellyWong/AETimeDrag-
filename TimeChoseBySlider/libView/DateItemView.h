//
//  DateItemView.h
//  DLZhiYuanMao
//
//  Created by carshoel on 16/9/29.
//  Copyright © 2016年 carshoel. All rights reserved.
//  每一个时间格子

#import <UIKit/UIKit.h>
@class AEObjButton;

@interface DateItemView : UIView

@property (nonatomic, weak)AEObjButton *leftBtn;
@property (nonatomic, weak)AEObjButton *rightBtn;

@property (nonatomic, assign)CGFloat titleH;//16;
@property (nonatomic, assign)int index;//时间点
@property (nonatomic, assign)CGFloat width;//宽度
@property (nonatomic, assign)CGRect superFrameForLeftBtn;//在上层的frame
@property (nonatomic, assign)CGRect superFrameForRightBtn;

@end

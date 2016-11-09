//
//  DateItemPickView.h
//  DLZhiYuanMao
//
//  Created by carshoel on 16/9/29.
//  Copyright © 2016年 carshoel. All rights reserved.
//  时间time选择view  方格滑块式

#import <UIKit/UIKit.h>
@class DateItemPickView;


@protocol DateItemPickViewDelegate <NSObject>

@optional
- (void)dateItemPickViewTimeChanged:(DateItemPickView *)view;

@end

@interface DateItemPickView : UIView
@property (nonatomic, assign)NSString *beginTime;
@property (nonatomic, assign)NSString *endTime;
@property (nonatomic, weak)id<DateItemPickViewDelegate> delegate;

- (void)work;



@end

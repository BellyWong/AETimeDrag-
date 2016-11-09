//
//  AEObjButton.h
//  DLZhiYuanMao
//
//  Created by carshoel on 16/8/26.
//  Copyright © 2016年 carshoel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEObjButton : UIButton

@property (nonatomic, weak)id obj;//保存一个参数

@property (nonatomic, strong)NSArray *objs;//保存多个参数

@end

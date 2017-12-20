//
//  yuan.h
//  ratior
//
//  Created by 顾卫明的mac on 2017/12/13.
//  Copyright © 2017年 顾卫明的mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface yuan : UIView
@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, strong) NSMutableArray *anglepencent;
@property (nonatomic, strong) NSMutableArray *anglename;

//金额的字体大小
@property (nonatomic, copy) NSString *textfont;
//金额的字体颜色
@property (nonatomic, copy) NSString *textcolor;
//金额单位的文字内容
@property (nonatomic, copy) NSString *textunit;
//金额单位的文字大小
@property (nonatomic, copy) NSString *textunitfont;
//金额单位的文字颜色
@property (nonatomic, copy) NSString *textunitcolor;
//大圆盘的颜色
@property (nonatomic, copy) NSString *bigcolor;
//小圆盘的颜色
@property (nonatomic, copy) NSString *smallcolor;
- (void)start;
@end

//
//  TERatior.m
//  Tiny
//
//  Created by 顾卫明的mac on 2017/12/15.
//  Copyright © 2017年 xiangfp. All rights reserved.
//

#import "TERatior.h"
#import "yuan.h"
#import "UIColorAdditions.h"

@interface TERatior()<CAAnimationDelegate>
@property (nonatomic, strong) yuan *aaa;
@property (nonatomic, strong) UIImageView *imgeview;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, strong) NSMutableArray *anglepencent;//每块的角度。
@property (nonatomic, strong) NSMutableArray *anglename;//每块的名字。

//金额的字体大小
@property (nonatomic, copy) NSString *textFont;
//金额的字体颜色
@property (nonatomic, copy) NSString *textColor;
//金额单位的文字内容
@property (nonatomic, copy) NSString *textUnit;
//金额单位的文字大小
@property (nonatomic, copy) NSString *textUnitFont;
//金额单位的文字颜色
@property (nonatomic, copy) NSString *textUnitColor;
//大圆盘的颜色
@property (nonatomic, copy) NSString *bigColor;
//小圆盘的颜色
@property (nonatomic, copy) NSString *smallColor;
//闪烁的间隔 单位MS
@property (nonatomic, copy) NSString *intervalTime;
//圆盘转速
@property (nonatomic, copy) NSString *speed;
//圆盘最后的角度
@property (nonatomic, copy) NSString *result;

@property (nonatomic, strong) UIButton *button;
@end
@implementation TERatior

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.bigColor = @"#ff0000";
        self.smallColor = @"#ADFF2F";
        self.textFont = @"15";
        self.textUnit = @"元";
        self.textUnitColor = @"#000000";
        self.textColor = @"#000000";
        self.textUnitFont = @"15";
        self.result = @"45";
        self.intervalTime = @"500";
        self.speed = @"180";
    }
    return self;
}


-(void)setParam:(NSString *)name :(id)value{
    if ([name isEqualToString:@"data"]) {
        NSArray *json= value;
        for (int i=0; i<json.count; i++) {
            [self.anglename addObject:[json[i] objectForKey:@"data"]];
            [self.anglepencent addObject:[json[i] objectForKey:@"angle"]];
        }
    }
    if ([name isEqualToString:@"params"]) {
        NSDictionary *json= value;
        if ([json objectForKey:@"bigColor"]) {
            self.bigColor = [json objectForKey:@"bigColor"];
        }
        if ([json objectForKey:@"smallColor"]) {
            self.smallColor = [json objectForKey:@"smallColor"];
        }
        if ([json objectForKey:@"textFont"]) {
            self.textFont = [json objectForKey:@"textFont"];
        }
        if ([json objectForKey:@"textColor"]) {
            self.textColor = [json objectForKey:@"textColor"];
        }
        if ([json objectForKey:@"textUnit"]) {
            self.textUnit = [json objectForKey:@"textUnit"];
        }
        if ([json objectForKey:@"textUnitFont"]) {
            self.textUnitFont = [json objectForKey:@"textUnitFont"];
        }
        if ([json objectForKey:@"textUnitColor"]) {
            self.textUnitColor = [json objectForKey:@"textUnitColor"];
        }
        if ([json objectForKey:@"intervalTime"]) {
            self.intervalTime = [json objectForKey:@"intervalTime"];
        }
        if ([json objectForKey:@"speed"]) {
            self.speed = [json objectForKey:@"speed"];
        }
        
    }
    if ([name isEqualToString:@"params"]) {
        NSDictionary *json= value;
        if ([json objectForKey:@"result"]) {
            self.result = [json objectForKey:@"result"];
        }
    }
    
    else if([name isEqualToString:@"bigColor"]){
        self.bigColor = value;
    }
    else if([name isEqualToString:@"smallColor"]){
        self.smallColor = value;
    }
    else if([name isEqualToString:@"textFont"]){
        self.textFont = value;
    }else if([name isEqualToString:@"textColor"]){
        self.textColor = value;
    }else if([name isEqualToString:@"textUnit"]){
        self.textUnit = value;
    }else if([name isEqualToString:@"textUnitFont"]){
        self.textUnitFont = value;
    }else if([name isEqualToString:@"textUnitColor"]){
        self.textUnitColor = value;
    }else if([name isEqualToString:@"intervalTime"]){
        self.intervalTime = value;
    }else if([name isEqualToString:@"speed"]){
        self.speed = value;
    }else if([name isEqualToString:@"result"]){
        self.result = value;
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x= self.frame.size.width;
    CGFloat y= self.frame.size.height;
    if (x<=y&&x!=100) {
        y=x;
        self.x =x;
        self.y = y;
        [self creatview];
    }
    if (x>y&&x!=100){
        x=y;
        self.x =x;
        self.y = y;
        [self creatview];
    }
    
}

- (void)creatview {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIImageView *imgeview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.x, self.y)];
        imgeview.image = [UIImage imageNamed:@"TERatior.bundle/26"];
        [self addSubview:imgeview];
        UIImageView *imgeview2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.x, self.y)];
        imgeview2.image = [UIImage imageNamed:@"TERatior.bundle/24"];
        [self addSubview:imgeview2];
        
        NSMutableArray *ary=[NSMutableArray new];
        
        //通过for 循环,把我所有的 图片存到数组里面
        UIImage *image=[UIImage imageNamed:@"TERatior.bundle/24"];
        [ary addObject:image];
        UIImage *image1=[UIImage imageNamed:@"TERatior.bundle/25"];
        [ary addObject:image1];
        
        // 设置图片的序列帧 图片数组
        imgeview2.animationImages=ary;
        //动画重复次数
        imgeview2.animationRepeatCount=8;
        //动画执行时间,多长时间执行完动画
        imgeview2.animationDuration=[self.intervalTime floatValue]/1000;
        //开始动画
        self.imgeview = imgeview2;
        
        
    });
    
    self.aaa = [[yuan alloc] initWithFrame:CGRectMake(30, 30, self.x-60, self.y-60)];
    self.aaa.anglename = self.anglename;
    self.aaa.anglepencent = self.anglepencent;
    self.aaa.bigcolor = self.bigColor;
    self.aaa.smallcolor = self.smallColor;
    self.aaa.textfont = self.textFont;
    self.aaa.textunit = self.textUnit;
    self.aaa.textunitcolor = self.textUnitColor;
    self.aaa.textcolor = self.textColor;
    self.aaa.textunitfont = self.textUnitFont;
    [self.aaa start];
    [self addSubview:self.aaa];
    
    if(!self.button){
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.x/2-35,self.x/2-60, 70, 90)];
        [button setImage:[UIImage imageNamed:@"TERatior.bundle/23.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"TERatior.bundle/23.png"] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.button = button;
    }
    
    
}

-(void)startAnimation{
    self.button.userInteractionEnabled = NO;
    [self.imgeview startAnimating];
    CGFloat turnAngle = [self.result floatValue];//8个奖励分别对应的角度
    CGFloat perAngle = M_PI/180.0;
    
    CGFloat jiquan = (8*[self.intervalTime floatValue]/1000) *([self.speed floatValue])/360;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(turnAngle)* perAngle + 360 * perAngle*jiquan];
    rotationAnimation.duration = 8*[self.intervalTime floatValue]/1000;
    rotationAnimation.speed = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.aaa.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8*[self.intervalTime floatValue]/1000 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.button.userInteractionEnabled = YES;
    });
    
}

-(NSMutableArray *)anglename{
    if (!_anglename) {
        self.anglename=[[NSMutableArray alloc]init];
    }
    return _anglename   ;
}

-(NSMutableArray *)anglepencent{
    if (!_anglepencent) {
        self.anglepencent=[[NSMutableArray alloc]init];
    }
    return _anglepencent   ;
}

@end


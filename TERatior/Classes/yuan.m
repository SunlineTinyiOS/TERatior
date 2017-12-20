//
//  yuan.m
//  ratior
//
//  Created by 顾卫明的mac on 2017/12/13.
//  Copyright © 2017年 顾卫明的mac. All rights reserved.
//

#import "yuan.h"
#import "UIColorAdditions.h"


#define kDegreesToRadians(degrees)  ((M_PI * degrees)/ 180)
#define AKAngle(radian) (radian / M_PI * 180.f)
#define AKCos(a) cos(a / 180.f * M_PI)
#define AKSin(a) sin(a / 180.f * M_PI)
@implementation yuan

-(instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        self.frame = frame;
        self.radius = self.frame.size.width*0.5;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width*0.5;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
    
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 1.获取上下文
    CGFloat degreesold = -90;
    CGFloat degreesnew = 0;
    CGFloat oldaaaaaa=0;
    for (int i=0; i<self.anglepencent.count; i++) {
        degreesnew =  degreesold + [self.anglepencent[i] floatValue];
 
        //圆心
        double x= self.frame.size.width/2;
        double y= self.frame.size.height/2;
        
        //大圆
        CGContextSetFillColorWithColor(context, [UIColor colorWithHex:self.bigcolor].CGColor);//填充颜色
        CGContextMoveToPoint(context, x, y);
        CGContextAddArc(context, x, y, self.radius, (degreesold)* M_PI / 180, (degreesnew) * M_PI / 180, 0);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathEOFillStroke); //绘制路径
        
        //小圆
        CGContextSetFillColorWithColor(context, [UIColor colorWithHex:self.smallcolor].CGColor);//填充颜色
        //以10为半径围绕圆心画指定角度扇形
        CGContextMoveToPoint(context, x, y);
        CGContextAddArc(context, x, y, self.radius*0.8, (degreesold)* M_PI / 180, (degreesnew) * M_PI / 180, 0);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathEOFillStroke); //绘制路径
        
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%@",self.anglename[i]];
        label.font = [UIFont systemFontOfSize:[self.textfont floatValue]];
        label.textColor = [UIColor colorWithHex:self.textcolor];
        label.numberOfLines = 0;
        label.frame = CGRectMake(x-25,y-self.radius*0.8, 50, 20);
        float labelDegees = ([self.anglepencent[i] floatValue]/2 + oldaaaaaa);
        float centerX = AKSin(labelDegees) * 2 * self.frame.size.width / 5.f + self.radius;
        float centerY = self.radius - AKCos(labelDegees) * 2 * self.frame.size.height / 5.f;
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(centerX, centerY);
        [self addSubview:label];
        label.transform = CGAffineTransformRotate(label.transform, kDegreesToRadians(labelDegees));
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.text = self.textunit;
        label1.font = [UIFont systemFontOfSize:[self.textunitfont floatValue]];
        label1.textColor = [UIColor colorWithHex:self.textunitcolor];
        label1.numberOfLines = 0;
        label1.frame = CGRectMake(x-25,y-self.radius*0.8, 50, 20);
        float labelDegees1 = ([self.anglepencent[i] floatValue]/2 + oldaaaaaa);
        float centerX1 = AKSin(labelDegees) * 2 * self.frame.size.width / 6.f + self.radius;
        float centerY1 = self.radius - AKCos(labelDegees) * 2 * self.frame.size.height / 6.f;
        label1.textAlignment = NSTextAlignmentCenter;
        label1.center = CGPointMake(centerX1, centerY1);
        [self addSubview:label1];
        label1.transform = CGAffineTransformRotate(label1.transform, kDegreesToRadians(labelDegees1));
        
        degreesold = degreesnew;
        oldaaaaaa = [self.anglepencent[i] floatValue] + oldaaaaaa;
    }
}

- (void)start{
    [self setNeedsDisplay];
}




@end

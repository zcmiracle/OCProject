//
//  Gauge.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/10/19.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Gauge.h"
#import <QuartzCore/QuartzCore.h>
  #import "NSString+FLTextSize.h"
  #import "UIView+FLFrame.h"
#define MAXOFFSETANGLE 130.0f
#define POINTEROFFSET  90.0f

#define MAXVALUE       100.0f
#define CELLMARKNUM    10
#define CELLNUM        10
#define GAUGESTRING    @"温度"
#define DEFLUATSIZE    200

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 2.获取RGB颜色 + 透明度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 3.获取RGB颜色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface Gauge (private)

- (CGFloat)parseToX:(CGFloat)radius Angle:(CGFloat)angle;
- (CGFloat)parseToY:(CGFloat)radius Angle:(CGFloat)angle;
- (CGFloat)transToRadian:(CGFloat)angel;
- (CGFloat)parseToAngle:(CGFloat)val;
- (CGFloat)parseToValue:(CGFloat)val;
- (void)setTextLabel:(NSInteger)labelNum;
- (void)setLineMark:(NSInteger)labelNum;
- (void)pointToAngle:(CGFloat)angle Duration:(CGFloat)duration;
@end
  
@implementation Gauge
  
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景透明
        [self setBackgroundColor:[UIColor clearColor]];
        
        // 默认200
        scoleNum = DEFLUATSIZE/frame.size.width;
        // 最大值
        maxNum = MAXVALUE;
        // 最小值
        minNum = -40.0f;
        minAngle = -MAXOFFSETANGLE;
        maxAngle = MAXOFFSETANGLE;
        gaugeValue = -40.0f;
        gaugeAngle = -MAXOFFSETANGLE;
        
        // 120-(120) / 100-(-40) = 240 /180
        // 角度/
        angleperValue = (maxAngle - minAngle)/(maxNum - minNum);
          
        self.gaugeView = [UIImage imageNamed:@"gaugeback.png"];
        //添加指针
        UIImage *_pointer = [UIImage imageNamed:@"zhizhen"];
        self.pointer2 = [[UIImageView alloc] initWithImage:_pointer];
        self.pointer2.layer.anchorPoint = CGPointMake(0.5, 0.78);
        self.pointer2.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-90);
        self.pointer2.transform = CGAffineTransformMakeScale(scoleNum, scoleNum);
        [self addSubview:self.pointer2];
        //设置文字标签
//        [self setTextLabel:CELLNUM];
        //设置指针到0位置
        self.pointer2.layer.transform = CATransform3DMakeRotation([self transToRadian:-MAXOFFSETANGLE], 0, 0, 1);
        
        _trackColor = [UIColor colorWithWhite:1 alpha:0.0];
        _lineWidth = 6;
        _progressColor = [UIColor grayColor];
        _progressLineCap = kCALineCapSquare;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cornerRadius = MIN(self.fl_width, self.fl_height) * 0.5 - self.lineWidth * 0.5;
}

#pragma mark - Draw

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    [super drawLayer:layer inContext:ctx];
    [self fl_drawCircleBackgroundLayer];
    [self fl_drawProgressLayer];
}

- (void)fl_drawCircleBackgroundLayer {
    //从 π/2 开始绘制一个圆形导轨
    CGPoint center = CGPointMake(self.fl_width * 0.5, self.fl_height * 0.5);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 2 endAngle:2 * M_PI + M_PI / 2 clockwise:YES];
    self.circleBackgroundLayer.path = circlePath.CGPath;
    
    [self.layer addSublayer:self.circleBackgroundLayer];
}

- (void)fl_drawProgressLayer {
    
    if (ScreenWidth == 320) {
        
    } else if (ScreenWidth == 375) {
        
    } else if (ScreenWidth == 414) {
        
    }
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15, 0, self.fl_width-30, self.fl_height);
    
    NSLog(@"%.2f", self.fl_width);
    
    NSLog(@"%.2f", self.fl_height);

    //从 π/2 开始绘制一个进度
    CGPoint center = CGPointMake(self.fl_width * 0.5, self.fl_height * 0.5);
    // 创建弧线路径 startAngle 开始角度  endAngle结束角度
    UIBezierPath *progressPath =  [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 180 * 141 endAngle: M_PI / 180 * 245 clockwise:YES];
    UIBezierPath *progressPath1 = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 180 * 246 endAngle: M_PI / 180 * 269 clockwise:YES];
    UIBezierPath *progressPath2 = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 180 * 272 endAngle: M_PI / 180 * 399 clockwise:YES];
    
    self.progressLayer.path = progressPath.CGPath;
    self.progressLayer.strokeStart = 0.0;
    self.progressLayer.strokeEnd = 1.0;
    [self.circleBackgroundLayer addSublayer:self.progressLayer];
    
    self.progressLayer1.path = progressPath1.CGPath;
    self.progressLayer1.strokeStart = 0.0;
    self.progressLayer1.strokeEnd = 1.0;
    [self.circleBackgroundLayer addSublayer:self.progressLayer1];

    self.progressLayer2.path = progressPath2.CGPath;
    self.progressLayer2.strokeStart = 0.0;
    self.progressLayer2.strokeEnd = 1.0;

    [self.circleBackgroundLayer addSublayer:self.progressLayer];
    [self.circleBackgroundLayer addSublayer:self.progressLayer1];
    [self.circleBackgroundLayer addSublayer:self.progressLayer2];
    [self.circleBackgroundLayer addSublayer:self.progressLayer3];
}

#pragma mark - Setter
- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    self.circleBackgroundLayer.strokeColor = trackColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.circleBackgroundLayer.lineWidth = lineWidth;
    self.progressLayer.lineWidth = lineWidth;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.progressLayer.strokeEnd = progress;
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgressLineCap:(CAShapeLayerLineCap)progressLineCap {
    _progressLineCap = progressLineCap;
    self.progressLayer.lineCap = progressLineCap;
}

#pragma mark - lazy load.

- (CAShapeLayer *)circleBackgroundLayer {
    if (!_circleBackgroundLayer) {
        _circleBackgroundLayer = [CAShapeLayer layer];
        _circleBackgroundLayer.lineWidth = self.lineWidth;
        _circleBackgroundLayer.strokeColor = self.trackColor.CGColor;
        _circleBackgroundLayer.fillColor = [UIColor clearColor].CGColor;
        _circleBackgroundLayer.lineCap = kCALineCapButt;
    }
    return _circleBackgroundLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.lineWidth = self.lineWidth;
        _progressLayer.strokeColor = RGB(58, 134, 239).CGColor;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineCap = self.progressLineCap;
    }
    return _progressLayer;
}

- (CAShapeLayer *)progressLayer1 {
    if (!_progressLayer1) {
        _progressLayer1 = [CAShapeLayer layer];
        _progressLayer1.lineWidth = self.lineWidth;
        _progressLayer1.strokeColor = RGB(68, 145, 110).CGColor;
        _progressLayer1.fillColor = [UIColor clearColor].CGColor;
        _progressLayer1.lineCap = self.progressLineCap;
    }
    return _progressLayer1;
}

- (CAShapeLayer *)progressLayer2 {
    if (!_progressLayer2) {
        _progressLayer2 = [CAShapeLayer layer];
        _progressLayer2.lineWidth = self.lineWidth;
        _progressLayer2.strokeColor = RGB(203, 91, 82).CGColor;
        _progressLayer2.fillColor = [UIColor clearColor].CGColor;
        _progressLayer2.lineCap = self.progressLineCap;
    }
    return _progressLayer2;
}

- (CAShapeLayer *)progressLayer3 {
    if (!_progressLayer3) {
        _progressLayer3 = [CAShapeLayer layer];
        _progressLayer3.lineWidth = self.lineWidth;
        _progressLayer3.strokeColor = [UIColor greenColor].CGColor;
        _progressLayer3.fillColor = [UIColor clearColor].CGColor;
        _progressLayer3.lineCap = self.progressLineCap;
    }
    return _progressLayer3;
}
/*
 * setTextLabel 绘制刻度值
 * @labelNum NSInteger 刻度值的数目
 */
- (void)setTextLabel:(NSInteger)labelNum {
    
    self.labelArray = [NSMutableArray arrayWithCapacity:labelNum];
    
    CGFloat textDis = (maxNum - minNum)/labelNum;
    CGFloat angelDis = (maxAngle - minAngle)/labelNum;
    CGFloat radius = (self.center.x - 50)*scoleNum;
    CGFloat currentAngle;
    CGFloat currentText = 0.0f;
    CGPoint centerPoint = self.center;
    
    for(int i = 0; i <= labelNum; i ++) {
        
        currentAngle = minAngle + i * angelDis - POINTEROFFSET;
        currentText = minNum + i * textDis;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        label.autoresizesSubviews = YES;
        label.font = [UIFont systemFontOfSize:11];
        label.backgroundColor = [UIColor clearColor];
        // 设置刻度的文字的格式
        if(i < labelNum/2){
            label.textAlignment = NSTextAlignmentCenter;
        } else if (i==labelNum/2){
            label.textAlignment = NSTextAlignmentCenter;
        } else {
            label.textAlignment = NSTextAlignmentCenter;
        }
        
        if (i == 0 || i == 1 || i == 2 || i == 3 || i ==4) {
            label.textColor = RGB(58, 134, 239);
        } else if (i == 5) {
            label.textColor = RGB(68, 145, 110);
        } else {
            label.textColor = RGB(203, 91, 82);
        }
        
        label.text = [NSString stringWithFormat:@"%d",(int)currentText];
        label.center = CGPointMake(centerPoint.x+[self parseToX:radius Angle:currentAngle],
                                   centerPoint.y+[self parseToY:radius Angle:currentAngle]);
        [self.labelArray addObject:label];
        [self addSubview:label];
    }
    
    // 设置刻度表的名称
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 ,100, 40)];
    label.autoresizesSubviews = YES;
    label.font = [UIFont boldSystemFontOfSize:22];
    label.textColor = RGB(68, 145, 110);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%.f℃", gaugeValue];
    label.center = CGPointMake(centerPoint.x, centerPoint.y*3/2);
    [self addSubview:label];
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 ,100, 40)];
    label1.autoresizesSubviews = YES;
    label1.font = [UIFont boldSystemFontOfSize:18];
    label1.textColor = [UIColor whiteColor];
    label1.backgroundColor = [UIColor clearColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = GAUGESTRING;
    label1.center = CGPointMake(centerPoint.x, centerPoint.y*3/2 + 30);
    [self addSubview:label1];
}
  
/*
 * setLineMark 绘制刻度的标记
 * @labelNum NSInteger 刻度是数目
 */
- (void)setLineMark:(NSInteger)labelNum {
  
    CGFloat angelDis = (maxAngle - minAngle)/labelNum;
    CGFloat radius = self.center.x;
    CGFloat currentAngle;
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
      
    for(int i = 0; i <= labelNum;i ++) {
        currentAngle = minAngle + i * angelDis - POINTEROFFSET;
        //给刻度标记绘制不同的颜色
        if (i <= labelNum*2/5 + 1) {
            CGContextSetStrokeColorWithColor(self.context, RGB(58, 134, 239).CGColor);
        } else if (i > labelNum*1/10 && i < labelNum*1/2+2) {
            CGContextSetStrokeColorWithColor(self.context, RGB(68, 145, 110).CGColor);
        } else {
            CGContextSetStrokeColorWithColor(self.context, RGB(203, 91, 82).CGColor);
        }
        NSLog(@"%.2f", centerPoint.x);
        //绘制不同的长短的刻度
        if (i%10 == 0) {
            CGContextSetLineCap(self.context, kCGLineCapSquare);
            CGContextSetLineWidth(self.context, 1.5);
            CGContextStrokePath(self.context);
            CGContextMoveToPoint(self.context,
                                 centerPoint.x+[self parseToX:radius-10*scoleNum Angle:currentAngle],
                                 centerPoint.y+[self parseToY:radius-10*scoleNum Angle:currentAngle]);
            // SE适配 20
            CGContextAddLineToPoint(self.context,
                                    centerPoint.x+[self parseToX:radius-20*scoleNum Angle:currentAngle],
                                    centerPoint.y+[self parseToY:radius-20*scoleNum Angle:currentAngle]);
        } else {
            CGContextSetLineWidth(self.context, 1.5);
            CGContextSetLineCap(self.context, kCGLineCapSquare);
            CGContextStrokePath(self.context);
            CGContextMoveToPoint(self.context,
                                 centerPoint.x+[self parseToX:radius-10*scoleNum Angle:currentAngle],
                                 centerPoint.y+[self parseToY:radius-10*scoleNum Angle:currentAngle]);
            CGContextAddLineToPoint(self.context,
                                    centerPoint.x+[self parseToX:radius-15*scoleNum Angle:currentAngle],
                                    centerPoint.y+[self parseToY:radius-15*scoleNum Angle:currentAngle]);
        }
        
        //绘制不同的长短的刻度
        //        if (i%10 == 0) {
        //            CGContextSetLineCap(self.context, kCGLineCapSquare);
        //            CGContextSetLineWidth(self.context, 1.5);
        //            CGContextStrokePath(self.context);
        //            CGContextMoveToPoint(self.context,
        //                                 centerPoint.x+[self parseToX:radius-scoleNum Angle:currentAngle],
        //                                 centerPoint.y+[self parseToY:radius-scoleNum Angle:currentAngle]);
        //            // SE适配 20
        //            CGContextAddLineToPoint(self.context,
        //                                    centerPoint.x+[self parseToX:radius-20*scoleNum Angle:currentAngle],
        //                                    centerPoint.y+[self parseToY:radius-20*scoleNum Angle:currentAngle]);
        //        } else {
        //            CGContextSetLineWidth(self.context, 1.5);
        //            CGContextSetLineCap(self.context, kCGLineCapSquare);
        //            CGContextStrokePath(self.context);
        //            CGContextMoveToPoint(self.context,
        //                                 centerPoint.x+[self parseToX:radius-scoleNum Angle:currentAngle],
        //                                 centerPoint.y+[self parseToY:radius-scoleNum Angle:currentAngle]);
        //            CGContextAddLineToPoint(self.context,
        //                                    centerPoint.x+[self parseToX:radius-10*scoleNum Angle:currentAngle],
        //                                    centerPoint.y+[self parseToY:radius-10*scoleNum Angle:currentAngle]);
        //        }
        //
        //        if (i%10 == 0) {
        //                   CGContextSetLineCap(self.context, kCGLineCapSquare);
        //                   CGContextSetLineWidth(self.context, 1.5);
        //                   CGContextStrokePath(self.context);
        //                   CGContextMoveToPoint(self.context,
        //                                        centerPoint.x+[self parseToX:radius-scoleNum Angle:currentAngle],
        //                                        centerPoint.y+[self parseToY:radius-scoleNum Angle:currentAngle]);
        //                   // SE适配 20
        //                   CGContextAddLineToPoint(self.context,
        //                                           centerPoint.x+[self parseToX:radius-20*scoleNum Angle:currentAngle],
        //                                           centerPoint.y+[self parseToY:radius-20*scoleNum Angle:currentAngle]);
        //               } else {
        //                   CGContextSetLineWidth(self.context, 1.5);
        //                   CGContextSetLineCap(self.context, kCGLineCapSquare);
        //                   CGContextStrokePath(self.context);
        //                   CGContextMoveToPoint(self.context,
        //                                        centerPoint.x+[self parseToX:radius-scoleNum Angle:currentAngle],
        //                                        centerPoint.y+[self parseToY:radius-scoleNum Angle:currentAngle]);
        //                   CGContextAddLineToPoint(self.context,
        //                                           centerPoint.x+[self parseToX:radius-10*scoleNum Angle:currentAngle],
        //                                           centerPoint.y+[self parseToY:radius-10*scoleNum Angle:currentAngle]);
        //               }
        //           }
    }
}
  
/*
 * setGaugeValue 移动到某个数值
 * @value CGFloat 移动到的数值
 * @isAnim BOOL   是否执行动画
 */
- (void)setGaugeValue:(CGFloat)value animation:(BOOL)isAnim {
    CGFloat tempAngle = [self parseToAngle:value];
    gaugeValue = value;
    
    // 重新设置刻度
    
    //设置转动时间和转动动画
    if(isAnim){
        [self pointToAngle:tempAngle Duration:0.6f];
    } else {
        [self pointToAngle:tempAngle Duration:0.0f];
    }
}
  
/*
 * pointToAngle 按角度旋转
 * @angel CGFloat 角度
 * @duration CGFloat 动画执行时间
 */
- (void)pointToAngle:(CGFloat)angle Duration:(CGFloat)duration {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSMutableArray *values = [NSMutableArray array];
    anim.duration = duration;
    anim.autoreverses = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion= NO;
      
    CGFloat distance = angle/10;
    //设置转动路径，不能直接用 CABaseAnimation 的toValue，那样是按最短路径的，转动超过180度时无法控制方向
    int i = 1;
    for(; i <= 10; i ++){
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, [self transToRadian:(gaugeAngle+distance*i)], 0, 0, 1)]];
        }
     // 添加缓动效果
     [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, [self transToRadian:(gaugeAngle+distance*(i))], 0, 0, 1)]];
     [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, [self transToRadian:(gaugeAngle+distance*(i-2))], 0, 0, 1)]];
     [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, [self transToRadian:(gaugeAngle+distance*(i-1))], 0, 0, 1)]];
                                                                             
    anim.values=values; ;
    [self.pointer2.layer addAnimation:anim forKey:@"cubeIn"];
      
    gaugeAngle = gaugeAngle+angle;
}
  
/*
 * parseToX 角度转弧度
 * @angel CGFloat 角度
 */
- (CGFloat)transToRadian:(CGFloat)angel {
    return angel*M_PI/180;
}
  
  
/*
 * parseToX 根据角度，半径计算X坐标
 * @radius CGFloat 半径
 * @angle  CGFloat 角度
 */
- (CGFloat)parseToX:(CGFloat)radius Angle:(CGFloat)angle {
    CGFloat tempRadian = [self transToRadian:angle];
    return radius*cos(tempRadian);
}
  
/*
 * parseToY 根据角度，半径计算Y坐标
 * @radius CGFloat 半径
 * @angle  CGFloat 角度
 */
- (CGFloat)parseToY:(CGFloat)radius Angle:(CGFloat)angle {
    CGFloat tempRadian = [self transToRadian:angle];
    return radius * sin(tempRadian);
}
  
/*
 * parseToAngle 根据数据计算需要转动的角度
 * @val CGFloat 要移动到的数值
 */
- (CGFloat)parseToAngle:(CGFloat)val {
    //异常的数据
    if(val<minNum){
        return minNum;
    }else if(val>maxNum){
        return maxNum;
    }
    CGFloat temp =(val-gaugeValue)*angleperValue;
    return temp;
}
  
/*
 * parseToValue 根据角度计算数值
 * @val CGFloat 要移动到的角度
 */
- (CGFloat)parseToValue:(CGFloat)val {
    CGFloat temp=val/angleperValue;
    CGFloat temp2=maxNum/2+temp;
    if(temp2>maxNum){
        return maxNum;
    }else if(temp2<maxNum){
        return maxNum;
    }
    return temp2;
}

- (void)drawRect:(CGRect)rect {
    //获取上下文
    self.context = UIGraphicsGetCurrentContext();
    //设置背景透明
    CGContextSetFillColorWithColor(self.context,self.backgroundColor.CGColor);
    CGContextFillRect(self.context, rect);
    //绘制仪表背景
    [[self gaugeView ]drawInRect:self.bounds];
    //绘制刻度
    [self setLineMark:CELLNUM*CELLMARKNUM];
    
    [self setTextLabel:CELLNUM];
    
//    [self.layer addSublayer:self.progressLayer];
//    self.progressLayer.strokeEnd = 1;

    CGContextStrokePath(self.context);
}
  
@end

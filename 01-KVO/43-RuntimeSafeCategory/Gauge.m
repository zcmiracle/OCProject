//
//  Gauge.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/10/19.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Gauge.h"
#import <QuartzCore/QuartzCore.h>
  
#define MAXOFFSETANGLE 130.0f
#define POINTEROFFSET  90.0f

#define MAXVALUE       100.0f
#define CELLMARKNUM    10
#define CELLNUM        10
#define GAUGESTRING    @"温度"
#define DEFLUATSIZE    200
/************************************************
    仪表盘的大小不建议设置的太小。
    长宽都是300是最适合的
    如果要更小的需要自行修改刻度长度和文字大小
                            ---powered by 周海锋
                                2012-3-29
 ***********************************************/
  

@interface Gauge (private)
- (CGFloat) parseToX:(CGFloat) radius Angle:(CGFloat)angle;
- (CGFloat) parseToY:(CGFloat) radius Angle:(CGFloat)angle;
- (CGFloat) transToRadian:(CGFloat)angel;
- (CGFloat) parseToAngle:(CGFloat) val;
- (CGFloat) parseToValue:(CGFloat) val;
- (void)setTextLabel:(NSInteger)labelNum;
- (void)setLineMark:(NSInteger)labelNum;
- (void) pointToAngle:(CGFloat) angle Duration:(CGFloat) duration;
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
        self.pointer2.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-100);
        self.pointer2.transform = CGAffineTransformMakeScale(scoleNum, scoleNum);
        [self addSubview:self.pointer2];
        //设置文字标签
//        [self setTextLabel:CELLNUM];
        //设置指针到0位置
        self.pointer2.layer.transform = CATransform3DMakeRotation([self transToRadian:-MAXOFFSETANGLE], 0, 0, 1);
    }
    return self;
}
  
/*
 * setTextLabel 绘制刻度值
 * @labelNum NSInteger 刻度值的数目
 */
-(void)setTextLabel:(NSInteger)labelNum {
    
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
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
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
             label.textColor = [UIColor colorWithRed:58/255.0 green:134/255.0 blue:239/255.0 alpha:1];
         } else if (i == 5) {
             label.textColor = [UIColor colorWithRed:68/255.0 green:145/255.0 blue:110/255.0 alpha:1];
         } else {
             label.textColor = [UIColor colorWithRed:203/255.0 green:91/255.0 blue:82/255.0 alpha:1];
         }
    
        label.text = [NSString stringWithFormat:@"%d",(int)currentText];
        label.center = CGPointMake(centerPoint.x+[self parseToX:radius Angle:currentAngle],
                                   centerPoint.y+[self parseToY:radius Angle:currentAngle]-100);
        [self.labelArray addObject:label];
        [self addSubview:label];
    }
    
    // 设置刻度表的名称
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 ,100, 40)];
    label.autoresizesSubviews = YES;
    label.font = [UIFont boldSystemFontOfSize:22];
    label.textColor = [UIColor colorWithRed:68/255.0 green:145/255.0 blue:110/255.0 alpha:1];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%.f℃", gaugeValue];
    label.center = CGPointMake(centerPoint.x, centerPoint.y*3/2-170);
    [self addSubview:label];
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 ,100, 40)];
       label1.autoresizesSubviews = YES;
       label1.font = [UIFont boldSystemFontOfSize:18];
       label1.textColor = [UIColor whiteColor];
       label1.backgroundColor = [UIColor clearColor];
       label1.textAlignment = NSTextAlignmentCenter;
       label1.text = GAUGESTRING;
       label1.center = CGPointMake(centerPoint.x, centerPoint.y*3/2-140);
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
            CGContextSetStrokeColorWithColor(self.context, [[UIColor colorWithRed:58/255.0 green:134/255.0 blue:239/255.0 alpha:1] CGColor]);
        } else if(i > labelNum*1/10 && i < labelNum*1/2+2) {
            CGContextSetStrokeColorWithColor(self.context, [[UIColor colorWithRed:68/255.0 green:145/255.0 blue:110/255.0 alpha:1] CGColor]);
        } else {
            CGContextSetStrokeColorWithColor(self.context, [[UIColor colorWithRed:203/255.0 green:91/255.0 blue:82/255.0 alpha:1] CGColor]);
        }
        NSLog(@"%.2f", centerPoint.x);
        //绘制不同的长短的刻度
        if (i%10==0) {
            CGContextSetLineCap(self.context, kCGLineCapSquare);
            CGContextSetLineWidth(self.context, 2);
            CGContextStrokePath(self.context);
            CGContextMoveToPoint(self.context,
                                 centerPoint.x+[self parseToX:radius-10*scoleNum Angle:currentAngle],
                                 centerPoint.y+[self parseToY:radius-10*scoleNum Angle:currentAngle]);
            CGContextAddLineToPoint(self.context,
                                    centerPoint.x+[self parseToX:radius-30*scoleNum Angle:currentAngle],
                                    centerPoint.y+[self parseToY:radius-30*scoleNum Angle:currentAngle]);
        } else {
            CGContextSetLineWidth(self.context, 2);
            CGContextSetLineCap(self.context, kCGLineCapSquare);
            CGContextStrokePath(self.context);
            CGContextMoveToPoint(self.context,
                                 centerPoint.x+[self parseToX:radius-10*scoleNum Angle:currentAngle],
                                 centerPoint.y+[self parseToY:radius-10*scoleNum Angle:currentAngle]);
            CGContextAddLineToPoint(self.context,
                                    centerPoint.x+[self parseToX:radius-20*scoleNum Angle:currentAngle],
                                    centerPoint.y+[self parseToY:radius-20*scoleNum Angle:currentAngle]);
        }
    }
}
  
/*
 * setGaugeValue 移动到某个数值
 * @value CGFloat 移动到的数值
 * @isAnim BOOL   是否执行动画
 */
-(void)setGaugeValue:(CGFloat)value animation:(BOOL)isAnim
{
    CGFloat tempAngle = [self parseToAngle:value];
    gaugeValue = value;
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
- (void) pointToAngle:(CGFloat) angle Duration:(CGFloat) duration
{
    CAKeyframeAnimation *anim=[CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSMutableArray *values=[NSMutableArray array];
    anim.duration = duration;
    anim.autoreverses = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion= NO;
      
    CGFloat distance = angle/10;
    //设置转动路径，不能直接用 CABaseAnimation 的toValue，那样是按最短路径的，转动超过180度时无法控制方向
    int i = 1;
    for(;i<=10;i++){
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, [self transToRadian:(gaugeAngle+distance*i)], 0, 0, 1)]];
        }
    //添加缓动效果
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
-(CGFloat)transToRadian:(CGFloat)angel
{
    return angel*M_PI/180;
}
  
  
/*
 * parseToX 根据角度，半径计算X坐标
 * @radius CGFloat 半径
 * @angle  CGFloat 角度
 */
- (CGFloat) parseToX:(CGFloat) radius Angle:(CGFloat)angle
{
    CGFloat tempRadian = [self transToRadian:angle];
    return radius*cos(tempRadian);
}
  
/*
 * parseToY 根据角度，半径计算Y坐标
 * @radius CGFloat 半径
 * @angle  CGFloat 角度
 */
- (CGFloat) parseToY:(CGFloat) radius Angle:(CGFloat)angle
{
    CGFloat tempRadian = [self transToRadian:angle];
    return radius*sin(tempRadian);
}
  
/*
 * parseToAngle 根据数据计算需要转动的角度
 * @val CGFloat 要移动到的数值
 */
-(CGFloat) parseToAngle:(CGFloat) val
{
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
-(CGFloat) parseToValue:(CGFloat) val
{
    CGFloat temp=val/angleperValue;
    CGFloat temp2=maxNum/2+temp;
    if(temp2>maxNum){
        return maxNum;
    }else if(temp2<maxNum){
        return maxNum;
    }
    return temp2;
}


- (void)drawLayer {
    
}

- (CALayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer =  [self buildShapeLayerColor:[UIColor blueColor] lineWidth:3];
    }
    return _progressLayer;
}

- (CAShapeLayer *)buildShapeLayerColor:(UIColor *)color lineWidth:(CGFloat)width  {
    CAShapeLayer *layer = [CAShapeLayer layer];
    CGRect rect = {3 * 0.5, 60, self.frame.size.width - 13, self.frame.size.height - 53};
    // 设置path
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    layer.path = path.CGPath;
    // 设置layer
    layer.strokeColor = color.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = width;
    layer.lineCap = kCALineCapRound;
    return layer;
}
  
- (void)drawRect:(CGRect)rect
{
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

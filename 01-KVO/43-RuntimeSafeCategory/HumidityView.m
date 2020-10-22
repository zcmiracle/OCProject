//
//  HumidityView.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/10/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "HumidityView.h"
#import "UICountingLabel.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+FLTextSize.h"
#import "UIView+FLFrame.h"

#define MAXOFFSETANGLE 130.0f
#define POINTEROFFSET  90.0f
#define MAXVALUE       100.0f
#define CELLMARKNUM    10
#define CELLNUM        10
#define DEFLUATSIZE    200

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 2.获取RGB颜色 + 透明度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 3.获取RGB颜色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface HumidityView ()
{
    // 最大值
    CGFloat maxNum;
    // 最小值
    CGFloat minNum;
    // 最大角度
    CGFloat maxAngle;
    // 最小角度
    CGFloat minAngle;
    CGFloat gaugeValue;
    CGFloat gaugeAngle;
    CGFloat angleperValue;
    CGFloat scoleNum;
}

/// 导轨背景色
@property (nonatomic, strong) UIColor *trackColor;
/// 线条宽度
@property (nonatomic, assign) CGFloat lineWidth;
/// 进度条颜色
@property (nonatomic, strong) UIColor *progressColor;
/// 进度条类型
@property (nonatomic, copy) CAShapeLayerLineCap progressLineCap;
/// 进度
@property (nonatomic, assign) CGFloat progress;
/// 半径
@property (nonatomic, assign) CGFloat cornerRadius;

/// 导轨layer
@property (nonatomic, strong) CAShapeLayer *circleBackgroundLayer;
/// 外环进度条layer
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer1;
@property (nonatomic, strong) CAShapeLayer *progressLayer2;
@property (nonatomic, strong) CAShapeLayer *progressLayer3;

// 26℃ label
@property (nonatomic, strong) UICountingLabel *leftCenterLabel;
// 摄氏度℃
@property (nonatomic, strong) UILabel *rightCenterLabel;
// 温度 label
@property (nonatomic, strong) UILabel *bottomLabel;


// -40 -26 -12 2 16 30 44 58 72 86 100
@property (nonatomic, strong) NSMutableArray *labelArray;
// 上下文
@property (nonatomic) CGContextRef context;
/** 进度条layer */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end
  
@implementation HumidityView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 默认200
        scoleNum = DEFLUATSIZE/frame.size.width;
        // 最大值
        maxNum = MAXVALUE;
        // 最小值
        minNum = 0;
        minAngle = -MAXOFFSETANGLE;
        maxAngle = MAXOFFSETANGLE;
        gaugeValue = 0.0f;
        gaugeAngle = -MAXOFFSETANGLE;
        // 角度
        angleperValue = (maxAngle - minAngle)/(maxNum - minNum);
        
        _trackColor = [UIColor colorWithWhite:1 alpha:0.0];
        // 进度条layer宽度
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


            
    
    
    //从 π/2 开始绘制一个进度
    CGPoint center = CGPointMake(self.fl_width * 0.5, self.fl_height * 0.5);
    // 创建弧线路径 startAngle 开始角度  endAngle结束角度
    UIBezierPath *progressPath =  [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 180 * 142 endAngle: M_PI / 180 * 217 clockwise:YES];
    UIBezierPath *progressPath1 = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 180 * 220 endAngle: M_PI / 180 * 346 clockwise:YES];
    UIBezierPath *progressPath2 = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 180 * 350 endAngle: M_PI / 180 * 398 clockwise:YES];
    
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

/// 绘制刻度值
/// @param labelNum 刻度值的数目
- (void)setTextLabel:(NSInteger)labelNum {
    
    self.labelArray = [NSMutableArray arrayWithCapacity:labelNum];
    CGFloat labelX = 50;
    if (self.fl_width == 150) {
        labelX = 43;
    } else if (self.fl_width == 180) {
        labelX = 40;
    } else if (self.fl_width == 190) {
         labelX = 40;
    }

//    if (ScreenWidth == 320) {
//        labelX = 45;
//    } else if (ScreenWidth == 375) {
//        labelX = 40;
//    } else if (ScreenWidth == 414) {
//        labelX = 40;
//    }
    
    CGFloat textDis = (maxNum - minNum)/labelNum;
    CGFloat angelDis = (maxAngle - minAngle)/labelNum;
    CGFloat radius = (self.center.x - labelX)*scoleNum;
    CGFloat currentAngle;
    CGFloat currentText = 0.0f;
    CGPoint centerPoint = self.center;
    
    for(int i = 0; i <= labelNum; i ++) {
        currentAngle = minAngle + i * angelDis - POINTEROFFSET;
        currentText = minNum + i * textDis;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        label.autoresizesSubviews = YES;
        label.font = [UIFont systemFontOfSize:12];
        label.backgroundColor = [UIColor clearColor];
        // 设置刻度的文字的格式
        if(i < labelNum/2){
            label.textAlignment = NSTextAlignmentCenter;
        } else if (i==labelNum/2){
            label.textAlignment = NSTextAlignmentCenter;
        } else {
            label.textAlignment = NSTextAlignmentCenter;
        }
        
        if (i == 0 || i == 1 || i == 2 || i == 3) {
            label.textColor = RGB(203, 91, 82);
        } else if (i == 4 || i == 5 || i == 6 || i == 7 || i == 8) {
            label.textColor = RGB(68, 145, 110);
        } else {
            label.textColor = RGB(58, 134, 239);
        }
        
        label.text = [NSString stringWithFormat:@"%d",(int)currentText];
        label.center = CGPointMake(centerPoint.x+[self parseToX:radius Angle:currentAngle],
                                   centerPoint.y+[self parseToY:radius Angle:currentAngle]);
        [self.labelArray addObject:label];
        [self addSubview:label];
    }
    
    [self addSubview:self.leftCenterLabel]; // 15
    [self addSubview:self.rightCenterLabel];// ℃
    [self addSubview:self.bottomLabel];     // 温度
}

///  绘制刻度的标记
/// @param labelNum 刻度是数目
- (void)setLineMark:(NSInteger)labelNum {
  
    CGFloat angelDis = (maxAngle - minAngle)/labelNum;
    CGFloat radius = self.center.x;
    CGFloat currentAngle;
    CGPoint centerPoint = CGPointMake(self.fl_width/2, self.fl_height/2);
      
    for(int i = 0; i <= labelNum; i++) {
        currentAngle = minAngle + i * angelDis - POINTEROFFSET;
        // 给刻度标记绘制不同的颜色
        if (i <= labelNum*3/10 + 1) {
            CGContextSetStrokeColorWithColor(self.context, RGB(203, 91, 82).CGColor);
        } else if (i > labelNum*3/10 + 1 && i < labelNum*4/5 + 2) {
            CGContextSetStrokeColorWithColor(self.context, RGB(68, 145, 110).CGColor);
        } else {
            CGContextSetStrokeColorWithColor(self.context, RGB(58, 134, 239).CGColor);
        }
        
        CGFloat number1 = 1;
        CGFloat number2 = 15;
        CGFloat number3 = 1;
        CGFloat number4 = 8;
//        NSLog(@"%.2f", self.fl_width);
        if (self.fl_width == 150) {
            number1 = 1;
            number2 = 15;
            number3 = 1;
            number4 = 8;
        } else if (self.fl_width == 180) {
            number1 = 1;
            number2 = 20;
            number3 = 1;
            number4 = 10;
        } else if (self.fl_width == 190) {
            number1 = 1;
            number2 = 20;
            number3 = 1;
            number4 = 10;
        }
        //绘制不同的长短的刻度
        if (i%10 == 0) {
            CGContextSetLineCap(self.context, kCGLineCapSquare);
            CGContextSetLineWidth(self.context, 1.5);
            CGContextStrokePath(self.context);
            CGContextMoveToPoint(self.context,
                                 centerPoint.x+[self parseToX:radius-number1*scoleNum Angle:currentAngle],
                                 centerPoint.y+[self parseToY:radius-number1*scoleNum Angle:currentAngle]);
            // SE适配 20
            CGContextAddLineToPoint(self.context,
                                    centerPoint.x+[self parseToX:radius-number2*scoleNum Angle:currentAngle],
                                    centerPoint.y+[self parseToY:radius-number2*scoleNum Angle:currentAngle]);
        } else {
            CGContextSetLineWidth(self.context, 1.5);
            CGContextSetLineCap(self.context, kCGLineCapSquare);
            CGContextStrokePath(self.context);
            CGContextMoveToPoint(self.context,
                                 centerPoint.x+[self parseToX:radius-number3*scoleNum Angle:currentAngle],
                                 centerPoint.y+[self parseToY:radius-number3*scoleNum Angle:currentAngle]);
            CGContextAddLineToPoint(self.context,
                                    centerPoint.x+[self parseToX:radius-number4*scoleNum Angle:currentAngle],
                                    centerPoint.y+[self parseToY:radius-number4*scoleNum Angle:currentAngle]);
        }
      
    }
}
  
/// 移动到某个数值
/// @param value 移动到的数值
/// @param isAnimation 是否执行动画
- (void)setHumidityValue:(CGFloat)value animation:(BOOL)isAnimation {
    CGFloat tempAngle = [self parseToAngle:value];
    gaugeValue = value;

       if (gaugeValue >= 0 && gaugeValue <= 30) {
        self.leftCenterLabel.textColor = RGB(203, 91, 82);
        self.rightCenterLabel.textColor = RGB(203, 91, 82);
        self.pointer2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red_zhizhen"]];

    } else if (gaugeValue > 30 && gaugeValue <= 80) {
        self.leftCenterLabel.textColor = RGB(68, 145, 110);
        self.rightCenterLabel.textColor = RGB(68, 145, 110);
        self.pointer2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green_zhizhen"]];
    } else {
        self.leftCenterLabel.textColor = RGB(58, 134, 239);
        self.rightCenterLabel.textColor = RGB(58, 134, 239);
        self.pointer2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue_zhizhen"]];

    }
    [self.leftCenterLabel countFrom:0 to:gaugeValue];

    self.pointer2.layer.anchorPoint = CGPointMake(0.5, 0.93);
    self.pointer2.center = CGPointMake(self.fl_width/2, self.fl_height/2);
    self.pointer2.transform = CGAffineTransformMakeScale(scoleNum, scoleNum);
    [self addSubview:self.pointer2];
    
    // 设置指针到0位置
    self.pointer2.layer.transform = CATransform3DMakeRotation([self transToRadian:-MAXOFFSETANGLE], 0, 0, 1);
    
    // 重新设置刻度
    // 设置转动时间和转动动画
    if (isAnimation){
        [self pointToAngle:tempAngle Duration:1.0f];
    } else {
        [self pointToAngle:tempAngle Duration:0.0f];
    }
}
  
/// 按角度旋转
/// @param angle 角度
/// @param duration 动画执行时间
- (void)pointToAngle:(CGFloat)angle Duration:(CGFloat)duration {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSMutableArray *values = [NSMutableArray array];
    anim.duration = duration;
    anim.autoreverses = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
      
    CGFloat distance = angle/10;
    //设置转动路径，不能直接用 CABaseAnimation 的toValue，那样是按最短路径的，转动超过180度时无法控制方向
    int i = 1;
    for(; i <= 10; i ++) {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, [self transToRadian:(gaugeAngle+distance*i)], 0, 0, 1)]];
        }
    anim.values = values;
    [self.pointer2.layer addAnimation:anim forKey:@"cubeIn"];
    gaugeAngle = gaugeAngle + angle;
      
}
  
/// 角度转弧度
/// @param angel 角度
- (CGFloat)transToRadian:(CGFloat)angel {
    return angel*M_PI/180;
}

/// 根据角度，半径计算X坐标
/// @param radius 半径
/// @param angle 角度
- (CGFloat)parseToX:(CGFloat)radius Angle:(CGFloat)angle {
    CGFloat tempRadian = [self transToRadian:angle];
    return radius*cos(tempRadian);
}
  
/// 根据角度，半径计算Y坐标
/// @param radius 半径
/// @param angle 角度
- (CGFloat)parseToY:(CGFloat)radius Angle:(CGFloat)angle {
    CGFloat tempRadian = [self transToRadian:angle];
    return radius * sin(tempRadian);
}

/// 根据数据计算需要转动的角度
/// @param val 要移动到的数值
- (CGFloat)parseToAngle:(CGFloat)val {
    //异常的数据
    if(val < minNum) {
        return minNum;
    } else if (val > maxNum){
        return maxNum;
    }
    CGFloat temp = (val-gaugeValue) * angleperValue;
    
    
    NSLog(@"temp ------------------- %.2f", temp);
    return temp;
}

/// 根据角度计算数值
/// @param val 要移动到的角度
- (CGFloat)parseToValue:(CGFloat)val {
    CGFloat temp = val / angleperValue;
    CGFloat temp2 = maxNum / 2 + temp;
    if (temp2 > maxNum) {
        return maxNum;
    } else if (temp2 < maxNum) {
        return maxNum;
    }
    return temp2;
}

- (void)drawRect:(CGRect)rect {
    // 获取上下文
    self.context = UIGraphicsGetCurrentContext();
    // 设置背景透明
    CGContextSetFillColorWithColor(self.context,self.backgroundColor.CGColor);
    CGContextFillRect(self.context, rect);
    // 绘制刻度
    [self setLineMark:CELLNUM*CELLMARKNUM];
    [self setTextLabel:CELLNUM];
    CGContextStrokePath(self.context);
}

#pragma mark --- Lazy Loading
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

// 蓝色进度条
- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.lineWidth = self.lineWidth;
        _progressLayer.strokeColor = RGB(203, 91, 82).CGColor;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineCap = self.progressLineCap;
    }
    return _progressLayer;
}

// 绿色进度条
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

// 红色进度条
- (CAShapeLayer *)progressLayer2 {
    if (!_progressLayer2) {
        _progressLayer2 = [CAShapeLayer layer];
        _progressLayer2.lineWidth = self.lineWidth;
        _progressLayer2.strokeColor = RGB(58, 134, 239).CGColor;
        _progressLayer2.fillColor = [UIColor clearColor].CGColor;
        _progressLayer2.lineCap = self.progressLineCap;
    }
    return _progressLayer2;
}

- (UICountingLabel *)leftCenterLabel {
    if (!_leftCenterLabel) {
        _leftCenterLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, self.fl_height-55, self.fl_width/2, 40)];
        _leftCenterLabel.autoresizesSubviews = YES;
        _leftCenterLabel.format = @"%d";
        _leftCenterLabel.font = [UIFont boldSystemFontOfSize:22];
        _leftCenterLabel.textColor = RGB(203, 91, 82);
        _leftCenterLabel.backgroundColor = [UIColor clearColor];
        _leftCenterLabel.textAlignment = NSTextAlignmentRight;
        _leftCenterLabel.text = @"0";
    }
    return _leftCenterLabel;
}

- (UILabel *)rightCenterLabel {
    if (!_rightCenterLabel) {
        _rightCenterLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.fl_width/2, self.fl_height-55, self.fl_width/2, 40)];
        _rightCenterLabel.autoresizesSubviews = YES;
        _rightCenterLabel.font = [UIFont boldSystemFontOfSize:22];
        _rightCenterLabel.textColor = RGB(203, 91, 82);
        _rightCenterLabel.backgroundColor = [UIColor clearColor];
        _rightCenterLabel.textAlignment = NSTextAlignmentLeft;
        _rightCenterLabel.text = @"%";
    }
    return _rightCenterLabel;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.fl_height-20, self.fl_width, 20)];
        _bottomLabel.autoresizesSubviews = YES;
        _bottomLabel.font = [UIFont boldSystemFontOfSize:18];
        _bottomLabel.textColor = [UIColor whiteColor];
        _bottomLabel.backgroundColor = [UIColor clearColor];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.text = @"湿度";
    }
    return _bottomLabel;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end

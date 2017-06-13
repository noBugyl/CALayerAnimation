//
//  ViewController.m
//  CAMeidaTimeOffset
//
//  Created by yyyy on 2017/6/13.
//  Copyright © 2017年 yl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISlider *timeOffsetSlider;
@property (weak, nonatomic) IBOutlet UILabel *speedeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeOffsetLabel;
@property (nonatomic,strong) UIBezierPath *bezierPath;
@property (nonatomic,strong) CALayer *shipLayer;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bezierPath = [[UIBezierPath alloc] init];
    [self.bezierPath moveToPoint:CGPointMake(30, 150)];
    [self.bezierPath addCurveToPoint:CGPointMake(330, 150) controlPoint1:CGPointMake(105, 0) controlPoint2:CGPointMake(255, 300)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.path = self.bezierPath.CGPath;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    
    self.shipLayer = [CALayer layer];
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"login_logo"].CGImage;
    self.shipLayer.frame = CGRectMake(0, 0, 64, 64);
    self.shipLayer.position = CGPointMake(30, 150);
    [self.containerView.layer addSublayer:self.shipLayer];
    [self updateSliders:nil];
    
    
}
- (IBAction)updateSliders:(id)sender {
    CFTimeInterval timeOffset = self.timeOffsetSlider.value;
    self.timeOffsetLabel.text = [NSString stringWithFormat:@"%0.2f",timeOffset];
    float speed = self.speedSlider.value;
    self.speedeLabel.text = [NSString stringWithFormat:@"%0.2f",speed];
}

- (IBAction)play:(id)sender {
//    [self.shipLayer removeAllAnimations];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.speed = self.speedSlider.value;
    animation.timeOffset = self.timeOffsetSlider.value;
    animation.duration = 1.0f;
    animation.repeatCount = INFINITY;
    animation.path = self.bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.removedOnCompletion = NO;
    [self.shipLayer addAnimation:animation forKey:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

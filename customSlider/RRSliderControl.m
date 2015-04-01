//
//  RRSliderControl.m
//  customSlider
//
//  Created by Rafi Rizwan on 3/21/15.
//  Copyright (c) 2015 Rafi Rizwan. All rights reserved.
//

#import "RRSliderControl.h"
#import <QuartzCore/QuartzCore.h>
#import "RRSliderKnob.h"


@implementation RRSliderControl
{
    CALayer* _trackLayer;
    RRSliderKnob* _controlKnobLayer;
    
    float _knobWidth;
    float _useableTrackLength;
    
    CGPoint _previousTouchPoint;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setFrame:frame];
    _trackLayer = [CALayer layer];
    _trackLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:_trackLayer];
    
    _controlKnobLayer = [RRSliderKnob layer];
    _controlKnobLayer.slider = self;
    _controlKnobLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:_controlKnobLayer];
    
    [self setLayerFrames];
    _maximumValue = 10;
    _minimumValue = 0;
    _knobValue = 0;
    
    return self;
}

- (void) setLayerFrames
{
    _maximumValue = 10;
    

    
    _knobWidth = self.bounds.size.height;
    _useableTrackLength = self.bounds.size.width - _knobWidth;
    
    float controlKnobCenter = [self positionForValue:_knobValue];
    _controlKnobLayer.frame = CGRectMake(controlKnobCenter - _knobWidth / 2, 0, _knobWidth, _knobWidth);
    _trackLayer.frame = CGRectMake(0, 0, controlKnobCenter, 11);
    //_trackLayer.frame = CGRectInset(self.bounds, controlKnobCenter, self.bounds.size.height / 3.5);
    
    [_trackLayer setNeedsDisplay];
    
    [_controlKnobLayer setNeedsDisplay];
}

- (float) positionForValue:(float)value
{
    
    float position = (_useableTrackLength * (_knobValue/_maximumValue));
    
    float response = _useableTrackLength * ((value - _minimumValue) /
    ((_maximumValue - _minimumValue) + (_knobWidth / 2)));
    NSLog(@"%f", position);
    return position;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"started tracking");
    _previousTouchPoint = [touch locationInView:self];
    
    // hit test the knob layers
    if(CGRectContainsPoint(_controlKnobLayer.frame, _previousTouchPoint))
    {
        _controlKnobLayer.highlighted = YES;
        [_controlKnobLayer setNeedsDisplay];
    }
    return _controlKnobLayer.highlighted;
}

#define BOUND(VALUE, UPPER, LOWER)	MIN(MAX(VALUE, LOWER), UPPER)

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    
    NSLog(@"continued tracking!");
    
    // 1. determine by how much the user has dragged
    float delta = touchPoint.x - _previousTouchPoint.x;
    NSLog(@"%f",delta);
    float valueDelta = (_maximumValue - _minimumValue) * delta / _useableTrackLength;
    NSLog(@"%f",valueDelta);
    _previousTouchPoint = touchPoint;
    
    // 2. update the values
    if (_controlKnobLayer.highlighted)
    {
        _knobValue += valueDelta;
        //_knobValue = BOUND(_knobValue, _maximumValue, _minimumValue);
        NSLog(@"KNOB VALUE SHOULD BE: %f",_knobValue);
    }
    // 3. Update the UI state
    [CATransaction begin];
    [CATransaction setDisableActions:YES] ;
    
    [self setLayerFrames];
    
    [CATransaction commit];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    _controlKnobLayer.highlighted = NO;
    [_controlKnobLayer setNeedsDisplay];
}

- (void)autoChangeValueTo:(float)value{
    _knobValue = value;
    [self setLayerFrames];
}

@end

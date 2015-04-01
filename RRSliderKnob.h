//
//  RRSliderKnob.h
//  customSlider
//
//  Created by Rafi Rizwan on 3/21/15.
//  Copyright (c) 2015 Rafi Rizwan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class RRSliderControl;

@interface RRSliderKnob : CALayer

@property BOOL highlighted;
@property (weak) RRSliderControl* slider;

@end

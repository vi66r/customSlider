//
//  RRSliderControl.h
//  customSlider
//
//  Created by Rafi Rizwan on 3/21/15.
//  Copyright (c) 2015 Rafi Rizwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRSliderControl : UIControl
@property (nonatomic) float maximumValue;
@property (nonatomic) float minimumValue;
@property (nonatomic) float knobValue;
- (instancetype)initWithFrame:(CGRect)frame;

- (void)autoChangeValueTo:(float)value;

@end

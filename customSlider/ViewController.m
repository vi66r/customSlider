//
//  ViewController.m
//  customSlider
//
//  Created by Rafi Rizwan on 3/21/15.
//  Copyright (c) 2015 Rafi Rizwan. All rights reserved.
//

#import "ViewController.h"
#import "RRSliderControl.h"

@interface ViewController ()

@end

@implementation ViewController{
    RRSliderControl* _rangeSlider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUInteger margin = 20;
    CGRect sliderFrame = CGRectMake(margin, margin, self.view.frame.size.width - margin * 2, 30);
    _rangeSlider = [[RRSliderControl alloc] initWithFrame:sliderFrame];
    _rangeSlider.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_rangeSlider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

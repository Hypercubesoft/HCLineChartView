//
//  LineChart.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCLineChartView.h"
#import <QuartzCore/QuartzCore.h>
#import "HCChartDrawer.h"

@implementation HCLineChartView

#pragma mark Initialization

/// Override standard constructor
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return NULL;
    }
    
    [self setDefaultValues];
    
    return self;
}

/// Override standard constructor
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self)
    {
        return NULL;
    }
    
    [self setDefaultValues];
    
    return self;
}

/// This method sets default settings for chart drawing if user don't setup them
-(void)setDefaultValues
{
    self.chartTitle = @"";
    self.chartSubTitle = @"";
    self.backgroundGradientTopColor = [UIColor whiteColor];
    self.backgroundGradientBottomColor = [UIColor whiteColor];
    self.underLineChartGradientTopColor = [UIColor whiteColor];
    self.underLineChartGradientBottomColor = [UIColor whiteColor];
    self.chartTitleColor = [UIColor blackColor];
    self.chartSubtitleColor = [UIColor blackColor];
    self.chartAxisColor = [UIColor blackColor];
    self.chartLineWidth = 2.0;
    self.fontSizeForTitle = 18.0;
    self.fontSizeForSubTitle = 12.0;
    self.fontSizeForAxis = 9.0;
    self.chartLineColor = [UIColor blackColor];
}

/// This is a method which is called automatically when view is presented, or when phone changes orientation, or, for example, when user calls function setNeedsDisplay
- (void)drawRect:(CGRect)rect {
    hcChartDrawer = [HCChartDrawer new];
    [self setContentMode:UIViewContentModeRedraw];

#if TARGET_INTERFACE_BUILDER
    [self generateRandomDataForInterfaceBuilder];
#endif
    
    [hcChartDrawer drawChart:self inRect:rect];
    
}

/// This method generates random data for interface builder presentation
-(void)generateRandomDataForInterfaceBuilder
{
    self.xElements = [NSMutableArray new];
    self.yElements = [NSMutableArray new];
    int averageXValue = arc4random_uniform(10000);
    int lastXValue = arc4random_uniform(averageXValue * 2) - averageXValue;
    int averageYValue = arc4random_uniform(10000);
    int lastYValue = arc4random_uniform(averageYValue * 2) - averageYValue;
    
    for (int i = 0 ; i < (self.chartLineWithCircles ? 20 : 100); i++)
    {
        [self.xElements addObject:@(lastXValue)];
        lastXValue += 1 + arc4random_uniform(10);
        [self.yElements addObject:@(lastYValue)];
        lastYValue += arc4random_uniform(21) - 10;
    }
}


-(void)drawChart
{
    [self setNeedsDisplay];
}

-(void)updateChartWithXElements:(NSArray*)xElements yElements:(NSArray*)yElements
{
    self.xElements = [xElements mutableCopy];
    self.yElements = [yElements mutableCopy];
    [self drawChart];
}
@end

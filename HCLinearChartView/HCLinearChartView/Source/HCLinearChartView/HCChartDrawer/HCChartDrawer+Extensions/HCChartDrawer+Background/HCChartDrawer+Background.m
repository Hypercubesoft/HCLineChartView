//
//  HCChartDrawer+Background.m
//  HCLinearChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer+Background.h"

@implementation HCChartDrawer (Background)

#pragma mark Draw background methods

-(void)drawBackground
{
    [hcLinearChartView setBackgroundColor:[UIColor clearColor]];
    if (!hcLinearChartView.chartTransparentBackground)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextClearRect(context, chartRect);
        CGContextSetFillColorWithColor(context, hcLinearChartView.backgroundGradientTopColor.CGColor);
        NSArray *colors = @[(__bridge id) hcLinearChartView.backgroundGradientTopColor.CGColor, (__bridge id) (hcLinearChartView.chartGradient ? hcLinearChartView.backgroundGradientBottomColor.CGColor : hcLinearChartView.backgroundGradientTopColor.CGColor)];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGFloat locations[] = { 0.0, 1.0 };
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
        CGPoint startPoint = CGPointMake(CGRectGetMidX(chartRect), CGRectGetMinY(chartRect));
        CGPoint endPoint = CGPointMake(CGRectGetMidX(chartRect), CGRectGetMaxY(chartRect));
        UIBezierPath* backgroundRoundedRectPath = [UIBezierPath bezierPathWithRoundedRect:chartRect cornerRadius:chartCornerRadius];
        [backgroundRoundedRectPath fill];
        [backgroundRoundedRectPath addClip];
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
        CGContextRestoreGState(context);
        [hcLinearChartView setOpaque:NO];
        [hcLinearChartView.layer setOpaque:NO];
        [hcLinearChartView.layer setCornerRadius:chartCornerRadius];
        [hcLinearChartView setClipsToBounds:YES];
        [hcLinearChartView.layer setMasksToBounds:YES];
    }
}



@end

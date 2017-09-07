//
//  HCChartDrawer+Background.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer+Background.h"

@implementation HCChartDrawer (Background)

#pragma mark Draw background methods

-(void)drawBackground
{
    [hcLineChartView setBackgroundColor:[UIColor clearColor]];
    if (!hcLineChartView.chartTransparentBackground)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextClearRect(context, chartRect);
        CGContextSetFillColorWithColor(context, hcLineChartView.backgroundGradientTopColor.CGColor);
        NSArray *colors = @[(__bridge id) hcLineChartView.backgroundGradientTopColor.CGColor, (__bridge id) (hcLineChartView.chartGradient ? hcLineChartView.backgroundGradientBottomColor.CGColor : hcLineChartView.backgroundGradientTopColor.CGColor)];
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
        [hcLineChartView setOpaque:NO];
        [hcLineChartView.layer setOpaque:NO];
        [hcLineChartView.layer setCornerRadius:chartCornerRadius];
        [hcLineChartView setClipsToBounds:YES];
        [hcLineChartView.layer setMasksToBounds:YES];
    }
}



@end

//
//  HCChartDrawer+TitleAndSubtitle.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer+TitleAndSubtitle.h"
#import "HCChartDrawer+Text.h"
#import "HCChartDrawer+General.h"

@implementation HCChartDrawer (TitleAndSubtitle)

-(void)drawTitleAndSubtitle
{
    [self drawTitleText];
    if (hcLineChartView.showSubtitle)
    {
        [self drawSubTitleText];
    }
}

#pragma mark Draw title

/// This method draws chart title
-(void)drawTitleText
{
    UIFont* titleFont;
    if (@available(iOS 8.2, *))
    {
        titleFont = [UIFont systemFontOfSize:hcLineChartView.fontSizeForTitle weight:2.0];
    }
    else
    {
        titleFont = [UIFont boldSystemFontOfSize:hcLineChartView.fontSizeForTitle];
    }
    NSDictionary* attributes = [self fontAttributesWithFont:titleFont fontColor:hcLineChartView.chartTitleColor textAlignment:NSTextAlignmentCenter andLineBreakMode:NSLineBreakByTruncatingTail];
    [self drawText:hcLineChartView.chartTitle withRect:[self chartTitleRect] withAtributes:attributes withOffset:CGPointMake(0.0, 0.0) isVertical:NO];
}

/// This property defines rect for chart title
/// @return Chart title rect
-(CGRect)chartTitleRect
{
    CGSize textSize = [self sizeOfText:hcLineChartView.chartTitle withFontSize:hcLineChartView.fontSizeForTitle];
    CGRect textRect = chartRect;
    textRect.size.height = textSize.height;
    textRect.origin.x = chartCornerRadius * sqrt(2.0) * 0.5;
    textRect.size.width -= chartCornerRadius * sqrt(2.0);
    return textRect;
}

#pragma mark Draw subtitle

/// This method draws chart subtitle
-(void)drawSubTitleText
{
    UIFont* subtitleFont;
    if (@available(iOS 8.2, *))
    {
        subtitleFont = [UIFont systemFontOfSize:hcLineChartView.fontSizeForSubTitle weight:1.0];
    }
    else
    {
        subtitleFont = [UIFont systemFontOfSize:hcLineChartView.fontSizeForSubTitle];
    }
    NSDictionary* attributes = [self fontAttributesWithFont:subtitleFont fontColor:hcLineChartView.chartSubtitleColor textAlignment:NSTextAlignmentCenter andLineBreakMode:NSLineBreakByTruncatingTail];
    [self drawText:hcLineChartView.chartSubTitle withRect:[self chartSubtitleRect] withAtributes:attributes withOffset:CGPointMake(0.0, hcLineChartView.fontSizeForTitle + 4.0) isVertical:NO];
}

/// This property defines rect for chart subtitle
/// @return Chart subtitle rect
-(CGRect)chartSubtitleRect
{
    CGSize textSize = [self sizeOfText:hcLineChartView.chartSubTitle withFontSize:hcLineChartView.fontSizeForSubTitle];
    CGRect textRect = chartRect;
    textRect.origin.x = chartCornerRadius * sqrt(2.0) * 0.5;
    textRect.size.width -= chartCornerRadius * sqrt(2.0);
    textRect.size.height = textSize.height;
    return textRect;
}

@end

//
//  HCChartDrawer+TitleAndSubtitle.m
//  HCLinearChartView
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
    if (hcLinearChartView.showSubtitle)
    {
        [self drawSubTitleText];
    }
}

#pragma mark Draw title

/// This method draws chart title
-(void)drawTitleText
{
    NSDictionary* attributes = [self fontAttributesWithFont:[UIFont systemFontOfSize:hcLinearChartView.fontSizeForTitle weight:2.0] fontColor:hcLinearChartView.chartTitleColor textAlignment:NSTextAlignmentCenter andLineBreakMode:NSLineBreakByTruncatingTail];
    [self drawText:hcLinearChartView.chartTitle withRect:[self chartTitleRect] withAtributes:attributes withOffset:CGPointMake(0.0, 0.0) isVertical:NO];
}

/// This property defines rect for chart title
/// @return Chart title rect
-(CGRect)chartTitleRect
{
    CGSize textSize = [self sizeOfText:hcLinearChartView.chartTitle withFontSize:hcLinearChartView.fontSizeForTitle];
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
    NSDictionary* attributes = [self fontAttributesWithFont:[UIFont systemFontOfSize:hcLinearChartView.fontSizeForSubTitle weight:1.0] fontColor:hcLinearChartView.chartSubtitleColor textAlignment:NSTextAlignmentCenter andLineBreakMode:NSLineBreakByTruncatingTail];
    [self drawText:hcLinearChartView.chartSubTitle withRect:[self chartSubtitleRect] withAtributes:attributes withOffset:CGPointMake(0.0, hcLinearChartView.fontSizeForTitle + 4.0) isVertical:NO];
}

/// This property defines rect for chart subtitle
/// @return Chart subtitle rect
-(CGRect)chartSubtitleRect
{
    CGSize textSize = [self sizeOfText:hcLinearChartView.chartSubTitle withFontSize:hcLinearChartView.fontSizeForSubTitle];
    CGRect textRect = chartRect;
    textRect.origin.x = chartCornerRadius * sqrt(2.0) * 0.5;
    textRect.size.width -= chartCornerRadius * sqrt(2.0);
    textRect.size.height = textSize.height;
    return textRect;
}

@end

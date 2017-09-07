//
//  HCChartDrawer.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer.h"
#import "HCLineChartView.h"
#import "HCChartDrawer+Background.h"
#import "HCChartDrawer+TitleAndSubtitle.h"
#import "HCChartDrawer+Text.h"
#import "HCChartDrawer+CalculationAndPreparation.h"
#import "HCChartDrawer+Axis.h"
#import "HCChartDrawer+General.h"
#import "HCChartDrawer+ChartLine.h"
#import "HCTimeStep.h"


@implementation HCChartDrawer

#pragma mark Draw chart

-(void)drawChart:(HCLineChartView*)linearChartView inRect:(CGRect)rect
{
    hcLineChartView = linearChartView;
    chartRect = rect;
    [self drawLineChart];
    chartStyle = chartLineWithCircles;
}


/// This method calls all main functions for drawing the chart
-(void)drawLineChart
{
    [self prepareChartForDrawing];
    [self drawBackground];
    [self drawTitleAndSubtitle];
    if (chartType != chartWithInvalidValues)
    {
        [self drawHorizontalLinesForYTicks];
        [self drawChartLine];
        [self drawBothAxises];
    }
    else
    {
        [self handleInvalidValues];
    }
}

#pragma mark Handle invalid values

/// This method handles error if chart values are invalid
-(void)handleInvalidValues
{
    NSString* chartWithInvalidValuesString = @"Invalid values";
    CGSize textSize = [self sizeOfText:chartWithInvalidValuesString withFontSize:hcLineChartView.fontSizeForTitle];
    CGRect textRext = CGRectMake((chartRect.size.width - textSize.width) * 0.5, (chartRect.size.height - textSize.height) * 0.5, textSize.width, textSize.height);
    NSMutableParagraphStyle *myStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    myStyle.lineBreakMode = NSLineBreakByWordWrapping;
    myStyle.alignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont systemFontOfSize:hcLineChartView.fontSizeForTitle];
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: myStyle ,
                                  NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self drawText:chartWithInvalidValuesString withRect:textRext withAtributes:attributes withOffset:CGPointZero isVertical:NO];
}

@end

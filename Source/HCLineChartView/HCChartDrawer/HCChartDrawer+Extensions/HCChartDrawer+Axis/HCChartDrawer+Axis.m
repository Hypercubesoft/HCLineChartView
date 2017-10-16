//
//  HCChartDrawer+Axis.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer+Axis.h"
#import "HCChartDrawer+CalculationAndPreparation.h"
#import "HCChartDrawer+Text.h"
#import "HCChartDrawer+General.h"
#import "HCTimeStep.h"

@implementation HCChartDrawer (Axis)

#pragma mark Draw both axes

-(void)drawBothAxises
{
    [self drawHorizontalAxis];
    [self drawVerticalAxis];
}

#pragma mark Draw horizontal axis

/// This method draws horizontal axis, i.e. X values on X axis
-(void)drawHorizontalAxis
{
    [self drawLineFromPoint:[self bottomLeftPoint] toPoint: CGPointMake([self bottomRightPoint].x + (hcLineChartView.isValueChartWithRealXAxisDistribution ? offsetForAxisOrHeader * 0.5 : 0.0), [self bottomRightPoint].y) withColor:hcLineChartView.chartAxisColor andWidth:axisWidth];
    if (numberOfElements > 1)
    {
        [self drawValuesAndTicksOnHorizontalAxis];
    }
    else
    {
        [self drawHorizontalAxisForOneOrZeroData];
    }
}

/// This method draws values and ticks on horizontal axis
-(void)drawValuesAndTicksOnHorizontalAxis
{
    double counter=0;
    CGRect textRect = CGRectZero;
    NSDate* currentDateValue;
    if (chartType == chartWithDateValues)
    {
        currentDateValue = [NSDate dateWithTimeIntervalSince1970:currentValueX];
    }
    
    do {
        if (currentPositionX >= chartRect.size.width * pointsRectLeftProportionalDistance)
        {
            NSDictionary* attributes = [self fontAttributesWithFont:[UIFont systemFontOfSize:hcLineChartView.fontSizeForAxis] fontColor:hcLineChartView.chartAxisColor textAlignment:hcLineChartView.horizontalValuesOnXAxis ? NSTextAlignmentCenter : NSTextAlignmentLeft andLineBreakMode:NSLineBreakByTruncatingTail];
            NSString* xAxisString;
            
            if (chartType == chartWithDateValues)
            {
                xAxisString = [self timeStringForValue: hcLineChartView.isValueChartWithRealXAxisDistribution ? [currentDateValue timeIntervalSince1970] : [[hcLineChartView.xElements objectAtIndex:counter * jumpOverX] timeIntervalSince1970]];
            }
            else if (chartType == chartWithNumericalValues)
            {
                double currentValue = hcLineChartView.isValueChartWithRealXAxisDistribution ? currentValueX : [[hcLineChartView.xElements objectAtIndex:counter * jumpOverX] doubleValue];
                if (((int)(currentValue * pow(10, numberOfXDecimals))) == 0)
                {
                    currentValue = 0;
                }
                xAxisString = hcLineChartView.showXValueAsCurrency ? [self currencyStringForValue:currentValue numberOfDecimalPlaces:numberOfXDecimals currencyCode:hcLineChartView.xAxisCurrencyCode] : [NSString stringWithFormat:decimalFormatX,currentValue];
            }
            textRect = CGRectMake(currentPositionX - xAxisLabelTextSize.width / 2.0, [self bottom] + standardOffset - 5.0, xAxisLabelTextSize.width, xAxisLabelTextSize.height);
            if (textRect.origin.x > chartCornerRadius && (hcLineChartView.isValueChartWithRealXAxisDistribution ? (hcLineChartView.horizontalValuesOnXAxis ? (textRect.origin.x + textRect.size.width < chartRect.size.width - chartCornerRadius) : YES) : currentPositionX < (pointsRectProportionalWidth + pointsRectLeftProportionalDistance) * chartRect.size.width))
            {
                CGSize textSize = [self sizeOfText:xAxisString withFontSize:hcLineChartView.fontSizeForAxis];
                if (textSize.width > xAxisLabelTextSize.width)
                {
                    textRect.size.width = textSize.width;
                }
                [self drawText:xAxisString withRect:textRect withAtributes:attributes withOffset:CGPointMake(0.0, 0.0) isVertical:!hcLineChartView.horizontalValuesOnXAxis];
                [self drawTickAtPosition:currentPositionX isVertical:NO];
            }
        }
        
        currentPositionX += xStep;
        if (chartType == chartWithDateValues && hcLineChartView.isValueChartWithRealXAxisDistribution)
        {
            currentDateValue = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateByAddingComponents:[xAxisDateTick dateComponent] toDate:currentDateValue options:0];
        }
        currentValueX = hcLineChartView.isValueChartWithRealXAxisDistribution ? currentValueX + xAxisTick : chartType == chartWithNumericalValues ? [[hcLineChartView.xElements objectAtIndex:counter] doubleValue] : [[hcLineChartView.xElements objectAtIndex:counter] timeIntervalSince1970];
        counter++;
    }
    while (currentPositionX < (pointsRectProportionalWidth + pointsRectLeftProportionalDistance) * chartRect.size.width && (hcLineChartView.isValueChartWithRealXAxisDistribution ? (hcLineChartView.horizontalValuesOnXAxis ? textRect.origin.x + textRect.size.width < chartRect.size.width : YES) : counter * jumpOverX < numberOfElements));
}

/// This method draws single value and tick on horizontal axis when there is no data for drawing the chart
-(void)drawHorizontalAxisForOneOrZeroData
{
    NSDictionary* attributes = [self fontAttributesWithFont:[UIFont systemFontOfSize:hcLineChartView.fontSizeForAxis] fontColor:hcLineChartView.chartAxisColor textAlignment:!hcLineChartView.horizontalValuesOnXAxis ? NSTextAlignmentLeft : NSTextAlignmentRight andLineBreakMode:NSLineBreakByTruncatingTail];
    NSString* xAxisString;
    if (chartType == chartWithNumericalValues)
    {
        xAxisString = hcLineChartView.showXValueAsCurrency ? [self currencyStringForValue:[[hcLineChartView.xElements firstObject] doubleValue] numberOfDecimalPlaces:numberOfXDecimals currencyCode:hcLineChartView.xAxisCurrencyCode] : [NSString stringWithFormat:@"%f",[[hcLineChartView.xElements firstObject] doubleValue]];
    }
    else
    {
        xAxisString = [self timeStringForValue:[(NSDate*)[hcLineChartView.xElements firstObject] timeIntervalSince1970]];
    }
    CGSize textSize = [self sizeOfText:xAxisString withFontSize:hcLineChartView.fontSizeForAxis];
    [self drawText:xAxisString withRect:CGRectMake(
                                                   chartRect.size.width * (pointsRectLeftProportionalDistance + pointsRectProportionalWidth / 2.0) - (textSize.width + textSize.height)/ 2.0,
                                                   [self bottom] + MIN(chartRect.size.height,chartRect.size.width) * axisDistanceFromPointsProportionaly + offsetForAxisOrHeader,
                                                   textSize.width,
                                                   textSize.height)
     withAtributes:attributes withOffset:CGPointMake(0.0, 0.0) isVertical:!hcLineChartView.horizontalValuesOnXAxis];
    
    [self drawTickAtPosition:chartRect.size.width * (pointsRectLeftProportionalDistance + pointsRectProportionalWidth / 2.0) - textSize.height / 2.0 isVertical:NO];
}

#pragma mark Draw vertical axis

/// This method draws vertical axis, i.e. Y values on Y axis
-(void)drawVerticalAxis
{
    [self drawLineFromPoint:[self topLeftPoint] toPoint:[self bottomLeftPoint] withColor:hcLineChartView.chartAxisColor andWidth:axisWidth];
    if (numberOfElements > 1)
    {
        [self drawValuesAndTicksOnVerticalAxis];
    }
    else
    {
        [self drawVerticalAxisForOneOrZeroData];
    }
}

-(void)drawHorizontalLinesForYTicks
{
    if (hcLineChartView.drawHorizontalLinesForYTicks && numberOfElements > 1 && yAxisTick > 0)
    {
        currentValueY = startVerticalValue;
        double i = startVertical - hcLineChartView.fontSizeForAxis / 2.0;
        do {
            if (i > [self topLeftPoint].y && currentValueY >= minYValueOnChart - yAxisTick && i + hcLineChartView.fontSizeForAxis / 2.0 < [self bottom])
            {
                if (((int)(currentValueY * pow(10, numberOfYDecimals))) == 0)
                {
                    currentValueY = 0;
                }
                [self drawDashedLineFromPoint:CGPointMake([self topLeftPoint].x, i + hcLineChartView.fontSizeForAxis / 2.0) toEndPoint:CGPointMake([self bottomRightPoint].x, i + hcLineChartView.fontSizeForAxis / 2.0)];
            }
            
            i+= yStep;
            currentValueY -= yAxisTick;
        }
        while (i < endVertical);
    }
}

/// This method draws values and ticks on vertical axis
-(void)drawValuesAndTicksOnVerticalAxis
{
    if (startVerticalValue == endVerticalValue)
    {
        NSDictionary* attributes = [self fontAttributesWithFont:[UIFont systemFontOfSize:hcLineChartView.fontSizeForAxis] fontColor:hcLineChartView.chartAxisColor textAlignment:NSTextAlignmentRight andLineBreakMode:NSLineBreakByTruncatingTail];
        NSString* decimalFormat = [NSString stringWithFormat:@"%%.%df",numberOfYDecimals];
        NSString* yAxisString = hcLineChartView.showYValueAsCurrency ? [self currencyStringForValue:currentValueY numberOfDecimalPlaces:numberOfYDecimals currencyCode:hcLineChartView.yAxisCurrencyCode] : [NSString stringWithFormat:decimalFormat,currentValueY];
        CGRect textRect = CGRectMake(
                                     chartRect.size.width * pointsRectLeftProportionalDistance - yAxisLabelTextSize.width - standardOffset,
                                     chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight * 0.5) + standardOffset - yAxisLabelTextSize.height / 2.0,
                                     yAxisLabelTextSize.width,
                                     yAxisLabelTextSize.height);
        CGSize textSize = [self sizeOfText:yAxisString withFontSize:hcLineChartView.fontSizeForAxis];
        if (textSize.width > yAxisLabelTextSize.width)
        {
            textRect.size.width = textSize.width;
        }
        [self drawText:yAxisString withRect:textRect
         withAtributes:attributes withOffset:CGPointMake(0.0, 0.0) isVertical:NO];
        
        [self drawTickAtPosition:chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight * 0.5) + standardOffset isVertical:YES];
    }
    else
    {
        currentValueY = startVerticalValue;
        double i = startVertical - hcLineChartView.fontSizeForAxis / 2.0;
        do {
            if (i > [self topLeftPoint].y && currentValueY >= minYValueOnChart - yAxisTick && i + hcLineChartView.fontSizeForAxis / 2.0 < [self bottom])
            {
                if (((int)(currentValueY * pow(10, numberOfYDecimals))) == 0)
                {
                    currentValueY = 0;
                }
                NSDictionary* attributes = [self fontAttributesWithFont:[UIFont systemFontOfSize:hcLineChartView.fontSizeForAxis] fontColor:hcLineChartView.chartAxisColor textAlignment:NSTextAlignmentRight andLineBreakMode:NSLineBreakByTruncatingTail];
                NSString* decimalFormat = [NSString stringWithFormat:@"%%.%df",numberOfYDecimals];
                NSString* yAxisString = hcLineChartView.showYValueAsCurrency ? [self currencyStringForValue:currentValueY numberOfDecimalPlaces:numberOfYDecimals currencyCode:hcLineChartView.yAxisCurrencyCode] : [NSString stringWithFormat:decimalFormat,currentValueY];
                if (i + yAxisLabelTextSize.height * 0.5 >= [self topLeftPoint].y && i <= [self bottomLeftPoint].y)
                {
                    CGRect textRect = CGRectMake(
                                                 chartRect.size.width * pointsRectLeftProportionalDistance - yAxisLabelTextSize.width - standardOffset,
                                                 i - yAxisLabelTextSize.height / 2.0,
                                                 yAxisLabelTextSize.width,
                                                 yAxisLabelTextSize.height);
                    CGSize textSize = [self sizeOfText:yAxisString withFontSize:hcLineChartView.fontSizeForAxis];
                    if (textSize.width > yAxisLabelTextSize.width)
                    {
                        textRect.size.width = textSize.width;
                    }
                    [self drawText:yAxisString withRect:textRect
                     withAtributes:attributes withOffset:CGPointMake(0.0, 0.0) isVertical:NO];
                }
                
                [self drawTickAtPosition:i + hcLineChartView.fontSizeForAxis / 2.0 isVertical:YES];
            }
            
            i+= yStep;
            currentValueY -= yAxisTick;
        }
        while (i < endVertical);
    }
}


/// This method draws single value and tick on vertical axis when there is no data for drawing the chart
-(void)drawVerticalAxisForOneOrZeroData
{
    NSDictionary* attributes = [self fontAttributesWithFont:[UIFont systemFontOfSize:hcLineChartView.fontSizeForAxis] fontColor:hcLineChartView.chartAxisColor textAlignment:NSTextAlignmentRight andLineBreakMode:NSLineBreakByTruncatingTail];
    NSString* yAxisString = hcLineChartView.showYValueAsCurrency ? [self currencyStringForValue:[[hcLineChartView.yElements firstObject] doubleValue] numberOfDecimalPlaces:numberOfYDecimals currencyCode:hcLineChartView.yAxisCurrencyCode] : [NSString stringWithFormat:@"%f",[[hcLineChartView.yElements firstObject] doubleValue]];
    
    CGSize textSize = [self sizeOfText:yAxisString withFontSize:hcLineChartView.fontSizeForAxis];
    
    CGRect verticalAxis = [self verticalAxisArea];
    [self drawText:yAxisString withRect:CGRectMake(
                                                   verticalAxis.origin.x + verticalAxis.size.width - chartRect.size.width * pointsRectLeftProportionalDistance,
                                                   chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight / 2.0) - chartPointDiameter / 2.0 - textSize.height,
                                                   chartRect.size.width * pointsRectLeftProportionalDistance - MIN(chartRect.size.height,chartRect.size.width) * axisDistanceFromPointsProportionaly,
                                                   textSize.height) withAtributes:attributes withOffset:CGPointMake(0.0, 0.0) isVertical:NO];
    
    [self drawTickAtPosition:chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight / 2.0) - textSize.height / 2.0  isVertical:YES];
}

#pragma mark Help methods

/// This method draws tick at specificPosition
/// @param position Tick position
/// @param isVertical This property defines if tick is for vertical or for horizontal axis
-(void)drawTickAtPosition:(double)position isVertical:(BOOL)isVertical
{
    if (isVertical && position >= [self topLeftPoint].y && position <= [self bottomLeftPoint].y)
    {
        [self drawLineFromPoint:CGPointMake([self topLeftPoint].x - 2.0, position) toPoint:CGPointMake([self topLeftPoint].x + 2.0, position) withColor:hcLineChartView.chartAxisColor andWidth:1.0];
    }
    else if (!isVertical && position <= [self bottomRightPoint].x && position >= [self bottomLeftPoint].x)
    {
        [self drawLineFromPoint:CGPointMake(position, [self bottomLeftPoint].y - 2.0) toPoint:CGPointMake(position, [self bottomLeftPoint].y + 2.0) withColor:hcLineChartView.chartAxisColor andWidth:1.0];
    }
}

/// Help method which calculates and returns vertical position of horizontal (X) axis
/// @return Vertical position of horizontal (X) axis
-(double)bottom
{
    return chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight);
}

/// Help method which calculates and returns position of the top of the vertical axis
/// @return Position of the top of the vertical axis
-(CGPoint)topLeftPoint
{
    return CGPointMake(chartRect.size.width * (pointsRectLeftProportionalDistance), chartRect.size.height * (pointsRectTopProportionalDistance));
}

/// Help method which calculates and returns position of the right of the horizontal axis
/// @return Position of the right of the horizontal axis
-(CGPoint)bottomRightPoint
{
    return CGPointMake(chartRect.size.width * (pointsRectLeftProportionalDistance + pointsRectProportionalWidth), [self bottom]);
}

/// Help method which calculates and returns position of the left of the horizontal axis
/// @return Position of the left of the horizontal axis
-(CGPoint)bottomLeftPoint
{
    return CGPointMake(chartRect.size.width * (pointsRectLeftProportionalDistance), [self bottom]);
}

/// Help method which calculates and returns position of the left of the horizontal axis
/// @return Position of the left of the horizontal axis
-(CGRect)verticalAxisArea
{
    return CGRectMake(offsetForAxisOrHeader, [self topLeftPoint].y, [self bottomLeftPoint].x - 2.0 * offsetForAxisOrHeader, fabs([self topLeftPoint].y - [self bottomLeftPoint].y));
}

@end

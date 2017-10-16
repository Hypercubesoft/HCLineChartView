//
//  HCChartDrawer+Preparation.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer+CalculationAndPreparation.h"
#import "HCChartDrawer+Text.h"
#import "HCChartDrawer+General.h"
#import "HCTimeStep.h"

@implementation HCChartDrawer (CalculationAndPreparation)

#pragma mark Prepare chart for drawing - Main method

/// This method performs basic calculations in order to calculate chart position in view
-(void)prepareChartForDrawing
{
    [self prepareChartData];
    [self setupParameters];
    if (chartType != chartWithInvalidValues)
    {
        if (numberOfElements > 1)
        {
            [self calculateMinXMaxXMinYMaxY];
            [self prepareChartCalendarSettings];
            [self findChartValuesRangeForBothAxes];
            [self calculateVerticalDimensions];
            [self calculateHorizontalDimensions];
            [self calculateMinMaxCoordinatesForYAxis];
            [self createDots];
            [self calculateMinMaxCoordinatesForXAxis];
            [self calculateTicks];
            [self calculateDotsPositionsForDrawing];
            [self prepareVerticalAxisForDrawing];
            [self prepareHorizontalAxisForDrawing];
        }
        else
        {
            [self setupDimensionsForChartWithOneOrZeroPoint];
        }
    }
}

#pragma mark Prepare Chart data before drawing

/// This method is used for prepairing chart data for drawing
-(void)prepareChartData
{
    if (hcLineChartView.xElements == NULL)
    {
        hcLineChartView.xElements = [NSMutableArray new];
    }
    if (hcLineChartView.yElements == NULL)
    {
        hcLineChartView.yElements = [NSMutableArray new];
    }
    [self makeXAndYEqualElementsEqualSize];
    if (hcLineChartView.sortData)
    {
        [self sortChartData];
    }
}

/// Fixes potential errors during drawing the chart and prevents potential app crashes if user sets different number of values for X and Y axis.
/// It is expected that user defines equal number of values for both axes.
/// If not, this method will get minimal value between number of values for X axis and number of values for Y axis and use it as the number of values.
/// In that sense, it will cut off extra data in values for X or Y axis to make those arrays equal.
-(void)makeXAndYEqualElementsEqualSize
{
    numberOfElements = MIN((int)[hcLineChartView.xElements count],(int)[hcLineChartView.yElements count]);
    if (numberOfElements > 0) {
        while ([hcLineChartView.xElements count] < numberOfElements - 1)
        {
            [hcLineChartView.xElements removeObjectAtIndex:numberOfElements];
        }
        while ([hcLineChartView.yElements count] < numberOfElements - 1)
        {
            [hcLineChartView.yElements removeObjectAtIndex:numberOfElements];
        }
    }
}

/// This method is used for sorting chart data if sortData parameter is set to YES. It should be used when user didn't sort his data before drawing the chart
-(void)sortChartData
{
    [hcLineChartView.yElements sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[hcLineChartView.xElements objectAtIndex:[hcLineChartView.yElements indexOfObject:obj1]] compare:[hcLineChartView.xElements objectAtIndex:[hcLineChartView.yElements indexOfObject:obj2]]];
    }];
    [hcLineChartView.xElements sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
}

#pragma mark Setup initial parameters

/// This method setup basic parameters needed for drawing the chart
-(void)setupParameters
{
    standardOffset = 10.0;
    chartCornerRadius = hcLineChartView.chartWithRoundedCorners ? 20.0 : 0.0;
    pointsRectProportionalWidth = 0.7;
    pointsRectTopProportionalDistance = 0.25;
    pointsRectLeftProportionalDistance = 0.25;
    pointsRectProportionalHeight = 0.5;
    chartPointDiameter = MAX(hcLineChartView.chartLineWidth * 3.0, 8.0);
    axisWidth = 1.0;
    axisDistanceFromPointsProportionaly = 0.02;
    offsetForAxisOrHeader = 4.0;
    leftOrBottomOffsetProportional = 0.02;
    
    if (numberOfElements > 0)
    {
        for (int i=0; i<numberOfElements; i++)
        {
            if ([[hcLineChartView.yElements objectAtIndex:i] isKindOfClass:[NSNumber class]])
            {
                if ([[hcLineChartView.xElements objectAtIndex:i] isKindOfClass:[NSNumber class]])
                {
                    if (chartType == chartWithNoDefinedValues || chartType == chartWithNumericalValues)
                    {
                        chartType = chartWithNumericalValues;
                    }
                    else
                    {
                        chartType = chartWithInvalidValues;
                        break;
                    }
                }
                else if ([[hcLineChartView.xElements objectAtIndex:i] isKindOfClass:[NSDate class]])
                {
                    if (chartType == chartWithNoDefinedValues || chartType == chartWithDateValues)
                    {
                        chartType = chartWithDateValues;
                    }
                    else
                    {
                        chartType = chartWithInvalidValues;
                        break;
                    }
                }
                else
                {
                    chartType = chartWithInvalidValues;
                    break;
                }
            }
            else
            {
                chartType = chartWithInvalidValues;
                break;
            }
        }
    }
    else
    {
        chartType = chartWithNumericalValues;
    }
    if (hcLineChartView.chartLineWithCircles)
    {
        chartStyle = chartLineWithCircles;
    }
    else
    {
        chartStyle = chartWithoutCircles;
    }
}

#pragma mark Chart values calculation

/// Calculates minimal and maximal values for X values and Y values
-(void)calculateMinXMaxXMinYMaxY
{
    
    minXValue = DBL_MAX;
    maxXValue = -DBL_MAX;
    minYValue = DBL_MAX;
    maxYValue = -DBL_MAX;
    
    NSDate* minXDate;
    NSDate* maxXDate;
    
    for (int i=0 ; i < numberOfElements ; i++)
    {
        double xValue = chartType == chartWithNumericalValues ? [[hcLineChartView.xElements objectAtIndex:i] doubleValue] : [((NSDate*)[hcLineChartView.xElements objectAtIndex:i]) timeIntervalSince1970];
        if (xValue < minXValue) {
            minXValue = xValue;
            if (chartType == chartWithDateValues)
            {
                minXDate = (NSDate*)[hcLineChartView.xElements objectAtIndex:i];
            }
        }
        if ([[hcLineChartView.yElements objectAtIndex:i] doubleValue]  < minYValue) {
            minYValue = [[hcLineChartView.yElements objectAtIndex:i] doubleValue];
        }
        if (xValue > maxXValue) {
            maxXValue = xValue;
            if (chartType == chartWithDateValues)
            {
                maxXDate = (NSDate*)[hcLineChartView.xElements objectAtIndex:i];
            }
        }
        if ([[hcLineChartView.yElements objectAtIndex:i] doubleValue] > maxYValue) {
            maxYValue = [[hcLineChartView.yElements objectAtIndex:i] doubleValue];
        }
    }
    if (chartType == chartWithNumericalValues)
    {
        if (minXValue == maxXValue)
        {
            if (minXValue == 0)
            {
                minXValue += 1.0;
                maxXValue += 1.0;
            }
            minXValue *= 0.99;
            maxXValue *= 1.01;
            minXValue -= 1.0;
            maxXValue -= 1.0;
            horizontalValuesAreAllEqual = YES;
        }
    }
    else if (chartType == chartWithDateValues)
    {
        NSComparisonResult result;
        result = [[NSDate dateWithTimeIntervalSince1970:(int)[maxXDate timeIntervalSince1970]] compare:[NSDate dateWithTimeIntervalSince1970:(int)[minXDate timeIntervalSince1970]]];
        
        if(result==NSOrderedSame)
        {
            if (minXValue == 0)
            {
                minXValue += 1.0;
                maxXValue += 1.0;
            }
            minXValue += 1.0;
            maxXValue += 1.0;
            minXValue -= 1.0;
            maxXValue -= 1.0;
            horizontalValuesAreAllEqual = YES;
        }
    }
    if (minYValue == maxYValue)
    {
        if (minYValue == 0)
        {
            minYValue += 1.0;
            maxYValue += 1.0;
        }
        minYValue *= 0.99;
        maxYValue *= 1.01;
        minYValue -= 1.0;
        maxYValue -= 1.0;
        verticalValuesAreAllEqual = YES;
    }
}


/// This method is used for preparing chart calendar settings, if values on X axis are represented by dates
-(void)prepareChartCalendarSettings
{
    if (chartType == chartWithDateValues)
    {
        double difference = maxXValue - minXValue;
        if (difference < 60)
        {
            calendarType = calendarWithSeconds;
        }
        else if (difference < 60 * 60)
        {
            calendarType = calendarWithMinutes;
        }
        else if (difference < 60 * 60 * 24)
        {
            calendarType = calendarWithHours;
        }
        else if (difference < 60 * 60 * 24 * 30)
        {
            calendarType = calendarWithDays;
        }
        else if (difference < 60 * 60 * 24 * 30 * 12)
        {
            calendarType = calendarWithMonths;
        }
        else
        {
            calendarType = calendarWithYears;
        }
    }
}

/// Calculates minimal and maximal values for Y coordinates of dots/points
-(void)calculateMinMaxCoordinatesForYAxis
{
    minYCoordinateOnChart = DBL_MAX;
    maxYCoordinateOnChart = -DBL_MAX;
    
    for (int k=0 ; k < numberOfElements ; k++)
    {
        double yPosition= [self yPositionForValue:[[hcLineChartView.yElements objectAtIndex:k] doubleValue]];
        if (yPosition < minYCoordinateOnChart) {
            minYCoordinateOnChart = yPosition;
        }
        if (yPosition > maxYCoordinateOnChart) {
            maxYCoordinateOnChart = yPosition;
        }
    }
}

/// This method finds range for chart values, in order to draw needed values on X or Y axis
-(void)findChartValuesRangeForBothAxes
{
    [self findChartValueRangeFoxAxis:yAxis];
    [self findChartValueRangeFoxAxis:xAxis];
}

/// This method calculates range, i.e. maximal and minimal value for defined axis
/// @param axis Axis (X or Y) identifier
-(void)findChartValueRangeFoxAxis:(HCAxis)axis
{
    double minValue;
    double maxValue;
    if (axis == xAxis)
    {
        minValue = minXValue;
        maxValue = maxXValue;
    }
    else
    {
        minValue = minYValue;
        maxValue = maxYValue;
    }
    int maxNumberOfValues;
    if (axis == yAxis)
    {
        maxNumberOfValues = chartRect.size.height/(hcLineChartView.fontSizeForAxis);
    }
    else
    {
        maxNumberOfValues = chartRect.size.width/(hcLineChartView.fontSizeForAxis);
    }
    int tick = [self tickForRange:fabs(maxValue - minValue) withNumberOfValues:maxNumberOfValues isDate:chartType == chartWithDateValues && axis == xAxis];
    if (fabs(maxValue - minValue) > 5.0)
    {
        minValue = abs((int)minValue) > abs(tick) ? (int)(minValue - (int)minValue % tick) - (minValue < 0 ? tick : 0) : (int)((int)minValue % tick == 0 ? minValue : (minValue - tick)) - (int)(minValue - tick) % tick;
        if ((int)maxValue % tick != 0)
        {
            int yTopCorrection = (int)(maxValue + tick) % tick;
            if (yTopCorrection < 0)
            {
                yTopCorrection += tick;
            }
            maxValue = (maxValue + tick) - yTopCorrection;
        }
    }
    if (axis == yAxis)
    {
        minYValueOnChart = minValue;
        endVerticalValue = minYValueOnChart;
        maxYValueOnChart = maxValue;
        startVerticalValue = maxYValueOnChart;
    }
    else
    {
        minXValueOnChart = minValue;
        maxXValueOnChart = maxValue;
    }
}

#pragma mark Chart size calculation

/// Calculates MIN and MAX values for X coordinates of dots/points
-(void)calculateMinMaxCoordinatesForXAxis
{
    minXCoordinateOnChart = DBL_MAX;
    maxXCoordinateOnChart = -DBL_MAX;
    
    int numberOfPoints = 0;
    
    while (numberOfPoints < numberOfElements) {
        HCChartPoint* HCChartPoint1 = (HCChartPoint*)[chartDots objectAtIndex:numberOfPoints];
        double xValue = HCChartPoint1.x;
        if (xValue < minXCoordinateOnChart)
        {
            minXCoordinateOnChart = xValue;
        }
        if (xValue > maxXCoordinateOnChart)
        {
            maxXCoordinateOnChart = xValue;
        }
        numberOfPoints ++;
    }
}

/// This method is used for calculating horizontal dimensions for chart drawing
-(void)calculateHorizontalDimensions
{
    if (chartType == chartWithDateValues)
    {
        [self calculateHorizontalDimensionsForDate];
    }
    else if (chartType == chartWithNumericalValues)
    {
        [self calculateHorizontalDimensionsForValues];
    }
}


/// Calculates height of chart and top distance of chart from this view when X axis is made of dates
-(void)calculateHorizontalDimensionsForDate
{
    NSString* xAxisString = [self timeStringForValue:972253342];    //972253342 is example timestamp for date with big text size
    xAxisLabelTextSize = [self sizeOfText:xAxisString withFontSize:hcLineChartView.fontSizeForAxis];
    pointsRectTopProportionalDistance = (hcLineChartView.fontSizeForTitle + (hcLineChartView.showSubtitle ? hcLineChartView.fontSizeForSubTitle : 0.0) + 20.0) / chartRect.size.height;
    pointsRectProportionalHeight = (chartRect.size.height * ( 1.0 - pointsRectTopProportionalDistance) - standardOffset * 2.0 - (hcLineChartView.horizontalValuesOnXAxis ? xAxisLabelTextSize.height : xAxisLabelTextSize.width)) / chartRect.size.height;
}

/// Calculates height of chart and top distance of chart from this view when X axis is made of numerical values
-(void)calculateHorizontalDimensionsForValues
{
    numberOfXDecimals = 0;
    double range = maxXValue - minXValue;
    if (range > 0)
    {
        double maxNumberOfValues = chartRect.size.width/(hcLineChartView.fontSizeForAxis);
        double potentialTickSize = range/maxNumberOfValues;
        while (potentialTickSize < 1.0)
        {
            potentialTickSize *= 10.0;
            numberOfXDecimals ++;
        }
    }
    else
    {
        if (minXValue != 0)
        {
            double oneValue = minXValue;
            while (oneValue < 1)
            {
                numberOfXDecimals ++;
                oneValue *= 10.0;
            }
        }
    }
    NSString* decimalFormat = [NSString stringWithFormat:@"%%.%df",numberOfXDecimals];
    NSString* xAxisString1 = hcLineChartView.showXValueAsCurrency ? [self currencyStringForValue:minXValueOnChart numberOfDecimalPlaces:numberOfXDecimals currencyCode:hcLineChartView.xAxisCurrencyCode] : [NSString stringWithFormat:decimalFormat,minXValueOnChart];
    NSString* xAxisString2 = hcLineChartView.showXValueAsCurrency ? [self currencyStringForValue:maxXValueOnChart numberOfDecimalPlaces:numberOfXDecimals currencyCode:hcLineChartView.xAxisCurrencyCode] : [NSString stringWithFormat:decimalFormat,maxXValueOnChart];
    CGSize textSize1 = [self sizeOfText:xAxisString1 withFontSize:hcLineChartView.fontSizeForAxis];
    CGSize textSize2 = [self sizeOfText:xAxisString2 withFontSize:hcLineChartView.fontSizeForAxis];
    xAxisLabelTextSize = textSize1.width > textSize2.width ? textSize1 : textSize2;
    
    pointsRectTopProportionalDistance = (hcLineChartView.fontSizeForTitle + (hcLineChartView.showSubtitle ? hcLineChartView.fontSizeForSubTitle : 0.0) + 20.0) / chartRect.size.height;
    pointsRectProportionalHeight = (chartRect.size.height * ( 1.0 - pointsRectTopProportionalDistance) - standardOffset * 2.0 - (hcLineChartView.horizontalValuesOnXAxis ? xAxisLabelTextSize.height : xAxisLabelTextSize.width)) / chartRect.size.height;
}

/// This method calculates the position of main elements of chart if there is only one point in chart
-(void)setupDimensionsForChartWithOneOrZeroPoint
{
    NSString* xAxisString;
    if (chartType == chartWithNumericalValues) {
        xAxisString = hcLineChartView.showXValueAsCurrency ? [self currencyStringForValue:[[hcLineChartView.xElements firstObject] doubleValue] numberOfDecimalPlaces:numberOfXDecimals currencyCode:hcLineChartView.xAxisCurrencyCode] : [NSString stringWithFormat:@"%f",[[hcLineChartView.xElements firstObject] doubleValue]];
    }
    else
    {
        xAxisDateTick = [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:1 calendarType:calendarWithSeconds value:1];
        xAxisString = [self timeStringForValue:[(NSDate*)[hcLineChartView.xElements firstObject] timeIntervalSince1970]];
    }
    NSString* yAxisString = [NSString stringWithFormat:@"%f",[[hcLineChartView.yElements firstObject] doubleValue]];
    xAxisLabelTextSize = [self sizeOfText:xAxisString withFontSize:hcLineChartView.fontSizeForAxis];
    CGSize yAxisTextSize = [self sizeOfText:yAxisString withFontSize:hcLineChartView.fontSizeForAxis];
    pointsRectLeftProportionalDistance = (yAxisTextSize.width + chartRect.size.width * axisDistanceFromPointsProportionaly + 2 * leftOrBottomOffsetProportional + 2 * offsetForAxisOrHeader) / chartRect.size.width;
    pointsRectProportionalWidth = 1.0 - pointsRectLeftProportionalDistance - leftOrBottomOffsetProportional - standardOffset / chartRect.size.width;
    pointsRectTopProportionalDistance = (hcLineChartView.fontSizeForTitle + (hcLineChartView.showSubtitle ? hcLineChartView.fontSizeForSubTitle : 0.0) + 20.0) / chartRect.size.height;
    pointsRectProportionalHeight = (chartRect.size.height * ( 1.0 - pointsRectTopProportionalDistance) - 2.0 * standardOffset - (hcLineChartView.horizontalValuesOnXAxis ? xAxisLabelTextSize.height : xAxisLabelTextSize.width) - MIN(chartRect.size.width, chartRect.size.height) * 2 * leftOrBottomOffsetProportional) / chartRect.size.height;
}

/// Calculates width of chart and left distance of chart from this view
-(void)calculateVerticalDimensions
{
    numberOfYDecimals = 0;
    double range = maxYValue - minYValue;
    if (range > 0)
    {
        double maxNumberOfValues = chartRect.size.height/(hcLineChartView.fontSizeForAxis);
        double potentialTickSize = range/maxNumberOfValues;
        while (potentialTickSize < 1.0)
        {
            potentialTickSize *= 10.0;
            numberOfYDecimals ++;
        }
    }
    else
    {
        if (minYValue != 0)
        {
            double oneValue = minYValue;
            while (oneValue < 1)
            {
                numberOfYDecimals ++;
                oneValue *= 10.0;
            }
        }
    }
    
    NSString* decimalFormat = [NSString stringWithFormat:@"%%.%df",numberOfYDecimals];
    NSString* yAxisString1 = hcLineChartView.showYValueAsCurrency ? [self currencyStringForValue:minYValueOnChart numberOfDecimalPlaces:numberOfYDecimals currencyCode:hcLineChartView.yAxisCurrencyCode] : [NSString stringWithFormat:decimalFormat,minYValueOnChart];
    NSString* yAxisString2 = hcLineChartView.showYValueAsCurrency ? [self currencyStringForValue:maxYValueOnChart numberOfDecimalPlaces:numberOfYDecimals currencyCode:hcLineChartView.yAxisCurrencyCode] : [NSString stringWithFormat:decimalFormat,maxYValueOnChart];
    CGSize textSize1 = [self sizeOfText:yAxisString1 withFontSize:hcLineChartView.fontSizeForAxis];
    CGSize textSize2 = [self sizeOfText:yAxisString2 withFontSize:hcLineChartView.fontSizeForAxis];
    yAxisLabelTextSize = textSize1.width > textSize2.width ? textSize1 : textSize2;
    pointsRectLeftProportionalDistance = (yAxisLabelTextSize.width + 2 * standardOffset) / chartRect.size.width;
    pointsRectProportionalWidth = 1.0 - pointsRectLeftProportionalDistance - leftOrBottomOffsetProportional - standardOffset / chartRect.size.width;
}

#pragma mark Prepare chart dots for drawing

/// This method calculate the position of dots in the chart
-(void)createDots
{
    if (numberOfElements > 1)
    {
        double i = 0.0;
        double oneFieldWidth = (chartRect.size.width * pointsRectProportionalWidth - 2.0 * standardOffset) / (numberOfElements - 1);
        chartDots = [[NSMutableArray alloc] init];
        for (int k=0 ; k < numberOfElements ; k++)
        {
            double xPosition = 0.0;
            if (hcLineChartView.isValueChartWithRealXAxisDistribution)
            {
                if (chartType == chartWithNumericalValues)
                {
                    xPosition = [self xPositionForValue:[[hcLineChartView.xElements objectAtIndex:k] doubleValue]];
                }
                else if (chartType == chartWithDateValues)
                {
                    xPosition = [self xPositionForValue:[[hcLineChartView.xElements objectAtIndex:k] timeIntervalSince1970]];
                }
            }
            else
            {
                xPosition = chartRect.size.width * pointsRectLeftProportionalDistance + i * oneFieldWidth + standardOffset;
            }
            double yPosition = [self yPositionForValue:[[hcLineChartView.yElements objectAtIndex:k] doubleValue]];
            [chartDots addObject:[[HCChartPoint alloc] initWithX:xPosition andY:yPosition]];
            
            i += 1;
        }
    }
}

/// This method calculates Y coordinate / position on chart for Y value
/// @param yValue X value
/// @return Y coordinate
-(double)yPositionForValue:(double)yValue
{
    if (startVerticalValue == endVerticalValue)
    {
        return chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight * 0.5) + standardOffset;
    }
    else
    {
        double yPosition = startVerticalValue - yValue;
        yPosition *= (chartRect.size.height * pointsRectProportionalHeight - 2 * standardOffset) / (startVerticalValue - endVerticalValue);
        yPosition += chartRect.size.height * pointsRectTopProportionalDistance + standardOffset;
        return yPosition;
    }
    
}

/// This method calculates X coordinate / position on chart for X value
/// @param xValue X value
/// @return X coordinate
-(double)xPositionForValue:(double)xValue
{
    if (horizontalValuesAreAllEqual)
    {
        return chartRect.size.width * (pointsRectProportionalWidth * 0.5 + pointsRectLeftProportionalDistance);
    }
    else
    {
        double xPosition = xValue - minXValue;
        xPosition *= (chartRect.size.width * pointsRectProportionalWidth - 2.0 * standardOffset) / (maxXValue - minXValue);
        xPosition += chartRect.size.width * pointsRectLeftProportionalDistance + standardOffset;
        return xPosition;
    }
    
}

/// This method makes additional calculates related to the initial dots, in order to enable drawing circles
-(void)calculateDotsPositionsForDrawing
{
    if (chartStyle == chartLineWithCircles)
    {
        int numberOfPoints = 0;
        startDots = [[NSMutableArray alloc] init];
        endDots = [[NSMutableArray alloc] init];
        while (numberOfPoints < numberOfElements - 1)
        {
            HCChartPoint* chartPoint1 = (HCChartPoint*)[chartDots objectAtIndex:numberOfPoints];
            CGPoint startPoint = CGPointMake(chartPoint1.x, chartPoint1.y);
            HCChartPoint* chartPoint2 = (HCChartPoint*)[chartDots objectAtIndex:numberOfPoints + 1];
            CGPoint endPoint = CGPointMake(chartPoint2.x, chartPoint2.y);
            CGPoint tempEndPoint;
            if (numberOfPoints == numberOfElements - 2)
            {
                tempEndPoint = endPoint;
            }
            double distance = sqrt(pow((endPoint.x - startPoint.x), 2.0) + pow((endPoint.y - startPoint.y), 2.0));
            double xDistance = endPoint.x - startPoint.x;
            double yDistance = endPoint.y - startPoint.y;
            startPoint.x += (chartPointDiameter - hcLineChartView.chartLineWidth) /2.0 * xDistance / distance;
            startPoint.y += (chartPointDiameter - hcLineChartView.chartLineWidth) /2.0 * yDistance / distance;
            endPoint.x -= (chartPointDiameter - hcLineChartView.chartLineWidth) /2.0 * xDistance / distance;
            endPoint.y -= (chartPointDiameter - hcLineChartView.chartLineWidth) /2.0 * yDistance / distance;
            [startDots addObject:[NSValue valueWithCGPoint:startPoint]];
            [endDots addObject:[NSValue valueWithCGPoint:endPoint]];
            numberOfPoints++;
        }
    }
    int numberOfPoints = 0;
    middleDots = [[NSMutableArray<NSNumber*> alloc] init];
    while (numberOfPoints < numberOfElements)
    {
        HCChartPoint* chartPoint = (HCChartPoint*)[chartDots objectAtIndex:numberOfPoints];
        CGPoint middlePoint = CGPointMake(chartPoint.x, chartPoint.y);
        [middleDots addObject:[NSValue valueWithCGPoint:middlePoint]];
        numberOfPoints++;
    }
}

#pragma mark Prepare axes for drawing and calculate ticks


/// This method prepares horizontal axis for drawing
-(void)prepareHorizontalAxisForDrawing
{
    double tempMinX = minXValue;
    double tempMaxX = maxXValue;
    double tempXAxisTick = xAxisTick;
    double multiplier = 1.0;
    int numberOfDecimalsForXAxis = 0;
    while (numberOfDecimalsForXAxis < numberOfXDecimals)
    {
        multiplier *= 10;
        tempXAxisTick *= 10;
        tempMinX *= 10;
        tempMaxX *= 10;
        numberOfDecimalsForXAxis ++;
    }
    startHorizontalValue = tempMinX > 0 ? (((int)tempMinX - (int)tempMinX % (int)tempXAxisTick) / multiplier) : (((int)tempMinX - (int)tempXAxisTick - (int)tempMinX % (int)tempXAxisTick) / multiplier);
    xStep = horizontalValuesAreAllEqual ? (chartRect.size.width * pointsRectProportionalWidth - 2.0 * standardOffset) * 0.5 : MAX(fabs(maxXCoordinateOnChart - minXCoordinateOnChart) * xAxisTick/fabs(maxXValue - minXValue), hcLineChartView.fontSizeForAxis);
    [self fixCalculationForDrawing];
}

/// This method performs additional calculations for X axis, chart height and Y axis in order to prevent potential errors during drawing
-(void)fixCalculationForDrawing
{
    currentPositionX = minXCoordinateOnChart;
    currentValueX = horizontalValuesAreAllEqual ? (chartType == chartWithNumericalValues ? [[hcLineChartView.xElements firstObject] doubleValue] : [[hcLineChartView.xElements firstObject] timeIntervalSince1970]) : startHorizontalValue;
    jumpOverX = 1.0;
    decimalFormatX = [NSString stringWithFormat:@"%%.%df",numberOfXDecimals];
    
    if (!hcLineChartView.isValueChartWithRealXAxisDistribution)
    {
        currentPositionX = ((HCChartPoint*)[chartDots firstObject]).x;
        currentValueX = chartType == chartWithNumericalValues ? [[hcLineChartView.xElements firstObject] doubleValue] : [[hcLineChartView.xElements firstObject] timeIntervalSince1970];
        xStep = MAX(fabs(((HCChartPoint*)[chartDots lastObject]).x - ((HCChartPoint*)[chartDots firstObject]).x)/(numberOfElements - 1), hcLineChartView.fontSizeForAxis);
    }
    else
    {
        if ( chartType == chartWithNumericalValues)
        {
            currentPositionX -= ([((NSNumber*)[hcLineChartView.xElements firstObject]) doubleValue] - currentValueX) / xAxisTick * xStep;
        }
        else
        {
            currentValueX -= [[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate dateWithTimeIntervalSince1970:currentValueX]];
            currentPositionX -= ([((NSDate*)[hcLineChartView.xElements firstObject]) timeIntervalSince1970] - currentValueX) / xAxisTick * xStep;
        }
    }
    
    if (chartType == chartWithNumericalValues || (chartType == chartWithDateValues && !hcLineChartView.isValueChartWithRealXAxisDistribution))
    {
        while (xStep < (hcLineChartView.horizontalValuesOnXAxis ? xAxisLabelTextSize.width : hcLineChartView.fontSizeForAxis)) {
            jumpOverX *= 2;
            xStep *= 2.0;
            xAxisTick *= 2.0;
        }
    }
    else if (chartType == chartWithDateValues && hcLineChartView.isValueChartWithRealXAxisDistribution)
    {
        NSString* timeFormatX = xAxisDateTick.timeFormat;
        int counter = 0;
        BOOL changedMultiplier = NO;
        int count = timeSteps != NULL && [timeSteps count] > 0 ? (int)[timeSteps count] - 1 : 0;
        for (int i = 0; i < count; i++)
        {
            HCTimeStep* singleTimeStep = [timeSteps objectAtIndex:i];
            if (singleTimeStep == xAxisDateTick && xStep < (hcLineChartView.horizontalValuesOnXAxis ? xAxisLabelTextSize.width : hcLineChartView.fontSizeForAxis))
            {
                changedMultiplier = YES;
                xAxisDateTick = [timeSteps objectAtIndex:i+1];
                double multiplier = (double)[xAxisDateTick multiplier] / (double)[singleTimeStep multiplier];
                jumpOverX *= multiplier;
                xStep *= multiplier;
                xAxisTick *= multiplier;
                [self calculateHorizontalDimensionsForDate];
            }
            counter++;
        }
        if (changedMultiplier)
        {
            int number = currentValueX + [[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate dateWithTimeIntervalSince1970:currentValueX]];
            int multiplier = xAxisDateTick.multiplier;
            int result = ((number + multiplier/2) / multiplier - 1) * multiplier;
            int oldValue = currentValueX;
            currentValueX = result - [[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate dateWithTimeIntervalSince1970:currentValueX]];
            currentPositionX -= (oldValue - result) / xAxisTick * xStep;
            if (![timeFormatX isEqualToString:xAxisDateTick.timeFormat])
            {
                [self createDots];
                [self calculateDotsPositionsForDrawing];
                [self calculateMinMaxCoordinatesForYAxis];
                [self prepareVerticalAxisForDrawing];
            }
        }
    }
    if (minXCoordinateOnChart == maxXCoordinateOnChart)
    {
        if (horizontalValuesAreAllEqual)
        {
            currentPositionX = chartRect.size.width * pointsRectLeftProportionalDistance + standardOffset;
            currentValueX -= xAxisTick;
        }
        else
        {
            while (currentPositionX > chartRect.size.width * pointsRectLeftProportionalDistance + standardOffset)
            {
                currentPositionX -= xStep;
                currentValueX -= xAxisTick;
            }
        }
    }
}

/// This method prepares vertical axis for drawing
-(void)prepareVerticalAxisForDrawing
{
    startVertical = chartRect.origin.y + pointsRectTopProportionalDistance * chartRect.size.height + standardOffset;
    endVertical = chartRect.origin.y + (pointsRectTopProportionalDistance + pointsRectProportionalHeight) * chartRect.size.height - standardOffset;
    double tempMaxY = maxYValue;
    double tempMinY = minYValue;
    double tempYAxisTick = yAxisTick;
    double multiplier = 1.0;
    int numberOfDecimalsForYAxis = 0;
    while (numberOfDecimalsForYAxis < numberOfYDecimals)
    {
        multiplier *= 10;
        tempYAxisTick *= 10;
        tempMaxY *= 10;
        tempMinY *= 10;
        numberOfDecimalsForYAxis ++;
    }
    startVerticalValue = ((int)tempMaxY + (int)tempYAxisTick - (int)tempMaxY % (int)tempYAxisTick) / multiplier;
    while (startVerticalValue - yAxisTick > maxYValue)
    {
        startVerticalValue -= yAxisTick;
    }
    double tempVerticalValue = startVerticalValue;
    while (tempVerticalValue > minYValueOnChart)
    {
        tempVerticalValue -= yAxisTick;
    }
    endVerticalValue = tempVerticalValue;
    yStep = fabs(startVertical - endVertical) * yAxisTick/fabs(startVerticalValue  - endVerticalValue);
    [self createDots];
    [self calculateDotsPositionsForDrawing];
}

/// This method calculates tick sizes and recalculates number of decimals for both axes
-(void)calculateTicks
{
    int numberOfXValues = horizontalValuesAreAllEqual ? 3 : hcLineChartView.horizontalValuesOnXAxis ?
    hcLineChartView.isValueChartWithRealXAxisDistribution ? fabs(maxXCoordinateOnChart - minXCoordinateOnChart)/(xAxisLabelTextSize.width + 5.0) : MIN(fabs(maxXCoordinateOnChart - minXCoordinateOnChart)/(xAxisLabelTextSize.width + 5.0),numberOfElements) :
    hcLineChartView.isValueChartWithRealXAxisDistribution ? fabs(maxXCoordinateOnChart - minXCoordinateOnChart + hcLineChartView.fontSizeForAxis)/(hcLineChartView.fontSizeForAxis) : MIN(fabs(maxXCoordinateOnChart - minXCoordinateOnChart + hcLineChartView.fontSizeForAxis)/(hcLineChartView.fontSizeForAxis),numberOfElements);
    xAxisTick = numberOfXValues > 0 ? chartType == chartWithDateValues ? xAxisTick: [self findTickForMin:minXValue andMax:maxXValue andNumberOfValues:numberOfXValues isDate:NO] : 1.0;
    double potentialTickSize;
    if (!horizontalValuesAreAllEqual)
    {
        numberOfXDecimals = 0;
        potentialTickSize = xAxisTick;
        while (potentialTickSize < 1.0)
        {
            potentialTickSize *= 10.0;
            numberOfXDecimals ++;
        }
    }
    int numberOfYValues = fabs(maxYCoordinateOnChart - minYCoordinateOnChart + hcLineChartView.fontSizeForAxis)/(hcLineChartView.fontSizeForAxis);
    yAxisTick = [self findTickForMin:minYValue andMax:maxYValue andNumberOfValues:numberOfYValues isDate:NO];
    if (!verticalValuesAreAllEqual)
    {
        numberOfYDecimals = 0;
        potentialTickSize = yAxisTick;
        while (potentialTickSize < 1.0)
        {
            potentialTickSize *= 10.0;
            numberOfYDecimals ++;
        }
    }
}

/// This method calculates tich value for defined maximal and minimal value and max possible number of values, in order to draw values on X or Y axis
/// @param minValue Minimal value for tick size calculation
/// @param maxValue Maximal value for tick size calculation
/// @param numberOfValues Maximal number of values
/// @param isDate Boolean value which determines if this method has to calculate tick for date/time or for numerical values
/// @return Calculated tick size
-(double)findTickForMin:(double)minValue andMax:(double)maxValue andNumberOfValues:(int)numberOfValues isDate:(BOOL)isDate
{
    double range = fabs(maxValue - minValue);
    return [self tickForRange:range withNumberOfValues:numberOfValues isDate:isDate];
}

/// This method calculates tick value in case when we have relativelly large numbers on a axis (when range between maximal and minimal value for the axis is greater than 5)
/// @param range Range for tick size calculation
/// @param numberOfValues Maximal number of values
/// @param isDate Boolean value which determines if this method has to calculate tick for date/time or for numerical values
/// @return Optimum tick size for given parameters
-(double)tickForLargeRange:(double)range withNumberOfValues:(int)numberOfValues isDate:(BOOL)isDate
{
    if (isDate)
    {
        return [self tickForDateWithRange:range withNumberOfValues:numberOfValues];
    }
    else
    {
        double valueForDifference = range / numberOfValues;
        double tempValueForDifference = 1.0;
        int a = 1.0;
        int b = 2.0;
        int c = 5.0;
        while (valueForDifference > a || valueForDifference > b || valueForDifference > c)
        {
            if (valueForDifference < a)
            {
                break;
            }
            tempValueForDifference = b;
            a *= 10;
            
            if (valueForDifference < b)
            {
                break;
            }
            tempValueForDifference = c;
            b *= 10;
            if (valueForDifference < c)
            {
                break;
            }
            tempValueForDifference = a;
            c *= 10;
        }
        valueForDifference = tempValueForDifference;
        return valueForDifference;
    }
}



/// Method for calculating tick size when values are represented as dates
/// @param range Range for tick size calculation
/// @param numberOfValues Maximal number of values
/// @return Optimum tick size for given parameters
-(double)tickForDateWithRange:(double)range withNumberOfValues:(int)numberOfValues
{
    timeSteps = [[NSArray<HCTimeStep*> alloc] initWithObjects:
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:1 calendarType:calendarWithSeconds value:1],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:2 calendarType:calendarWithSeconds value:2],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:3 calendarType:calendarWithSeconds value:3],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:4 calendarType:calendarWithSeconds value:4],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:5 calendarType:calendarWithSeconds value:5],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:10 calendarType:calendarWithSeconds value:10],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:15 calendarType:calendarWithSeconds value:15],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:20 calendarType:calendarWithSeconds value:20],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:30 calendarType:calendarWithSeconds value:30],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:60 calendarType:calendarWithMinutes value:1],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:2 * 60 calendarType:calendarWithMinutes value:2],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:3 * 60 calendarType:calendarWithMinutes value:3],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:4 * 60 calendarType:calendarWithMinutes value:4],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:5 * 60 calendarType:calendarWithMinutes value:5],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:10 * 60 calendarType:calendarWithMinutes value:10],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:15 * 60 calendarType:calendarWithMinutes value:15],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:20 * 60 calendarType:calendarWithMinutes value:20],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:30 * 60 calendarType:calendarWithMinutes value:30],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" withMultiplier:3600 calendarType:calendarWithHours value:1],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" alternativeTimeFormat:@"dd/MM/yyyy HH:mm:ss" withMultiplier:2 * 3600 calendarType:calendarWithHours value:2 referentRangeForAlternativeText:36 * 3600],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" alternativeTimeFormat:@"dd/MM/yyyy HH:mm:ss" withMultiplier:3 * 3600 calendarType:calendarWithHours value:3 referentRangeForAlternativeText:36 * 3600],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" alternativeTimeFormat:@"dd/MM/yyyy HH:mm:ss" withMultiplier:4 * 3600 calendarType:calendarWithHours value:4 referentRangeForAlternativeText:36 * 3600],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" alternativeTimeFormat:@"dd/MM/yyyy HH:mm:ss" withMultiplier:6 * 3600 calendarType:calendarWithHours value:6 referentRangeForAlternativeText:36 * 3600],
                 [[HCTimeStep alloc] initWithTimeFormat:@"HH:mm:ss" alternativeTimeFormat:@"dd/MM/yyyy HH:mm:ss" withMultiplier:12 * 3600 calendarType:calendarWithHours value:12 referentRangeForAlternativeText:36 * 3600],
                 [[HCTimeStep alloc] initWithTimeFormat:@"dd/MM/yyyy" withMultiplier:24 * 3600 calendarType:calendarWithDays value:1],
                 [[HCTimeStep alloc] initWithTimeFormat:@"dd/MM/yyyy" withMultiplier:48 * 3600 calendarType:calendarWithDays value:2],
                 [[HCTimeStep alloc] initWithTimeFormat:@"dd/MM/yyyy" withMultiplier:72 * 3600 calendarType:calendarWithDays value:3],
                 [[HCTimeStep alloc] initWithTimeFormat:@"dd/MM/yyyy" withMultiplier:96 * 3600 calendarType:calendarWithDays value:4],
                 [[HCTimeStep alloc] initWithTimeFormat:@"dd/MM/yyyy" withMultiplier:120 * 3600 calendarType:calendarWithDays value:5],
                 [[HCTimeStep alloc] initWithTimeFormat:@"dd/MM/yyyy" withMultiplier:7 * 86400 calendarType:calendarWithWeeks value:1],
                 [[HCTimeStep alloc] initWithTimeFormat:@"dd/MM/yyyy" withMultiplier:240 * 3600 calendarType:calendarWithDays value:10],
                 [[HCTimeStep alloc] initWithTimeFormat:@"dd/MM/yyyy" withMultiplier:2 * 7 * 86400 calendarType:calendarWithWeeks value:2],
                 [[HCTimeStep alloc] initWithTimeFormat:@"MM/yyyy" withMultiplier:30.44 * 86400 calendarType:calendarWithMonths value:1],
                 [[HCTimeStep alloc] initWithTimeFormat:@"MM/yyyy" withMultiplier:2.0 * 30.44 * 86400 calendarType:calendarWithMonths value:2],
                 [[HCTimeStep alloc] initWithTimeFormat:@"MM/yyyy" withMultiplier:3.0 * 30.44 * 86400 calendarType:calendarWithMonths value:3],
                 [[HCTimeStep alloc] initWithTimeFormat:@"MM/yyyy" withMultiplier:4.0 * 30.44 * 86400 calendarType:calendarWithMonths value:4],
                 [[HCTimeStep alloc] initWithTimeFormat:@"MM/yyyy" withMultiplier:6.0 * 30.44 * 86400 calendarType:calendarWithMonths value:6],
                 [[HCTimeStep alloc] initWithTimeFormat:@"yyyy" withMultiplier:365 * 86400 calendarType:calendarWithYears value:1],
                 [[HCTimeStep alloc] initWithTimeFormat:@"yyyy" withMultiplier:2 * 365 * 86400 calendarType:calendarWithYears value:2],
                 [[HCTimeStep alloc] initWithTimeFormat:@"yyyy" withMultiplier:3 * 365 * 86400 calendarType:calendarWithYears value:3],
                 [[HCTimeStep alloc] initWithTimeFormat:@"yyyy" withMultiplier:4 * 365 * 86400 calendarType:calendarWithYears value:4],
                 [[HCTimeStep alloc] initWithTimeFormat:@"yyyy" withMultiplier:5 * 365 * 86400 calendarType:calendarWithYears value:5],
                 [[HCTimeStep alloc] initWithTimeFormat:@"yyyy" withMultiplier:10 * 365 * 86400 calendarType:calendarWithYears value:10],
                 [[HCTimeStep alloc] initWithTimeFormat:@"yyyy" withMultiplier:20 * 365 * 86400 calendarType:calendarWithYears value:100],
                 nil];
    for (HCTimeStep* singleTimeStep in timeSteps)
    {
        CGSize textSize;
        if (singleTimeStep.alternativeTimeFormat && range > singleTimeStep.referentRangeForAlternativeText)
        {
            singleTimeStep.useAlternativeTimeFormat = YES;
            textSize = [self sizeOfText:[self timeStringForDate:[NSDate date] withFormat:singleTimeStep.alternativeTimeFormat] withFontSize:hcLineChartView.fontSizeForAxis];
        }
        else
        {
            textSize = [self sizeOfText:[self timeStringForDate:[NSDate date] withFormat:singleTimeStep.timeFormat] withFontSize:hcLineChartView.fontSizeForAxis];
        }
        numberOfValues = chartRect.size.width * pointsRectProportionalWidth / (hcLineChartView.horizontalValuesOnXAxis ? textSize.width : textSize.height);
        
        if (singleTimeStep.multiplier * numberOfValues > range && (singleTimeStep.useAlternativeTimeFormat ? numberOfValues > 3 : YES))
        {
            xAxisDateTick = singleTimeStep;
            xAxisTick = [singleTimeStep multiplier];
            return range / numberOfValues;
        }
    }
    return range/numberOfValues;
}

/// This method calculates tick value in case when we have relativelly small numbers on a axis (when range between maximal and minimal value for the axis is lower than 5)
/// @param range Range for tick size calculation
/// @param numberOfValues Maximal number of values
/// @return Optimum tick size for given parameters
-(double)tickForSmallRange:(double)range withNumberOfValues:(int)numberOfValues isDate:(BOOL)isDate
{
    if (isDate)
    {
        return [self tickForDateWithRange:range withNumberOfValues:numberOfValues];
    }
    else
    {
        double valueForDifference = range / numberOfValues;
        double a = 1.0;
        double b = 2.0;
        double c = 5.0;
        while (valueForDifference < a || valueForDifference < b || valueForDifference < c) {
            c /= 10.0;
            if (valueForDifference > c)
            {
                valueForDifference = a;
                break;
            }
            b /= 10.0;
            if (valueForDifference > b)
            {
                valueForDifference = c;
                break;
            }
            a /= 10.0;
            if (valueForDifference > a)
            {
                valueForDifference = b;
                break;
            }
        }
        return valueForDifference;
    }
}

/// This method is used for calculating tick values
/// @param range Range for tick size calculation
/// @param numberOfValues Maximal number of values
/// @param isDate Boolean value which determines if this method has to calculate tick for date/time or for numerical values
/// @return double Calculated tick
-(double)tickForRange:(double)range withNumberOfValues:(int)numberOfValues isDate:(BOOL)isDate
{
    if (range > 1.0) {
        return [self tickForLargeRange:range withNumberOfValues:numberOfValues isDate:isDate];
    }
    else
    {
        return [self tickForSmallRange:range withNumberOfValues:numberOfValues isDate:isDate];
    }
}


@end

//
//  HCChartDrawer.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCLineChartView.h"

@class HCTimeStep;

@interface HCChartDrawer : NSObject
{
    
#pragma mark Chart Coordinates
/// This property defines minimal X coordinate on chart. It is calculated runtime.
    double minXCoordinateOnChart;
    
/// This property defines maximal X coordinate on chart. It is calculated runtime.
    double maxXCoordinateOnChart;
    
/// This property defines minimal Y coordinate on chart. It is calculated runtime.
    double minYCoordinateOnChart;
    
/// This property defines maximal Y coordinate on chart. It is calculated runtime.
    double maxYCoordinateOnChart;
    
#pragma mark Represented Values on Chart
    
/// This property defines minimal value for X axis on chart. It is calculated runtime.
    double minXValueOnChart;
    
/// This property defines maximal value for X axis on chart. It is calculated runtime.
    double maxXValueOnChart;
    
/// This property defines minimal value for Y axis on chart. It is calculated runtime.
    double minYValueOnChart;
    
/// This property defines maximal value for Y axis on chart. It is calculated runtime.
    double maxYValueOnChart;
    
/// Helper attribute, i.e. current value for X axis during drawing values on X axis
    double currentValueX;
    
/// Helper attribute, i.e. current value for Y axis during drawing values on Y axis
    double currentValueY;
    
/// Decimal format for values on X axis (if values on X axis are numeric).
    NSString* decimalFormatX;
    
/// Helper attribute, i.e. current position (X coordinate) for X axis during drawing values on X axis
    double currentPositionX;
    
/// Helper attribute, which defines number of values on X axis which are bypassed when there are more values on X axis then there is possible to draw value for every of them on chart.
    double jumpOverX;
    
#pragma mark Chart Data Maximal and Minimal Values
    
/// This property defines minimal value for values in X array. It is calculated runtime.
    double minXValue;
    
/// This property defines maximal value for values in X array. It is calculated runtime.
    double maxXValue;
    
/// This property defines minimal value for values in Y array. It is calculated runtime.
    double minYValue;
    
/// This property defines maximal value for values in Y array. It is calculated runtime.
    double maxYValue;
    
#pragma mark Chart Dots
    
/// Array with help dots, i.e. start dots for lines between circles if chart dots are represented with circles.
    NSMutableArray* startDots;
    
/// Array with help dots, i.e. end dots for lines between circles if chart dots are represented with circles.
    NSMutableArray* endDots;
    
/// Array with help dots, i.e. start dots for lines between circles if chart dots are not represented with circles.
    NSMutableArray* middleDots;
    
/// Array with chart dots.
    NSMutableArray* chartDots;
    
/// This property defines offset for drawing chart header or chart axis
    double offsetForAxisOrHeader;
    
/// Reference to HCLineChartView instance where HCChartDrawer needs to draw the chart.
    HCLineChartView* hcLineChartView;
    
/// HCLineChartView rect size, necessary for accurate drawing chart componente
    CGRect chartRect;
    
/// This property defines X axis tick size if values on X axis are represented as numerical values. It is calculated runtime.
    double xAxisTick;
    
/// This property defines X axis tick size if values on X axis are represented as date / time values. It is calculated runtime.
    HCTimeStep* xAxisDateTick;
    
/// This property defines Y axis tick size. It is calculated runtime.
    double yAxisTick;
    
/// This property defines space between ticks on X axis. It is calculated runtime.
    double xStep;
    
/// This property defines space between ticks on Y axis. It is calculated runtime.
    double yStep;
    
/// This property defines number of decimals places for values on X axis. It is calculated runtime.
    int numberOfXDecimals;
    
/// This property defines number of decimals places for values on Y axis. It is calculated runtime.
    int numberOfYDecimals;
    
/// This property defines Y coordinate of the top of the vertical (Y) axis. It is calculated runtime.
    double startVertical;
    
/// This property defines Y coordinate of the bottom of the vertical (Y) axis. It is calculated runtime.
    double endVertical;
    
/// This property defines value for the most top value on Y axis. It is calculated runtime.
    double startVerticalValue;
    
/// This property defines value for the most bottom value on Y axis. It is calculated runtime.
    double endVerticalValue;
    
/// This property defines value for the first value on X axis. It is calculated runtime.
    double startHorizontalValue;
    
/// This property defines array for storing HCTimeStep instances, i.e. potential options for displaying values on X axis if values for X axis are represented as date / time values.
    NSArray<HCTimeStep*>* timeSteps;
    
/// This property indicates that all values on horizontal (X) axis are equal.
    BOOL horizontalValuesAreAllEqual;
    
/// This property indicates that all values on vertical (Y) axis are equal.
    BOOL verticalValuesAreAllEqual;
    
#pragma mark Chart Dimensions
/// This property defines relative distance between chart and its borders
    double leftOrBottomOffsetProportional;
    
/// This property defines chart point diameter if chart points are represented with circles
    double chartPointDiameter;
    
    
/// This property defines corner radius for rounded rect if user selects to use chart with rounded corners.
    float chartCornerRadius;
    
/// This property defines axis width
    double axisWidth;
    
/// This property defines relative distance from axes to points
    double axisDistanceFromPointsProportionaly;
    
/// This property defines proportional width of chart area (part of chart where the dots are presented) relative to chart view width. It is calculated runtime.
    double pointsRectProportionalWidth;
    
/// This property defines proportional height of chart area (part of chart where the dots are presented) relative to chart view height. It is calculated runtime.
    double pointsRectProportionalHeight;
    
/// This property defines relative distance between chart dots and top edge of the chart view. It is calculated runtime.
    double pointsRectTopProportionalDistance;
    
/// efines relative distance between chart dots and left edge of the chart view. It is calculated runtime.
    double pointsRectLeftProportionalDistance;
    
/// This property defines maximal text size for values on X axis. It is calculated runtime
    CGSize xAxisLabelTextSize;
    
/// This property defines maximal text size for values on Y axis. It is calculated runtime
    CGSize yAxisLabelTextSize;
    
/// Standard offset parameter for drawing chart axis
    double standardOffset;
    
#pragma mark Chart Settings
    
/// This property defines chart calendar type, it is calculated runtime
    HCCalendarType calendarType;
    
/// This property defines chart type. It is calculated runtime.
    HCChartType chartType;
    
/// This property defines if dots in chart are represented as simple dots or with circles. This property is indirectly defined by user, by chartLineWithCircles parameter in HCLineChartView.
    HCChartStyle chartStyle;
    
#pragma mark Chart Data
/// Used for storing number of values to be presented in chart.
    int numberOfElements;
}

/// Method for drawing chart inside linearChartView. This method, in fact, uses another methods for pre-drawing calulations and for drawing separate parts of chart, like chart background, title, subtitle, dots, axes,...
/// @param linearChartView Reference to the HCLineChartView instance. HCChartDrawer needs to draw chart inside this instance
/// @param rect Rect for HCLineChartView
-(void)drawChart:(HCLineChartView*)linearChartView inRect:(CGRect)rect;

@end

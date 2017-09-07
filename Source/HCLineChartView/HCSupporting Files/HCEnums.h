//
//  Header.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#ifndef Header_h
#define Header_h

/// This property defines chart type based on values on X asix. It is defined automatic.
typedef enum HCChartType
{
    chartWithNoDefinedValues,
    chartWithNumericalValues,
    chartWithDateValues,
    chartWithInvalidValues
} HCChartType;

/// This property defines if axis is horizontal (X axis) or vertical (Y axis)
typedef enum HCAxis
{
    xAxis,
    yAxis
} HCAxis;

/// This property defines chart style, i.e. if points in charts should be represented with simple dots (withoud circles) or with cirles
typedef enum HCChartStyle
{
    chartLineWithCircles,
    chartWithoutCircles
} HCChartStyle;


/// This property defines calendar type for the chart. It is used inside HCLineChartView library for displaying appropriate date / time values on X axis if values on X axis are represented as NSDate instances.
typedef enum HCCalendarType
{
    calendarWithYears,
    calendarWithMonths,
    calendarWithWeeks,
    calendarWithDays,
    calendarWithHours,
    calendarWithMinutes,
    calendarWithSeconds
} HCCalendarType;



#endif /* Header_h */

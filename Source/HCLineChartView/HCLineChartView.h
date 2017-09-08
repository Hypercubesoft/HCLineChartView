//
//  LineChart.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCChartPoint.h"
#import "HCEnums.h"

@class HCChartDrawer;

IB_DESIGNABLE
/// Custom UIView inside which we're drawing the chart.
@interface HCLineChartView : UIView
{
///This class is used for drawing all elements in HCLineChartView.
    HCChartDrawer* hcChartDrawer;
}

#pragma mark Chart Background Settings

/// This property defines if chart background is transparent or not.
@property IBInspectable BOOL chartTransparentBackground;

/// This property defines if chart background has the gradient.
@property IBInspectable BOOL chartGradient;

/// This property defines the top color for background gradient. It is also the background color for the chart if chartGradient is set to NO.
@property (retain, nonatomic) IBInspectable UIColor* backgroundGradientTopColor;

/// This property defines the bottom color for background gradient.
@property (retain, nonatomic) IBInspectable UIColor* backgroundGradientBottomColor;

/// This property defines if chart view should have rounded corners.
@property IBInspectable BOOL chartWithRoundedCorners;

#pragma mark Title and Subtitle Settings

/// This property defines chart title.
@property (retain, nonatomic) IBInspectable NSString* chartTitle;

/// This property defines chart title color.
@property (retain, nonatomic) IBInspectable UIColor* chartTitleColor;

/// This property defines font size for chart title.
@property IBInspectable double fontSizeForTitle;

/// This property defines if the chart has a subtitle.
@property IBInspectable BOOL showSubtitle;

/// This property defines chart subtitle.
@property (retain, nonatomic) IBInspectable NSString* chartSubTitle;

/// This property defines font size for chart subtitle.
@property IBInspectable double fontSizeForSubTitle;

/// This property defines chart subtitle color.
@property (retain, nonatomic) IBInspectable UIColor* chartSubtitleColor;

#pragma mark Chart Axis Settings

/// This property defines chart axes color.
@property (retain, nonatomic) IBInspectable UIColor* chartAxisColor;

/// This property defines font size for chart axes.
@property IBInspectable double fontSizeForAxis;

/// This property defines if values on the X axis should be in currency format. It is useful in cases where we need to show exchange rate on chart
@property IBInspectable BOOL showXValueAsCurrency;

/// TThis property defines currency code for the X axis. It is relevant if showXValueAsCurrency parameter is set to YES. If you don't define currency code or currency code is not valid, the chart will display your local currency code.
@property (retain, nonatomic) IBInspectable NSString* xAxisCurrencyCode;

/// This property defines if values on the Y axis should be in currency format. It is useful when we need to show exchange rate on the chart (if showXValueAsCurrency is also set to YES), or in any other case where we need to show Y values in currency format (price, saving, debt, surplus, deficit,...)
@property IBInspectable BOOL showYValueAsCurrency;

/// This property defines currency code for the Y axis. It is relevant if showYValueAsCurrency parameter is set to YES. If you don't define currency code or currency code is not valid, the chart will display your local currency code.
@property (retain, nonatomic) IBInspectable NSString* yAxisCurrencyCode;

/// This property defines if values on X axis should be presented horizontally (vertically is default).
@property IBInspectable BOOL horizontalValuesOnXAxis;

/// This property defines if values on this axis should have horizontal orientation (default orientation is vertical)
@property IBInspectable BOOL drawHorizontalLinesForYTicks;

#pragma mark Chart Line Settings

/// This property defines chart line width.
@property IBInspectable float chartLineWidth;

/// This property defines chart line color.
@property (retain, nonatomic) IBInspectable UIColor* chartLineColor;

/// This property defines if chart points should have circles
@property IBInspectable BOOL chartLineWithCircles;

/// This property defines if the area under chart line should have gradient
@property IBInspectable BOOL chartGradientUnderline;

/// This property defines if bottom gradient color for the area under chart line is transparent.
@property (retain, nonatomic) IBInspectable UIColor* underLineChartGradientTopColor;

/// This property defines if bottom gradient color for the area under chart line is transparent.
@property IBInspectable BOOL underLineChartGradientBottomColorIsTransparent;

/// This property defines bottom gradient color for the area under chart line. This parameter is valid only if chart itself isn't transparent
@property (retain, nonatomic) IBInspectable UIColor* underLineChartGradientBottomColor;

/// This property defines if the distribution of values on X axis should be value based.
@property IBInspectable BOOL isValueChartWithRealXAxisDistribution;

#pragma mark Chart Data and Methods

/// It is recommended to provide already sorted data before drawing the chart. If you don't have values for X axis sorted ascending, you can set this parameter to YES. In that case, provided values for X axis (xElements) will be sorted ascending, with the parallel sorting of paired values for Y axis (yElements). Sorting data could have a small impact on chart drawing performance.
@property IBInspectable BOOL sortData;

/// Array for storing values for the X axis. Only NSNumber and NSDate values are allowed.
@property (retain, nonatomic) NSMutableArray* xElements;

/// Array for storing values for the Y axis. Only NSNumber values are allowed.
@property (retain, nonatomic) NSMutableArray* yElements;

#pragma mark Drawing and Updating Methods

/// Draws/redraws chart with current data and settings. Calling this method will call onDraw method
-(void)drawChart;

/// Updates chart with new data
/// @param xElements Values for X axis.
/// @param yElements Values for Y axis.
-(void)updateChartWithXElements:(NSArray*)xElements yElements:(NSArray*)yElements;

@end

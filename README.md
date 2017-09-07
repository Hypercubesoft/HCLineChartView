
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/HCLinearChartView.svg)](http://cocoapods.org/pods/HCLinearChartView)
[![License](https://img.shields.io/cocoapods/l/HCLinearChartView.svg?style=flat)](http://cocoapods.org/pods/HCLinearChartView)
[![Platform](https://img.shields.io/cocoapods/p/HCLinHCLinearChartViewearChart.svg?style=flat)](http://cocoapods.org/pods/HCLinearChartView)

![GitHub Logo](Images/HCLinearChartViewLogo.png)

**HCLinearChartView** is a beautiful iOS library for drawing linear charts. It is highly customizable and easy to use. 

# Examples of usage:

HCLinearChartView provides a lot of possibilities to define the desired design of the chart. There are some examples of usage:

![GitHub Logo](Images/Screenshots/HCLinearChartView-Screenshot-1.jpg)
![GitHub Logo](Images/Screenshots/HCLinearChartView-Screenshot-2.jpg)
![GitHub Logo](Images/Screenshots/HCLinearChartView-Screenshot-3.jpg)
![GitHub Logo](Images/Screenshots/HCLinearChartView-Screenshot-4.jpg)
![GitHub Logo](Images/Screenshots/HCLinearChartView-Screenshot-5.jpg)

# Features:
* Easy to set up
* Easy to change chart line design, i.e. multiple chart line attributes (title, subtitle, colors, gradients, chart line or axis width, font size, ...)
* Easy to set chart data and reload the chart
* Automatic detecting if values on the X axis are numerical values or date/time values. Also, it checks if values on the X axis and Y axis are valid.
* Automatic calculating positions and values for ticks for both axes based on chart data and chart frame.
* Automatic redrawing on size or orientation change events, without distortions.

# Installation:

## CocoaPods:
```Ruby
target '<TargetName>' do
	use_frameworks!
	pod 'HCLinearChartView'
end
```

## Manual:
If you prefer not to use CocoaPods as a dependency manager, you can integrate HCLinearChartView into your project manually. Just download repository and include Source/HCLinearChartView folder into your project.

# Usage 

1. Add HCLinearChartView library to your project via CocoaPods or manually.
2. Include HCLinearChartView library where it is needed:

    ```objective-c
    #include <HCLinearChartView/HCLinearChartView.h>
    ```
3. Place a UIView into your .storyboard or .xib file and define HCLinearChartView as its class:

    ![GitHub Logo](Images/Screenshots/HCLinearChartView-Storyboard-Screenshot.png)
    
    Also, create the outlet for this HCLinearChartView in the appropriate file. 

    ```objective-c
    @property (strong, nonatomic) IBOutlet HCLinearChartView *hcLinearChartView;
    ```
    You can also add this view from code, like any other view:

    ```objective-c
    HCLinearChartView* hcLinearChartView = [[HCLinearChartView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    [self.view addSubview:hcLinearChartView];
    ```

5. If you want to change chart line appearance and basic settings, you can setup chart settings in Interface Builder or from code. You don't have to change these parameters. In that case, the chart will be drawn with default settings. If you still want to customize the chart, you can change multiple attributes (title, subtitle, colors, corner radius, ...) directly from the storyboard or xib file. Also, you can change desired properties directly from the code, like in the following example:

   ```objective-c
    self.hcLinearChartView.chartTitle = @"Revenue over time";
    self.hcLinearChartView.chartTitleColor = [UIColor yellowColor];
    self.hcLinearChartView.showSubtitle = NO;
    self.hcLinearChartView.chartGradient = YES;
    self.hcLinearChartView.backgroundGradientTopColor = [UIColor colorWithRed:0.0 green:0.5 blue:0.5 alpha:1.0];
    self.hcLinearChartView.backgroundGradientBottomColor = [UIColor colorWithRed:0.0 green:0.3 blue:0.3 alpha:1.0];
    self.hcLinearChartView.chartLineColor = [UIColor yellowColor];
    self.hcLinearChartView.chartAxisColor = [UIColor yellowColor];
    self.hcLinearChartView.chartGradientUnderline = YES;
    self.hcLinearChartView.underLineChartGradientTopColor = [UIColor yellowColor];
    self.hcLinearChartView.underLineChartGradientBottomColor = [UIColor orangeColor];
    self.hcLinearChartView.isValueChartWithRealXAxisDistribution = YES;
    ```
    You can set all other parameters in the same way.
5. Setup or update chart data:

   ```objective-c
   self.hcLinearChartView.xElements = [[NSMutableArray alloc] initWithObjects:@(10),@(20),@(25),@(30),@(40),@(45),@(60),@(65),@(70),@(75),@(80),@(85),@(100),@(120),@(125),@(130),@(145),@(150),@(155),@(165),@(175),@(185),@(195),@(200), nil];
   self.hcLinearChartView.yElements = [[NSMutableArray alloc] initWithObjects:@(210),@(222),@(212),@(216),@(232),@(247),@(262),@(261),@(276),@(274),@(281),@(288),@(290),@(283),@(242),@(250),@(270),@(265),@(260),@(262),@(277),@(272),@(281),@(289), nil];
   ```
   If you want to show time on the X axis, you should populate ```xElements``` array with NSDate instances, like in this example:
   ```objective-c
   self.hcLinearChartView.xElements = [[NSMutableArray alloc] initWithObjects:
   [NSDate dateWithTimeIntervalSince1970:1504785810],
   [NSDate dateWithTimeIntervalSince1970:1504795873],
   [NSDate dateWithTimeIntervalSince1970:1504805270],
   [NSDate dateWithTimeIntervalSince1970:1504815840],
   [NSDate dateWithTimeIntervalSince1970:1504825810],
   [NSDate dateWithTimeIntervalSince1970:1504835873],
   [NSDate dateWithTimeIntervalSince1970:1504845270],
   [NSDate dateWithTimeIntervalSince1970:1504855840], NULL];
    ```
   
6. Draw/redraw the chart. <br>After changing the attributes or after updating chart data, you have to redraw the chart:

   ```objective-c
   [self.hcLinearChartView drawChart];
   ```
   Also, if you want to update chart data and redraw the chart, you can use updateChartWithData method:
   
   ```objective-c
    NSMutableArray* xElements = [[NSMutableArray alloc] initWithObjects:@(10),@(20),@(25),@(30),@(40),@(45),@(60),@(65),@(70),@(75),@(80),@(85),@(100),@(120),@(125),@(130),@(145),@(150),@(155),@(165),@(175),@(185),@(195),@(200), nil];
    NSMutableArray* yElements = [[NSMutableArray alloc] initWithObjects:@(210),@(222),@(212),@(216),@(232),@(247),@(262),@(261),@(276),@(274),@(281),@(288),@(290),@(283),@(242),@(250),@(270),@(265),@(260),@(262),@(277),@(272),@(281),@(289), nil];
    [self.hcLinearChartView updateChartWithXElements:xElements yElements:yElements];
    ```

In any case, you can download and run sample project from this repository. In this project, you can find an example of usage which you can use as a template for your projects. This example includes some additional helper classes (HCChartSettings, HCChartData) and additional HCChartLineView methods inside HCLinearChartView+SettingsManager category which could help you to better organize your code.

# Short preview of HCChartLineView basic parameters and methods

For the better understanding how to use those parameters and methods, here is the short overview of basic HCChartLineView attributes and methods which you can use to setup chart. 

## HCChartLineView basic attributes

### Chart Background Settings
```objective-c
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
```

### Title and Subtitle Settings
```objective-c
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
```

### Chart Axis Settings

```objective-c
/// This property defines chart axes color.
@property (retain, nonatomic) IBInspectable UIColor* chartAxisColor;

/// This property defines font size for chart axes.
@property IBInspectable double fontSizeForAxis;

/// This property defines if values on the X axis should be in currency format. It is useful in cases where we need to show exchange rate on chart
@property IBInspectable BOOL showXValueAsCurrency;

/// TThis property defines currency code for the X axis. It is relevant if showXValueAsCurrency parameter is set to YES. If you don't define currency code or currency code is not valid, the chart will display your local currency code.
@property (retain, nonatomic) NSString* xAxisCurrencyCode;

/// This property defines if values on the Y axis should be in currency format. It is useful when we need to show exchange rate on the chart (if showXValueAsCurrency is also set to YES), or in any other case where we need to show Y values in currency format (price, saving, debt, surplus, deficit,...)
@property IBInspectable BOOL showYValueAsCurrency;

/// This property defines currency code for the Y axis. It is relevant if showYValueAsCurrency parameter is set to YES. If you don't define currency code or currency code is not valid, the chart will display your local currency code.
@property (retain, nonatomic) NSString* yAxisCurrencyCode;

/// This property defines if values on X axis should be presented horizontally (vertically is default).
@property IBInspectable BOOL horizontalValuesOnXAxis;

/// This property defines if values on this axis should have horizontal orientation (default orientation is vertical)
@property IBInspectable BOOL drawHorizontalLinesForYTicks;
```

### Chart Line Settings
```objective-c
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
```

### Chart Line Data
```objective-c
/// It is recommended to provide already sorted data before drawing the chart. If you don't have values for X axis sorted ascending, you can set this parameter to YES. In that case, provided values for X axis (xElements) will be sorted ascending, with the parallel sorting of paired values for Y axis (yElements). Sorting data could have a small impact on chart drawing performance.
@property IBInspectable BOOL sortData;

/// Array for storing values for the X axis. Only NSNumber and NSDate values are allowed.
@property (retain, nonatomic) NSMutableArray* xElements;

/// Array for storing values for the Y axis. Only NSNumber values are allowed.
@property (retain, nonatomic) NSMutableArray* yElements;
```
By changing these arrays you actually change chart rate data.

## HCChartLineView Methods
### Drawing and Updating Methods
```objective-c
/// Draws/redraws chart with current data and settings.
-(void)drawChart;

/// Updates chart with new data
/// @param xElements Values for X axis.
/// @param yElements Values for Y axis.
-(void)updateChartWithXElements:(NSArray*)xElements yElements:(NSArray*)yElements;
```

# Notes
* Parameter should have reasonable values. For example. ```chartWithCircles``` parameter should be set to YES only when you have small amount of data. If you have big amount of data, those circles will overlap. Also, ```chartLineWidth``` shouldn't be too big. The same goes for the others.
* It's obvious that some attributes turn off some others. For example, if *showSubtitle* is set to NO the subtitle will be hidden, whatever text you set as a *chartSubTitle*. Also, for example, if you set transparent background, you'll not see background gradient, even if you set it.
* Only NSNumber or NSDate values are allowed for X axis and only NSNumber values for Y axis.
* Provided values for X axis should be in ascending order. If they aren't or you want to be sure that they are sorted ascending, you should set sortData parameter to YES.
* You should set a bigger frame for your HCLinearChartView, i.e. big enough to draw chart line, both axes, and other elements. Minimal frame depends on chart settings (font size, chart data, the orientation of values on X axis (horizontal or vertical),...).


If you find any bug, please report it, and we will try to fix it ASAP. Also, any suggestion is welcome.

# Credits

**HCLinearChartView** is owned and maintained by the [Hypercube](http://hypercubesoft.com/).

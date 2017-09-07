//
//  HCChartDrawer+ChartLine.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer+ChartLine.h"
#import "HCChartDrawer+CalculationAndPreparation.h"
#import "HCChartDrawer+General.h"

@implementation HCChartDrawer (ChartLine)
    
#pragma mark Draw chart line and chart dots
    
/// Draws chart line
-(void)drawChartLine
{
    if (numberOfElements > 0)
    {
        [self drawPoints];
    }
}
    
/// This is the method for drawing the chart line, the most important part of the chart
-(void)drawPoints
{
    if (numberOfElements > 1)
    {
        if (hcLineChartView.chartGradientUnderline)
        {
            if ((hcLineChartView.chartTransparentBackground && !hcLineChartView.underLineChartGradientBottomColorIsTransparent) || !hcLineChartView.chartTransparentBackground)
            {
                [self drawGradientUnderChartLine];
                if (!hcLineChartView.chartTransparentBackground)
                {
                    [self hideGradientBorders];
                }
            }
        }
        [self drawLinesAndDots];
    }
    else
    {
        CGPoint chartSingleCenterPoint = CGPointMake(chartRect.size.width * (pointsRectLeftProportionalDistance + pointsRectProportionalWidth / 2.0) - chartPointDiameter / 2.0, chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight / 2.0) - chartPointDiameter / 2.0);
        if (hcLineChartView.chartLineWithCircles)
        {
            [self drawChartPointAtPositionInside:chartSingleCenterPoint];
            [self drawChartPointAtPositionOutside:chartSingleCenterPoint];
        }
        else
        {
            [self drawLineFromPoint:chartSingleCenterPoint toPoint:chartSingleCenterPoint withColor:hcLineChartView.chartLineColor andWidth:hcLineChartView.chartLineWidth];
        }
    }
}
    
    
/// This method is used for drawing lines and dots
-(void)drawLinesAndDots
{
    if (chartStyle == chartLineWithCircles)
    {
        for (int i=0; i < numberOfElements - 1; i++)
        {
            [self drawLineFromPoint: [((NSValue*)[startDots objectAtIndex:i]) CGPointValue] toPoint:[((NSValue*)[endDots objectAtIndex:i]) CGPointValue] withColor:hcLineChartView.chartLineColor andWidth:hcLineChartView.chartLineWidth];
        }
        for (int i=0 ; i < numberOfElements ; i++)
        {
            HCChartPoint* HCChartPointt = (HCChartPoint*)[chartDots objectAtIndex:i];
            [self drawChartPointAtPositionOutside:CGPointMake(HCChartPointt.x, HCChartPointt.y)];
        }
    }
    else if (chartStyle == chartWithoutCircles)
    {
        for (int i=0; i < numberOfElements - 1; i++)
        {
            [self drawLineFromPoint: [((NSValue*)[middleDots objectAtIndex:i]) CGPointValue] toPoint:[((NSValue*)[middleDots objectAtIndex:i + 1]) CGPointValue] withColor:hcLineChartView.chartLineColor andWidth:hcLineChartView.chartLineWidth];
        }
    }
}
    
/// This method creates small circle, i.e. BezierPath (which is used for appending with gradientPath, in this case)
/// @param position Position for drawing the chart circle, as a part of Bezier path which will be attached to the basic chart gradient area Bezier path
/// @return Bezier path, i.e. circle which represents chart point
-(UIBezierPath*)drawChartPointAtPositionInside:(CGPoint)position
{
    CGRect rect = CGRectMake(position.x - chartPointDiameter/2.0, position.y - chartPointDiameter/2.0, chartPointDiameter, chartPointDiameter);
    CGRect rectInside = CGRectMake(rect.origin.x + hcLineChartView.chartLineWidth, rect.origin.y + hcLineChartView.chartLineWidth, chartPointDiameter - 2.0 * hcLineChartView.chartLineWidth, chartPointDiameter - 2.0 * hcLineChartView.chartLineWidth);
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect:rectInside];
    return circlePath;
}
    
/// This method is used for drawing circle at specific position
/// @param position Position for drawing the border around the circle which represents chart point
-(void)drawChartPointAtPositionOutside:(CGPoint)position
{
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    CGRect bounds = [hcLineChartView bounds];
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    CGContextSaveGState(ctx);
    CGContextSetLineWidth(ctx,hcLineChartView.chartLineWidth);
    NSArray<NSNumber*>* components = [self colorComponents:hcLineChartView.chartLineColor];
    CGFloat red = [components objectAtIndex:0].floatValue;
    CGFloat green = [components objectAtIndex:1].floatValue;
    CGFloat blue = [components objectAtIndex:2].floatValue;
    CGFloat alpha = [components objectAtIndex:3].floatValue;
    CGContextSetRGBStrokeColor(ctx,red,green,blue,alpha);
    CGContextAddArc(ctx,position.x,position.y, (chartPointDiameter - hcLineChartView.chartLineWidth) / 2.0 ,0.0,M_PI*2,YES);
    CGContextStrokePath(ctx);
}
    
    
#pragma mark Draw gradient under chart line
    
/// This method draws gradient under the chart line
-(void)drawGradientUnderChartLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    NSArray *colors = @[(__bridge id) hcLineChartView.underLineChartGradientTopColor.CGColor, (__bridge id) (hcLineChartView.underLineChartGradientBottomColorIsTransparent ? (hcLineChartView.chartGradient ? [self bottomColorForUnderLineAreaFromGradient] : hcLineChartView.backgroundGradientTopColor) : hcLineChartView.underLineChartGradientBottomColor).CGColor];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    int numberOfPoints = 0;
    if (chartStyle == chartLineWithCircles)
    {
        while (numberOfPoints < numberOfElements - 1) {
            CGPoint startPoint = [[startDots objectAtIndex:numberOfPoints] CGPointValue];
            CGPoint endPoint = [[endDots objectAtIndex:numberOfPoints] CGPointValue];
            if (numberOfPoints == 0)
            {
                [aPath moveToPoint:CGPointMake(startPoint.x-1, startPoint.y)];
                [aPath addLineToPoint:startPoint];
            }
            if (numberOfPoints > 0)
            {
                [aPath addLineToPoint:startPoint];
            }
            if (numberOfPoints < numberOfElements - 2)
            {
                [aPath addLineToPoint:endPoint];
            }
            else
            {
                HCChartPoint* chartPoint = (HCChartPoint*)[chartDots lastObject];
                [aPath addLineToPoint:CGPointMake(chartPoint.x, chartPoint.y)];
                [aPath addLineToPoint:CGPointMake(chartPoint.x+1, chartPoint.y)];
            }
            numberOfPoints++;
        }
    }
    else
    {
        for (NSValue* middlePointValue in middleDots)
        {
            CGPoint middlePoint = [middlePointValue CGPointValue];
            if (numberOfPoints == 0)
            {
                [aPath moveToPoint:CGPointMake(middlePoint.x-1, middlePoint.y)];
                [aPath addLineToPoint:middlePoint];
            }
            if (numberOfPoints > 0)
            {
                [aPath addLineToPoint:middlePoint];
                if (numberOfPoints == numberOfElements - 1)
                {
                    [aPath addLineToPoint:CGPointMake(middlePoint.x+1, middlePoint.y)];
                }
            }
            numberOfPoints++;
        }
    }
    CGPoint bottomLeftPoint = CGPointMake(minXCoordinateOnChart - 1, chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight));
    CGPoint topLeftPoint = [middleDots.firstObject CGPointValue];
    topLeftPoint.x -= 1;
    CGPoint rightPoint = CGPointMake(maxXCoordinateOnChart + 1, chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight));
    [aPath addLineToPoint:rightPoint];
    [aPath addLineToPoint:bottomLeftPoint];
    [aPath addLineToPoint:topLeftPoint];
    [aPath closePath];
    if (chartStyle == chartLineWithCircles)
    {
        for (int i=0 ; i < numberOfElements ; i++)
        {
            HCChartPoint* HCChartPointt = (HCChartPoint*)[chartDots objectAtIndex:i];
            [aPath appendPath:[self drawChartPointAtPositionInside:CGPointMake(HCChartPointt.x, HCChartPointt.y)]];
        }
    }
    CGPoint startPoint = CGPointMake(CGRectGetMidX(chartRect), minYCoordinateOnChart - chartPointDiameter/2.0);
    CGPoint endPoint = CGPointMake(CGRectGetMidX(chartRect), MAX(bottomLeftPoint.y,maxYCoordinateOnChart + chartPointDiameter/2.0 - hcLineChartView.chartLineWidth));
    [aPath fill];
    [aPath addClip];
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
}
    
/// This method is responsible for hiding gradient borders below chart line. It draws two gradient rects to hide unnecessary parts of gradient border
-(void)hideGradientBorders
{
    if (numberOfElements > 1)
    {
        CGPoint last = [[middleDots lastObject] CGPointValue];
        CGPoint first = [[middleDots firstObject] CGPointValue];
        
        NSArray<NSNumber*>* topComponentsFirst = [self colorComponents:chartStyle == chartLineWithCircles ? [self getGradientColorWithPercentage:(first.y + chartPointDiameter * 0.5) / chartRect.size.height forGradientColor1:hcLineChartView.backgroundGradientTopColor andGradientColor2:hcLineChartView.backgroundGradientBottomColor] : [self getGradientColorWithPercentage:first.y / chartRect.size.height forGradientColor1:hcLineChartView.backgroundGradientTopColor andGradientColor2:hcLineChartView.backgroundGradientBottomColor]];
        
        NSArray<NSNumber*>* topComponentsLast = [self colorComponents:chartStyle == chartLineWithCircles ? [self getGradientColorWithPercentage:(last.y + chartPointDiameter * 0.5) / chartRect.size.height forGradientColor1:hcLineChartView.backgroundGradientTopColor andGradientColor2:hcLineChartView.backgroundGradientBottomColor] : [self getGradientColorWithPercentage:last.y / chartRect.size.height forGradientColor1:hcLineChartView.backgroundGradientTopColor andGradientColor2:hcLineChartView.backgroundGradientBottomColor]];
        
        NSArray<NSNumber*>* bottomComponents = [self colorComponents:[self bottomColorForUnderLineAreaFromGradient]];
        
        CGFloat colorsFirst [] = {
            [topComponentsFirst objectAtIndex:0].floatValue, [topComponentsFirst objectAtIndex:1].floatValue, [topComponentsFirst objectAtIndex:2].floatValue, [topComponentsFirst objectAtIndex:3].floatValue ,
            [bottomComponents objectAtIndex:0].floatValue, [bottomComponents objectAtIndex:1].floatValue, [bottomComponents objectAtIndex:2].floatValue, [bottomComponents objectAtIndex:3].floatValue
        };
        
        CGFloat colorsLast [] = {
            [topComponentsLast objectAtIndex:0].floatValue, [topComponentsLast objectAtIndex:1].floatValue, [topComponentsLast objectAtIndex:2].floatValue, [topComponentsLast objectAtIndex:3].floatValue ,
            [bottomComponents objectAtIndex:0].floatValue, [bottomComponents objectAtIndex:1].floatValue, [bottomComponents objectAtIndex:2].floatValue, [bottomComponents objectAtIndex:3].floatValue
        };
        
        CGRect rectLast = CGRectMake(last.x, chartStyle == chartLineWithCircles ? last.y + chartPointDiameter * 0.5 : last.y, 2, chartStyle == chartLineWithCircles ? chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight) - last.y - chartPointDiameter * 0.5 : chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight) - last.y);
        CGRect rectFirst = CGRectMake(first.x - 2, chartStyle == chartLineWithCircles ? first.y + chartPointDiameter * 0.5 : first.y, 2, chartStyle == chartLineWithCircles ? chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight) - first.y - chartPointDiameter * 0.5 : chartRect.size.height * (pointsRectTopProportionalDistance + pointsRectProportionalHeight) - first.y);
        
        if (hcLineChartView.chartGradient)
        {
            [self drawRect:rectFirst withColors:colorsFirst];
            [self drawRect:rectLast withColors:colorsLast];
        }
        else
        {
            [self drawRect:rectFirst withBackgroundColor:hcLineChartView.backgroundGradientTopColor];
            [self drawRect:rectLast withBackgroundColor:hcLineChartView.backgroundGradientTopColor];
        }
    }
}
    
/// This method generates color components array from the given color. This method is used as a helper method for other methods, primarly for drawing gradient
/// @param color Given color for which we need to calculate color components
/// @return Color components array
-(NSArray<NSNumber *>*)colorComponents:(UIColor*)color
{
    int numColorComponents = (int)CGColorGetNumberOfComponents(color.CGColor);
    const CGFloat* colorComponents = CGColorGetComponents(color.CGColor);
    CGFloat components[4];
    if (numColorComponents == 2)
    {
        components[0] = 1.0 * colorComponents[0];
        components[1] = 1.0 * colorComponents[0];
        components[2] = 1.0 * colorComponents[0];
        components[3] = 1.0 * colorComponents[1];
    }
    else
    {
        components[0] = 1.0 * colorComponents[0];
        components[1] = 1.0 * colorComponents[1];
        components[2] = 1.0 * colorComponents[2];
        components[3] = numColorComponents == 4 ? (1.0 * colorComponents[3]) : 1.0;
    }
    return [NSArray arrayWithObjects:@(components[0]),@(components[1]),@(components[2]),@(components[3]), nil];
}
    
/// This method calculates and returns bottom color for gradient area under chart line if you want to make a transparency effect for bottom color for gradient (i.e., if underLineChartGradientBottomColorIsTransparent parameter in HCLineChartView is set to YES)
/// @return Bottom color for the gradient under chart line which simulates transparency effect
-(UIColor*)bottomColorForUnderLineAreaFromGradient
{
    double percentage = pointsRectTopProportionalDistance + pointsRectProportionalHeight;
    return [self getGradientColorWithPercentage:percentage forGradientColor1:hcLineChartView.backgroundGradientTopColor andGradientColor2:hcLineChartView.backgroundGradientBottomColor];
}
    
/// Helper method which returns the color from the gradient, based on the given percentage parameter and gradient colors
/// @param percentage The relative position between start and end of the gradient
/// @param gradientColor1 First color in gradient
/// @param gradientColor2 Last collor in gradient
-(UIColor*)getGradientColorWithPercentage:(double)percentage forGradientColor1:(UIColor*)gradientColor1 andGradientColor2:(UIColor*)gradientColor2
{
    NSArray<NSNumber*>* components1 = [self colorComponents:gradientColor1];
    
    NSArray<NSNumber*>* components2 = [self colorComponents:gradientColor2];
    
    float redComponent = [components1 objectAtIndex:0].floatValue + percentage * ([components2 objectAtIndex:0].floatValue - [components1 objectAtIndex:0].floatValue);
    float greenComponent = [components1 objectAtIndex:1].floatValue + percentage * ([components2 objectAtIndex:1].floatValue - [components1 objectAtIndex:1].floatValue);
    float blueComponent =  [components1 objectAtIndex:2].floatValue + percentage * ([components2 objectAtIndex:2].floatValue - [components1 objectAtIndex:2].floatValue);
    float alphaComponent =  [components1 objectAtIndex:3].floatValue + percentage * ([components2 objectAtIndex:3].floatValue - [components1 objectAtIndex:3].floatValue);
    return [UIColor colorWithRed:MIN(1,redComponent) green:MIN(1,greenComponent) blue:MIN(1,blueComponent) alpha:alphaComponent];
}

@end

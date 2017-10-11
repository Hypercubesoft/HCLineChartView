//
//  HCChartDrawer+Helper.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer+General.h"

@implementation HCChartDrawer (General)

#pragma mark Draw line methods

-(void)drawLineFromPoint:(CGPoint)startPoint toPoint: (CGPoint) endPoint withColor:(UIColor*)lineColor andWidth:(double)lineWidth
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y );
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y );
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

-(void)drawDashedLineFromPoint:(CGPoint)startPoint toEndPoint:(CGPoint)endPoint
{
    [hcLineChartView.chartAxisColor setStroke];
    UIBezierPath * path = [[UIBezierPath alloc] init];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    CGFloat dashes[] = {1, 2};
    [path setLineDash:dashes count:2 phase:0];
    [path stroke];
}

#pragma mark Draw rect methods

-(void)drawRect:(CGRect)rect withBackgroundColor:(UIColor*)backgroundColor
{
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rect];
    [backgroundColor setFill];
    [rectanglePath fill];
}

-(void)drawRect:(CGRect)rect withColors:(CGFloat*)colors
{
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    (void)(CGColorSpaceRelease(baseSpace)), baseSpace = NULL;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0);
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    (void)(CGGradientRelease(gradient)), gradient = NULL;
    
    CGContextRestoreGState(context);
    
    CGContextAddRect(context, rect);
    CGContextDrawPath(context, kCGPathStroke);
}

#pragma mark Font attributes generator

-(NSDictionary*)fontAttributesWithFont: (UIFont*)font fontColor:(UIColor*)fontColor textAlignment:(NSTextAlignment)textAlignment andLineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *myStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    myStyle.lineBreakMode = lineBreakMode;
    myStyle.alignment = textAlignment;
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: myStyle ,
                                  NSForegroundColorAttributeName: fontColor};
    return attributes;
}

@end

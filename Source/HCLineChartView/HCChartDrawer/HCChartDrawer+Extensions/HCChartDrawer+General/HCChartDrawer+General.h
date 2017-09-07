//
//  HCChartDrawer+Helper.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer.h"

@interface HCChartDrawer (General)

/// This method draws line from startPoint to endPoint with specified lineColor and lineWidth
/// @param startPoint Start point for drawing the line.
/// @param endPoint End point for drawing the line.
/// @param lineColor Line color.
/// @param lineWidth Line width.
-(void)drawLineFromPoint:(CGPoint)startPoint toPoint: (CGPoint) endPoint withColor:(UIColor*)lineColor andWidth:(double)lineWidth;


/// This method creates dashed line accross the chart (for example, when Y value is 0)
/// @param startPoint Start point for drawing the line.
/// @param endPoint End point for drawing the line.
-(void)drawDashedLineFromPoint:(CGPoint)startPoint toEndPoint:(CGPoint)endPoint;


/// This method draws rect with given background color
/// @param rect This property defines rect, i.e. position and size for desired rect.
/// @param backgroundColor This property defines background color for desired rect.
-(void)drawRect:(CGRect)rect withBackgroundColor:(UIColor*)backgroundColor;

/// Helper method for drawing rect with gradient
/// @param rect Given rect for drawing
/// @param colors Array of colors which make gradient
-(void)drawRect:(CGRect)rect withColors:(CGFloat*)colors;

/// This method generates attributes dictionary for desired font and some other settings
/// @param font This property defines font for desired text.
/// @param fontColor This property defines font color for desired text.
/// @param textAlignment This property defines text alignment for desired text.
/// @param lineBreakMode This property defines line break mode for desired text.
/// @return Generated font attributes for defined parameters
-(NSDictionary*)fontAttributesWithFont: (UIFont*)font fontColor:(UIColor*)fontColor textAlignment:(NSTextAlignment)textAlignment andLineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

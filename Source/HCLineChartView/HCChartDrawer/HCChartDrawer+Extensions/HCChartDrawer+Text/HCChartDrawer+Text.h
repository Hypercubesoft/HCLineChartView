//
//  HCChartDrawer+Text.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer.h"

@interface HCChartDrawer (Text)

/// This method calculates text size based on given fontSize
/// @param text Text for which we need to calculate size
/// @param fontSize Font size for given text
/// @return Size of given text with given font size
- (CGSize)sizeOfText:(NSString *)text withFontSize:(double)fontSize;

/// This method generates string for given timestamp (dateWithTimeIntervalSince1970 value)
/// @param timestamp Timestamp which should be converted to Date and represented as text (NSString)
/// @return Generated string for given timestamp
- (NSString*)timeStringForValue:(double)timestamp;

/// This method generates string for given date and given format
/// @param date NSDate instance which should be converted to NSString
/// @param dateFormat Date format for presenting given NSDate instance as NSString.
/// @return Generated string for given NSDate instance
- (NSString*)timeStringForDate:(NSDate*)date withFormat:(NSString*)dateFormat;

/// This method draws text with predefined position and size (rect), attributes, offset and orientation (vertical or horizontal)
/// @param text Text to be drawn
/// @param rect Rect, i.e. position and size for drawing the text
/// @param attributes Text attributes (font, text color, alignment,...) for drawing the text
/// @param offset Position offset for drawing the text (used during drawing successive values on axis)
/// @param isVertical Boolean value which defines if text should be drawn as horizontal or vertical
- (void)drawText:(NSString*)text withRect:(CGRect)rect withAtributes:(NSDictionary*)attributes withOffset:(CGPoint)offset isVertical:(BOOL)isVertical;

/// Returns number as a currency string
/// @param value number which should be converted to string
/// @param numberOfDecimalPlaces Number of decimal places for currency string
/// @param currencyCode Currency code for value which shoud be presented as currency. If this parameter is not set, i.e., it is NULL, currency formatter will use local currency
/// @return Numerical value converted to string
-(NSString*)currencyStringForValue:(double)value numberOfDecimalPlaces:(int)numberOfDecimalPlaces currencyCode:(NSString*)currencyCode;

@end

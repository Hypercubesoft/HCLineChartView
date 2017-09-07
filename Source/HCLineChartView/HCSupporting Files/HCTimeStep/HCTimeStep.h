//
//  TimeStep.h
//  HCLineChartView
//
//  Created by Vladimir Dinic on 7/18/17.
//  Copyright © 2017 Hypercube 2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCChartDrawer.h"

/// Helper class for storing some information about tick size for date/time values if values on X axis are represented as date/time
@interface HCTimeStep : NSObject

/// This property defines time step, i.e. tick size in seconds.
/// For example, if time step is 3 hours, then multiplier is 3 * 60 * 60 = 10800
@property double multiplier;

/// This property defines number of basic time units which define a time step.
/// For example, if time step is 3 months, then multiplier is 3
@property int value;

/// This property defines time format, for example DD/MM/YYYY
@property (retain, nonatomic) NSString* timeFormat;

/// Boolean value which defines if alternative time format should be used. It is calculated runtime
@property BOOL useAlternativeTimeFormat;

/// This property defines alternative time format, for example DD/MM/YYYY HH:mm:ss. It is used in cases where we aren't sure which time format is best solution for given dates range and number of values. It is calculated runtime
@property (retain, nonatomic) NSString* alternativeTimeFormat;

/// This property defines calendar type, i.e. time unit. In other words, it defines if tick on X axis is represented in seconds, days, months, years,...
@property HCCalendarType calendarType;

/// This property defines referent, i.e. minimal range for using alternative time format. It is only valid if alternativeTimeFormat isn't nil.
@property int referentRangeForAlternativeText;

/// Creates and returns NSDateComponents instance required for calculation tick size and drawing values for X axis
/// @return NSDateComponents instance required for calculation tick size and drawing values for X axis
-(NSDateComponents*)dateComponent;

/// Constructor for HCTimeStep class.
/// @param multiplier Number of basic time units which define a time step
/// @param calendarType Calendar type, i.e. time unit
/// @param value Number of basic time units which define a time step
/// @return Class instance generated with given parameters
-(id)initWithTimeFormat:(NSString*)timeFormat withMultiplier:(double)multiplier calendarType:(HCCalendarType)calendarType value:(int)value;

/// Constructor for HCTimeStep class.
/// @param timeFormat Time format, for example DD/MM/YYYY
/// @param alternativeTimeFormat Alternative time format, for example DD/MM/YYYY HH:mm:ss
/// @param multiplier Number of basic time units which define a time step
/// @param calendarType Calendar type, i.e. time unit
/// @param value Number of basic time units which define a time step
/// @param referentRangeForAlternativeText Numerical value which indicates minimal range for using alternative time format
/// @return Class instance generated with given parameters
-(id)initWithTimeFormat:(NSString*)timeFormat alternativeTimeFormat:(NSString*)alternativeTimeFormat withMultiplier:(double)multiplier calendarType:(HCCalendarType)calendarType value:(int)value referentRangeForAlternativeText:(int)referentRangeForAlternativeText;


@end

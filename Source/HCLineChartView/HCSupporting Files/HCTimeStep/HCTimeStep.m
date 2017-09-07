//
//  TimeStep.m
//  HCLineChartView
//
//  Created by Vladimir Dinic on 7/18/17.
//  Copyright © 2017 Hypercube 2. All rights reserved.
//

#import "HCTimeStep.h"

@implementation HCTimeStep

-(id)initWithTimeFormat:(NSString *)timeFormat withMultiplier:(double)multiplier calendarType:(HCCalendarType)calendarType value:(int)value
{
    if (self = [super init])
    {
        self.timeFormat = timeFormat;
        self.multiplier = multiplier;
        self.calendarType = calendarType;
        self.value = value;
    }
    return self;
}

-(id)initWithTimeFormat:(NSString*)timeFormat alternativeTimeFormat:(NSString*)alternativeTimeFormat withMultiplier:(double)multiplier calendarType:(HCCalendarType)calendarType value:(int)value referentRangeForAlternativeText:(int)referentRangeForAlternativeText
{
    if (self = [super init])
    {
        self.timeFormat = timeFormat;
        self.alternativeTimeFormat = alternativeTimeFormat;
        self.multiplier = multiplier;
        self.calendarType = calendarType;
        self.value = value;
        self.referentRangeForAlternativeText = referentRangeForAlternativeText;
    }
    return self;
}

-(NSDateComponents*)dateComponent
{
    switch (self.calendarType)
    {
        case calendarWithSeconds:
        {
            NSDateComponents* seconds = [NSDateComponents new];
            [seconds setSecond:self.value];
            return seconds;
        }
        case calendarWithMinutes:
        {
            NSDateComponents* minutes = [NSDateComponents new];
            [minutes setMinute:self.value];
            return minutes;
        }
        case calendarWithHours:
        {
            NSDateComponents* hours = [NSDateComponents new];
            [hours setHour:self.value];
            return hours;
        }
        case calendarWithDays:
        {
            NSDateComponents* days = [NSDateComponents new];
            [days setDay:self.value];
            return days;
        }
        case calendarWithWeeks:
        {
            NSDateComponents* weeks = [NSDateComponents new];
            [weeks setDay:self.value*7];
            return weeks;
        }
        case calendarWithMonths:
        {
            NSDateComponents* months = [NSDateComponents new];
            [months setMonth:self.value];
            return months;
        }
        case calendarWithYears:
        {
            NSDateComponents* years = [NSDateComponents new];
            [years setYear:self.value];
            return years;
        }
        default:
            break;
    }
    return nil;
}


@end

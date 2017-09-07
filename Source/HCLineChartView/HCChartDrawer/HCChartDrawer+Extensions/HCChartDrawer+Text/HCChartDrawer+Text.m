//
//  HCChartDrawer+Text.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer+Text.h"
#import "HCTimeStep.h"

@implementation HCChartDrawer (Text)

#pragma mark Draw text

-(void)drawText:(NSString*)text withRect:(CGRect)rect withAtributes:(NSDictionary*)attributes withOffset:(CGPoint)offset isVertical:(BOOL)isVertical
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextTranslateCTM(context, offset.x, offsetForAxisOrHeader + offset.y);
    
    if (isVertical)
    {
        CGContextTranslateCTM(context, rect.origin.x + rect.size.width * 0.5 + rect.size.height * 0.5, rect.origin.y);
        CGContextRotateCTM(context, M_PI_2);
        rect.origin = CGPointZero;
        [text drawInRect:rect withAttributes:attributes];
    }
    else
    {
        [text drawInRect:rect withAttributes:attributes];
    }
    
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
}

#pragma mark Text size calculation

- (CGSize)sizeOfText:(NSString *)text withFontSize:(double)fontSize {
    
    double descriptionMaxHeight = fontSize;
    CGSize maximumLabelSize = CGSizeMake(CGFLOAT_MAX, descriptionMaxHeight);
    CGRect textRect = [text boundingRectWithSize:maximumLabelSize
                                         options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}
                                         context:nil];
    CGSize textSize = textRect.size;
    textSize.width += 2.0;
    return textSize;
}

-(CGSize)sizeForLabel:(NSString*)text font:(UIFont*)font width:(CGFloat)width lineNumber:(int)lineNumber
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
    label.numberOfLines = lineNumber;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = font;
    label.text = text;
    [label sizeToFit];
    return label.frame.size;
}

#pragma mark Text generator

-(NSString*)currencyStringForValue:(double)value numberOfDecimalPlaces:(int)numberOfDecimalPlaces currencyCode:(NSString*)currencyCode
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:numberOfDecimalPlaces];
    [numberFormatter setMinimumFractionDigits:numberOfDecimalPlaces];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    if (currencyCode)
    {
        BOOL currencyCodeIsValid = NO;
        for (NSString* local in [NSLocale availableLocaleIdentifiers])
        {
            NSLocale* locale = [[NSLocale alloc] initWithLocaleIdentifier:local];
            NSString* localeCurrencyCode = [locale objectForKey:NSLocaleCurrencyCode];
            if ([localeCurrencyCode isEqualToString:currencyCode])
            {
                currencyCodeIsValid = YES;
                break;
            }
        }
        if (currencyCodeIsValid)
        {
            [numberFormatter setCurrencyCode:currencyCode];
        }
    }
    NSString *numberAsCurrency = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:value]];
    return numberAsCurrency;
}

-(NSString*)timeStringForValue:(double)timestamp
{
    return [self timeStringForDate:[NSDate dateWithTimeIntervalSince1970:timestamp] withFormat:xAxisDateTick.useAlternativeTimeFormat ? (xAxisDateTick.alternativeTimeFormat ? xAxisDateTick.alternativeTimeFormat : [timeSteps firstObject].timeFormat) : xAxisDateTick.timeFormat ? xAxisDateTick.timeFormat : [timeSteps firstObject].timeFormat];
}

-(NSString*)timeStringForDate:(NSDate*)date withFormat:(NSString*)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString* xAxisString = [formatter stringFromDate:date];
    return xAxisString;
}

@end

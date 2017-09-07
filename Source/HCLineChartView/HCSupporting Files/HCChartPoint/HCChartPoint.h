//
//  HCChartPoint.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Helper class for storing single chart point / dot
@interface HCChartPoint : NSObject

/// This property defines X coordinate for chart point
@property double x;

/// This property defines Y coordinate for chart point
@property double y;

/// Contructor
/// @param x X coordinate for chart point
/// @param y Y coordinate for chart point
/// @return Class insntance
-(id)initWithX:(double)x andY:(double)y;

@end

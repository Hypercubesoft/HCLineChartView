//
//  HCChartDrawer+Axis.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartDrawer.h"

@interface HCChartDrawer (Axis)

/// This method is used for preparation and drawing X and Y axis
-(void)drawBothAxises;

/// This method draws horizontal lines for Y ticks
-(void)drawHorizontalLinesForYTicks;


@end

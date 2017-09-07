//
//  HCChartPoint.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartPoint.h"

@implementation HCChartPoint

-(id)initWithX:(double)x andY:(double)y
{
    self = [super init];
    self.x = x;
    self.y = y;
    return self;
}

@end

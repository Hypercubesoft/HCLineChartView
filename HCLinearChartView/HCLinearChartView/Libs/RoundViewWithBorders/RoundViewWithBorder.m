//
//  ViewWithBorder.m
//  PromotionalFinance
//
//  Created by Lazar Djordjevic on 8/31/15.
//  Copyright (c) 2015 Lazar Djordjevic. All rights reserved.
//

#import "RoundViewWithBorder.h"


@implementation RoundViewWithBorder


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.thickness = 1.0f;
        self.borderIBColor = [UIColor blackColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.thickness = 1.05f;
        self.borderIBColor = [UIColor blackColor];
        [self performSelector:@selector(drawBorder) withObject:nil afterDelay:0.0];
    }
    return self;
}

- (void)drawBorder
{
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = self.borderIBColor.CGColor;
    self.layer.borderWidth = self.thickness;
}

@end

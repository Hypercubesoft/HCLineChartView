//
//  ViewWithBorder.h
//  PromotionalFinance
//
//  Created by Lazar Djordjevic on 8/31/15.
//  Copyright (c) 2015 Lazar Djordjevic. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface RoundViewWithBorder : UIView

@property (nonatomic) IBInspectable UIColor* borderIBColor;
@property IBInspectable float thickness;
@property IBInspectable float cornerRadius;
@property CALayer* leftLayer;
@property CALayer* topLayer;
@property CALayer* bottomLayer;
@property CALayer* rightLayer;

- (void)drawBorder;

@end


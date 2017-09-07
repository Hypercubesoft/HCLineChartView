//
//  SettingsSliderCell.m
//  HCLinearChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "SettingsSliderCell.h"

@implementation SettingsSliderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithLabelString:(NSString*)labelString value:(double)value maxValue:(double)maxValue minValue:(double)minValue andHandler:(HCChartSettingsValueHandler)handler
{
    [self.cellLabel setText:labelString];
    [self.cellSlider setMinimumValue:minValue];
    [self.cellSlider setMaximumValue:maxValue];
    [self.cellSlider setValue:value];
    self.handler = handler;
}

- (IBAction)sliderValueChanged:(id)sender {
    self.handler(self.cellSlider.value);
}


@end

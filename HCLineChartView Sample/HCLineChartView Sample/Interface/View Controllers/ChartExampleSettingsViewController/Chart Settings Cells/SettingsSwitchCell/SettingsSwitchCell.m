//
//  SettingsSwitchCell.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "SettingsSwitchCell.h"

@implementation SettingsSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithLabelString:(NSString*)labelString isOn:(BOOL)isOn andHandler:(HCChartSettingsBoolHandler)handler
{
    [self.cellLabel setText:labelString];
    [self.cellSwitch setOn:isOn];
    self.handler = handler;
}

- (IBAction)changeSwitch:(id)sender
{
    self.handler(self.cellSwitch.isOn);
}

@end

//
//  SettingsSwitchCell.h
//  HCLinearChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HCChartSettingsBoolHandler) (BOOL isOn);

@interface SettingsSwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;
@property HCChartSettingsBoolHandler handler;

- (IBAction)changeSwitch:(id)sender;
-(void)updateWithLabelString:(NSString*)labelString isOn:(BOOL)isOn andHandler:(HCChartSettingsBoolHandler)handler;

@end

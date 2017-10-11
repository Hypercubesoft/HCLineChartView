//
//  SettingsSliderCell.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HCChartSettingsValueHandler) (double value);

@interface SettingsSliderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UISlider *cellSlider;
@property HCChartSettingsValueHandler handler;

- (IBAction)sliderValueChanged:(id)sender;
-(void)updateWithLabelString:(NSString*)labelString value:(double)value maxValue:(double)maxValue minValue:(double)minValue andHandler:(HCChartSettingsValueHandler)handler;


@end

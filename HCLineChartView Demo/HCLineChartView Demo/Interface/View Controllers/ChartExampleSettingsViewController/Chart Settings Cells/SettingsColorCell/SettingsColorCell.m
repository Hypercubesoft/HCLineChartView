//
//  SettingsColorCell.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "SettingsColorCell.h"

@implementation SettingsColorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)updateWithLabelString:(NSString*)labelString color:(UIColor*)color andHandler:(HCChartSettingsColorHandler)handler
{
    [self.cellLabel setText:labelString];
    [self.cellColorView setBackgroundColor:color];
    self.handler = handler;
}

- (IBAction)cellChangeColor:(id)sender {
    FCColorPickerViewController *colorPicker = [FCColorPickerViewController colorPicker];
    colorPicker.color = self.cellColorView.backgroundColor;
    colorPicker.delegate = self;
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:colorPicker animated:YES completion:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark FCColorPickerViewControllerDelegate methods

-(void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker
{
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color
{
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.cellColorView setBackgroundColor:color];
    self.handler(color);
}


@end

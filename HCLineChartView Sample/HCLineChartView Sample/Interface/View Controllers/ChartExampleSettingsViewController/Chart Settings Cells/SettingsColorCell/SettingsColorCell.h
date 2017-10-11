//
//  SettingsColorCell.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCColorPickerViewController.h"

typedef void (^HCChartSettingsColorHandler) (UIColor* color);

@interface SettingsColorCell : UITableViewCell <FCColorPickerViewControllerDelegate>

@property HCChartSettingsColorHandler handler;
@property (weak, nonatomic) IBOutlet UIView *cellColorView;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

- (IBAction)cellChangeColor:(id)sender;
-(void)updateWithLabelString:(NSString*)labelString color:(UIColor*)color andHandler:(HCChartSettingsColorHandler)handler;


@end

//
//  SettingsCell.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HCChartSettingsTextHandler) (NSString* text);

@interface SettingsTextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UITextField *cellTextField;
@property HCChartSettingsTextHandler handler;

-(void)updateWithLabelString:(NSString*)labelString textFieldPlaceholder:(NSString*)textFieldPlaceholder textFieldString:(NSString*)textFieldString andHandler:(HCChartSettingsTextHandler)handler;

@end

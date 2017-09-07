//
//  SettingsCell.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "SettingsTextCell.h"

@implementation SettingsTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithLabelString:(NSString*)labelString textFieldPlaceholder:(NSString*)textFieldPlaceholder textFieldString:(NSString*)textFieldString andHandler:(HCChartSettingsTextHandler)handler;
{
    [self.cellLabel setText:labelString];
    [self.cellTextField setPlaceholder:textFieldPlaceholder];
    [self.cellTextField setText:textFieldString];
    self.handler = handler;
    [self.cellTextField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldDidChange:(UITextField*)textField
{
    self.handler(textField.text);
}

@end

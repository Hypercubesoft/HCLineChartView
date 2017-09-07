//
//  ChartExampleSettingsViewController.h
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCChartSettings.h"

@interface ChartExampleSettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) HCChartSettings* localChartSettings;

@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;

@end

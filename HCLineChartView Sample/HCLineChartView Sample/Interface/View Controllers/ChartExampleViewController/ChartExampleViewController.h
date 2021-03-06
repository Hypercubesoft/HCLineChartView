//
//  ViewController.h
//  MyChart
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCLineChartView.h"
#import "HCChartSettings.h"

@interface ChartExampleViewController : UIViewController

@property (strong, nonatomic) IBOutlet HCLineChartView *hcLineChartView;

- (IBAction)generateRandomChartDataWithDatesOnXAxis:(id)sender;
- (IBAction)generateRandomChartDataWithNumbersOnXAxis:(id)sender;

- (IBAction)generateRandomChartSettings:(id)sender;
- (IBAction)changeChartSettings:(id)sender;

@end


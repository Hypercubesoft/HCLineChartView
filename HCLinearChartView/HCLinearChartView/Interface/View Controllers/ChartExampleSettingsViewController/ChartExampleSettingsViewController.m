//
//  ChartExampleSettingsViewController.m
//  HCLinearChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "ChartExampleSettingsViewController.h"
#import "SettingsTextCell.h"
#import "SettingsColorCell.h"
#import "SettingsSliderCell.h"
#import "SettingsSwitchCell.h"

@implementation ChartExampleSettingsViewController

#pragma mark Basic ChartExampleSettingsViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.localChartSettings = [[HCChartSettings sharedInstance] copy];
    [self registerSettingsCells];
    [self setupNavigationBar];
}

-(void)registerSettingsCells
{
    [self.settingsTableView registerNib:[UINib nibWithNibName:@"SettingsTextCell" bundle:NULL] forCellReuseIdentifier:@"SettingsTextCell"];
    [self.settingsTableView registerNib:[UINib nibWithNibName:@"SettingsColorCell" bundle:NULL] forCellReuseIdentifier:@"SettingsColorCell"];
    [self.settingsTableView registerNib:[UINib nibWithNibName:@"SettingsSliderCell" bundle:NULL] forCellReuseIdentifier:@"SettingsSliderCell"];
    [self.settingsTableView registerNib:[UINib nibWithNibName:@"SettingsSwitchCell" bundle:NULL] forCellReuseIdentifier:@"SettingsSwitchCell"];
}

-(void)setupNavigationBar
{
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"Settings"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Cancel"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = backButton;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(done)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
    
-(void)done
{
    [[HCChartSettings sharedInstance] updateWithSettings:self.localChartSettings];
    [self goBack];
}

#pragma mark UITextField delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark TableView Delegate and DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 7;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 8;
            break;
        case 3:
            return 8;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row)
            {
                case 0:
                {
                    SettingsTextCell* cell = (SettingsTextCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsTextCell"];
                    [cell updateWithLabelString:@"Chart title" textFieldPlaceholder:@"Chart title" textFieldString:self.localChartSettings.chartTitle andHandler:^(NSString *text) {
                        self.localChartSettings.chartTitle = text;
                    }];
                    return cell;
                    break;
                }
                case 1:
                {
                    SettingsSliderCell* cell = (SettingsSliderCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSliderCell"];
                    [cell updateWithLabelString:@"Chart title font size" value:self.localChartSettings.fontSizeForTitle maxValue:25 minValue:18 andHandler:^(double value) {
                        self.localChartSettings.fontSizeForTitle = value;
                    }];
                    return cell;
                    break;
                }
                case 2:
                {
                    SettingsColorCell* cell = (SettingsColorCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsColorCell"];
                    [cell updateWithLabelString:@"Chart title color" color:self.localChartSettings.chartTitleColor andHandler:^(UIColor *color) {
                        [self.localChartSettings setChartTitleColor:color];
                    }];
                    return cell;
                    break;
                }
                case 3:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Show subtitle" isOn:self.localChartSettings.showSubtitle andHandler:^(BOOL isOn) {
                        self.localChartSettings.showSubtitle = isOn;
                    }];
                    return cell;
                    break;
                }
                case 4:
                {
                    SettingsTextCell* cell = (SettingsTextCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsTextCell"];
                    [cell updateWithLabelString:@"Chart subtitle" textFieldPlaceholder:@"Chart subtitle" textFieldString:self.localChartSettings.chartSubTitle andHandler:^(NSString *text) {
                        self.localChartSettings.chartSubTitle = text;
                    }];
                    return cell;
                    break;
                }
                case 5:
                {
                    SettingsSliderCell* cell = (SettingsSliderCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSliderCell"];
                    [cell updateWithLabelString:@"Chart subtitle font size" value:self.localChartSettings.fontSizeForSubTitle maxValue:17 minValue:12 andHandler:^(double value) {
                        self.localChartSettings.fontSizeForSubTitle = value;
                    }];
                    return cell;
                    break;
                }
                case 6:
                {
                    SettingsColorCell* cell = (SettingsColorCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsColorCell"];
                    [cell updateWithLabelString:@"Chart subtitle color" color:self.localChartSettings.chartSubtitleColor andHandler:^(UIColor *color) {
                        [self.localChartSettings setChartSubtitleColor:color];
                    }];
                    return cell;
                    break;
                }
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row)
            {
                case 0:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Transparent background" isOn:self.localChartSettings.chartTransparentBackground andHandler:^(BOOL isOn) {
                        self.localChartSettings.chartTransparentBackground = isOn;
                    }];
                    return cell;
                    break;
                }
                case 1:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Background with gradient" isOn:self.localChartSettings.chartGradient andHandler:^(BOOL isOn) {
                        self.localChartSettings.chartGradient = isOn;
                    }];
                    return cell;
                    break;
                }
                case 2:
                {
                    SettingsColorCell* cell = (SettingsColorCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsColorCell"];
                    [cell updateWithLabelString:@"Background color (Top gradient color)" color:self.localChartSettings.backgroundGradientTopColor andHandler:^(UIColor *color) {
                        [self.localChartSettings setBackgroundGradientTopColor:color];
                    }];
                    return cell;
                    break;
                }
                case 3:
                {
                    SettingsColorCell* cell = (SettingsColorCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsColorCell"];
                    [cell updateWithLabelString:@"Background bottom gradient color" color:self.localChartSettings.backgroundGradientBottomColor andHandler:^(UIColor *color) {
                        [self.localChartSettings setBackgroundGradientBottomColor:color];
                    }];
                    return cell;
                    break;
                }
                case 4:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Chart view with rounded corners" isOn:self.localChartSettings.chartWithRoundedCorners andHandler:^(BOOL isOn) {
                        self.localChartSettings.chartWithRoundedCorners = isOn;
                    }];
                    return cell;
                    break;
                }
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row)
            {
                case 0:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Horizontal labels on X axis" isOn:self.localChartSettings.horizontalValuesOnXAxis andHandler:^(BOOL isOn) {
                        self.localChartSettings.horizontalValuesOnXAxis = isOn;
                    }];
                    return cell;
                    break;
                }
                case 1:
                {
                    SettingsColorCell* cell = (SettingsColorCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsColorCell"];
                    [cell updateWithLabelString:@"Chart axis color" color:self.localChartSettings.chartAxisColor andHandler:^(UIColor *color) {
                        [self.localChartSettings setChartAxisColor:color];
                    }];
                    return cell;
                    break;
                }
                case 2:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Show X value as currency" isOn:self.localChartSettings.showXValueAsCurrency andHandler:^(BOOL isOn) {
                        self.localChartSettings.showXValueAsCurrency = isOn;
                    }];
                    return cell;
                    break;
                }
                case 3:
                {
                    SettingsTextCell* cell = (SettingsTextCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsTextCell"];
                    [cell updateWithLabelString:@"Currency code for X axis" textFieldPlaceholder:@"Currency code for X axis" textFieldString:self.localChartSettings.xAxisCurrencyCode andHandler:^(NSString *text) {
                        self.localChartSettings.xAxisCurrencyCode = text;
                    }];
                    return cell;
                    break;
                }
                case 4:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Show Y value as currency" isOn:self.localChartSettings.showYValueAsCurrency andHandler:^(BOOL isOn) {
                        self.localChartSettings.showYValueAsCurrency = isOn;
                    }];
                    return cell;
                    break;
                }
                case 5:
                {
                    SettingsTextCell* cell = (SettingsTextCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsTextCell"];
                    [cell updateWithLabelString:@"Currency code for Y axis" textFieldPlaceholder:@"Currency code for Y axis" textFieldString:self.localChartSettings.yAxisCurrencyCode andHandler:^(NSString *text) {
                        self.localChartSettings.yAxisCurrencyCode = text;
                    }];
                    return cell;
                    break;
                }
                case 6:
                {
                    SettingsSliderCell* cell = (SettingsSliderCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSliderCell"];
                    [cell updateWithLabelString:@"Chart axis font size" value:self.localChartSettings.fontSizeForAxis maxValue:11 minValue:8 andHandler:^(double value) {
                        self.localChartSettings.fontSizeForAxis = value;
                    }];
                    return cell;
                    break;
                }
                case 7:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Draw horizontal lines for every Y tick" isOn:self.localChartSettings.drawHorizontalLinesForYTicks andHandler:^(BOOL isOn) {
                        self.localChartSettings.drawHorizontalLinesForYTicks = isOn;
                    }];
                    return cell;
                    break;
                }
                default:
                    break;
            }
            break;
        case 3:
            switch (indexPath.row)
            {
                case 0:
                {
                    SettingsColorCell* cell = (SettingsColorCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsColorCell"];
                    [cell updateWithLabelString:@"Chart line color" color:self.localChartSettings.chartLineColor andHandler:^(UIColor *color) {
                        [self.localChartSettings setChartLineColor:color];
                    }];
                    return cell;
                    break;
                }
                case 1:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Chart with circles" isOn:self.localChartSettings.chartLineWithCircles andHandler:^(BOOL isOn) {
                        self.localChartSettings.chartLineWithCircles = isOn;
                    }];
                    return cell;
                    break;
                }
                case 2:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Real distribution of X values" isOn:self.localChartSettings.isValueChartWithRealXAxisDistribution andHandler:^(BOOL isOn) {
                        self.localChartSettings.isValueChartWithRealXAxisDistribution = isOn;
                    }];
                    return cell;
                    break;
                }
                case 3:
                {
                    SettingsSliderCell* cell = (SettingsSliderCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSliderCell"];
                    [cell updateWithLabelString:@"Chart line width" value:self.localChartSettings.chartLineWidth maxValue:10 minValue:1 andHandler:^(double value) {
                        self.localChartSettings.chartLineWidth = value;
                    }];
                    return cell;
                    break;
                }
                case 4:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Chart area with gradient" isOn:self.localChartSettings.chartGradientUnderline andHandler:^(BOOL isOn) {
                        self.localChartSettings.chartGradientUnderline = isOn;
                    }];
                    return cell;
                    break;
                }
                case 5:
                {
                    SettingsColorCell* cell = (SettingsColorCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsColorCell"];
                    [cell updateWithLabelString:@"Chart area top gradient color" color:self.localChartSettings.underLineChartGradientTopColor andHandler:^(UIColor *color) {
                        [self.localChartSettings setUnderLineChartGradientTopColor:color];
                    }];
                    return cell;
                    break;
                }
                case 6:
                {
                    SettingsSwitchCell* cell = (SettingsSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsSwitchCell"];
                    [cell updateWithLabelString:@"Chart area bottom color is transparent" isOn:self.localChartSettings.underLineChartGradientBottomColorIsTransparent andHandler:^(BOOL isOn) {
                        self.localChartSettings.underLineChartGradientBottomColorIsTransparent = isOn;
                    }];
                    return cell;
                    break;
                }
                case 7:
                {
                    SettingsColorCell* cell = (SettingsColorCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsColorCell"];
                    [cell updateWithLabelString:@"Chart area bottom gradient color" color:self.localChartSettings.underLineChartGradientBottomColor andHandler:^(UIColor *color) {
                        [self.localChartSettings setUnderLineChartGradientBottomColor:color];
                    }];
                    return cell;
                    break;
                }
                default:
                    break;
            }
            break;
        default:
            break;
    }
    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

//Chart info, chart background, chart axis, chart line

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *string =@"";
    switch (section)
    {
        case 0:
            string = @"Chart info";
            break;
        case 1:
            string = @"Chart background";
            break;
        case 2:
            string = @"Chart axis";
            break;
        case 3:
            string = @"Chart line";
            break;
        default:
            break;
    }
    return string;
}
    
@end

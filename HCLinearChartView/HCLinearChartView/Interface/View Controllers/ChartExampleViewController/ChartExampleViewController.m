//
//  ViewController.m
//  MyChart
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "ChartExampleViewController.h"

@interface ChartExampleViewController ()

@end

@implementation ChartExampleViewController

#pragma mark Basic ChartExampleViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadChartSettings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    [self updateChartWithSettings];
    [self.hcLinearChartView drawChart];
}

-(void)setNavigationBar
{
    [self.navigationController.navigationBar setTranslucent:YES];
    
    UIButton *leftImageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 107, 25)];
    [leftImageButton setBackgroundImage:[UIImage imageNamed:@"hcLinearChartLogo"] forState:UIControlStateNormal];
    [leftImageButton setUserInteractionEnabled:NO];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftImageButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIButton *rightImageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 125, 25)];
    [rightImageButton setBackgroundImage:[UIImage imageNamed:@"hypercubeLogo"] forState:UIControlStateNormal];
    [rightImageButton addTarget:self action:@selector(openHypercubeSoftWebPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightImageButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:10.0/255.0 green:146.0/255.0 blue:242.0/255.0 alpha:1.0]];
}

#pragma mark User interactions

- (IBAction)changeChartSettings:(id)sender
{
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ChartExampleSettingsViewController"] animated:YES];
}

- (IBAction)generateRandomChartDataWithDatesOnXAxis:(id)sender
{
    [self addRandomDataWithDatesOnXAxis:YES];
    [self.hcLinearChartView drawChart];
}

- (IBAction)generateRandomChartDataWithNumbersOnXAxis:(id)sender
{
    [self addRandomDataWithDatesOnXAxis:NO];
    [self.hcLinearChartView drawChart];
}

- (IBAction)generateRandomChartSettings:(id)sender
{
    [self generateRandomSettingsAndRefresh];
}

-(void)openHypercubeSoftWebPage
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.hypercubesoft.com"] options:@{} completionHandler:NULL];
}

#pragma mark Handle chart data

-(void)addRandomDataWithDatesOnXAxis:(BOOL)datesOnXAxis
{
    [self.hcLinearChartView.xElements removeAllObjects];
    [self.hcLinearChartView.yElements removeAllObjects];
    double averageXValue = arc4random_uniform(10000000);
    double lastXValue = arc4random_uniform((int)averageXValue * 2) - averageXValue;
    double xValueMaxJump = arc4random_uniform(100000);
    int averageYValue = arc4random_uniform(10000);
    int lastYValue = arc4random_uniform(averageYValue * 2) - averageYValue;
    int numberOfElements = 1+arc4random_uniform(100);
    
    BOOL yValueIsDecimal = rand()%2;
    BOOL xValueIsDecimal = rand()%2;
    
    for (int i = 0 ; i < numberOfElements; i++)
    {
        if (datesOnXAxis)
        {
            [self.hcLinearChartView.xElements addObject:[NSDate dateWithTimeIntervalSince1970:lastXValue + [[NSDate date] timeIntervalSince1970]]];
            lastXValue += 1 + arc4random_uniform(xValueMaxJump);
        }
        else
        {
            [self.hcLinearChartView.xElements addObject:@(lastXValue / (xValueIsDecimal ? 1000000000.0 : 1.0))];
            lastXValue += 1 + arc4random_uniform(10 * (xValueIsDecimal ? 100000 : 1));
        }
        [self.hcLinearChartView.yElements addObject:@(lastYValue / (yValueIsDecimal ? 1000000.0 : 1.0))];
        int rand = arc4random_uniform(1000);
        lastYValue += rand - 500;
    }
}



#pragma mark Handle chart settings

-(void)loadChartSettings
{
    [HCChartSettings sharedInstance].chartLineColor = self.hcLinearChartView.chartLineColor;
    [HCChartSettings sharedInstance].chartLineWidth = self.hcLinearChartView.chartLineWidth;
    [HCChartSettings sharedInstance].chartTitle = self.hcLinearChartView.chartTitle;
    [HCChartSettings sharedInstance].chartSubTitle = self.hcLinearChartView.chartSubTitle;
    [HCChartSettings sharedInstance].chartGradient = self.hcLinearChartView.chartGradient;
    [HCChartSettings sharedInstance].chartWithRoundedCorners = self.hcLinearChartView.chartWithRoundedCorners;
    [HCChartSettings sharedInstance].chartTransparentBackground = self.hcLinearChartView.chartTransparentBackground;
    [HCChartSettings sharedInstance].chartLineWithCircles = self.hcLinearChartView.chartLineWithCircles;
    [HCChartSettings sharedInstance].chartGradientUnderline = self.hcLinearChartView.chartGradientUnderline;
    [HCChartSettings sharedInstance].chartTitleColor = self.hcLinearChartView.chartTitleColor;
    [HCChartSettings sharedInstance].chartSubtitleColor = self.hcLinearChartView.chartSubtitleColor;
    [HCChartSettings sharedInstance].chartAxisColor = self.hcLinearChartView.chartAxisColor;
    [HCChartSettings sharedInstance].backgroundGradientTopColor = self.hcLinearChartView.backgroundGradientTopColor;
    [HCChartSettings sharedInstance].backgroundGradientBottomColor = self.hcLinearChartView.backgroundGradientBottomColor;
    [HCChartSettings sharedInstance].underLineChartGradientTopColor = self.hcLinearChartView.underLineChartGradientTopColor;
    [HCChartSettings sharedInstance].underLineChartGradientBottomColor = self.hcLinearChartView.underLineChartGradientBottomColor;
    [HCChartSettings sharedInstance].showSubtitle = self.hcLinearChartView.showSubtitle;
    [HCChartSettings sharedInstance].isValueChartWithRealXAxisDistribution = self.hcLinearChartView.isValueChartWithRealXAxisDistribution;
    [HCChartSettings sharedInstance].underLineChartGradientBottomColorIsTransparent = self.hcLinearChartView.underLineChartGradientBottomColorIsTransparent;
    [HCChartSettings sharedInstance].showXValueAsCurrency = self.hcLinearChartView.showXValueAsCurrency;
    [HCChartSettings sharedInstance].xAxisCurrencyCode = self.hcLinearChartView.xAxisCurrencyCode;
    [HCChartSettings sharedInstance].showYValueAsCurrency = self.hcLinearChartView.showYValueAsCurrency;
    [HCChartSettings sharedInstance].yAxisCurrencyCode = self.hcLinearChartView.yAxisCurrencyCode;
    [HCChartSettings sharedInstance].horizontalValuesOnXAxis = self.hcLinearChartView.horizontalValuesOnXAxis;
    [HCChartSettings sharedInstance].drawHorizontalLinesForYTicks = self.hcLinearChartView.drawHorizontalLinesForYTicks;
    [HCChartSettings sharedInstance].fontSizeForTitle = self.hcLinearChartView.fontSizeForTitle;
    [HCChartSettings sharedInstance].fontSizeForSubTitle = self.hcLinearChartView.fontSizeForSubTitle;
    [HCChartSettings sharedInstance].fontSizeForAxis = self.hcLinearChartView.fontSizeForAxis;
}

-(void)updateChartWithSettings
{
    self.hcLinearChartView.chartLineColor = [HCChartSettings sharedInstance].chartLineColor;
    self.hcLinearChartView.chartLineWidth = [HCChartSettings sharedInstance].chartLineWidth;
    self.hcLinearChartView.chartTitle = [HCChartSettings sharedInstance].chartTitle;
    self.hcLinearChartView.chartSubTitle = [HCChartSettings sharedInstance].chartSubTitle;
    self.hcLinearChartView.chartGradient = [HCChartSettings sharedInstance].chartGradient;
    self.hcLinearChartView.chartWithRoundedCorners = [HCChartSettings sharedInstance].chartWithRoundedCorners;
    self.hcLinearChartView.chartTransparentBackground = [HCChartSettings sharedInstance].chartTransparentBackground;
    self.hcLinearChartView.chartLineWithCircles = [HCChartSettings sharedInstance].chartLineWithCircles;
    self.hcLinearChartView.chartGradientUnderline = [HCChartSettings sharedInstance].chartGradientUnderline;
    self.hcLinearChartView.chartTitleColor = [HCChartSettings sharedInstance].chartTitleColor;
    self.hcLinearChartView.chartSubtitleColor = [HCChartSettings sharedInstance].chartSubtitleColor;
    self.hcLinearChartView.chartAxisColor = [HCChartSettings sharedInstance].chartAxisColor;
    self.hcLinearChartView.backgroundGradientTopColor = [HCChartSettings sharedInstance].backgroundGradientTopColor;
    self.hcLinearChartView.backgroundGradientBottomColor = [HCChartSettings sharedInstance].backgroundGradientBottomColor;
    self.hcLinearChartView.underLineChartGradientTopColor = [HCChartSettings sharedInstance].underLineChartGradientTopColor;
    self.hcLinearChartView.underLineChartGradientBottomColor = [HCChartSettings sharedInstance].underLineChartGradientBottomColor;
    self.hcLinearChartView.showSubtitle = [HCChartSettings sharedInstance].showSubtitle;
    self.hcLinearChartView.isValueChartWithRealXAxisDistribution = [HCChartSettings sharedInstance].isValueChartWithRealXAxisDistribution;
    self.hcLinearChartView.underLineChartGradientBottomColorIsTransparent = [HCChartSettings sharedInstance].underLineChartGradientBottomColorIsTransparent;
    self.hcLinearChartView.showXValueAsCurrency = [HCChartSettings sharedInstance].showXValueAsCurrency;
    self.hcLinearChartView.xAxisCurrencyCode = [HCChartSettings sharedInstance].xAxisCurrencyCode;
    self.hcLinearChartView.showYValueAsCurrency = [HCChartSettings sharedInstance].showYValueAsCurrency;
    self.hcLinearChartView.yAxisCurrencyCode = [HCChartSettings sharedInstance].yAxisCurrencyCode;
    self.hcLinearChartView.horizontalValuesOnXAxis = [HCChartSettings sharedInstance].horizontalValuesOnXAxis;
    self.hcLinearChartView.drawHorizontalLinesForYTicks = [HCChartSettings sharedInstance].drawHorizontalLinesForYTicks;
    self.hcLinearChartView.fontSizeForTitle = [HCChartSettings sharedInstance].fontSizeForTitle;
    self.hcLinearChartView.fontSizeForSubTitle = [HCChartSettings sharedInstance].fontSizeForSubTitle;
    self.hcLinearChartView.fontSizeForAxis = [HCChartSettings sharedInstance].fontSizeForAxis;
    [self.hcLinearChartView drawChart];
}

-(void)generateRandomSettingsAndRefresh
{
    BOOL darkBackground = rand()%2;
    NSArray* currencyCodes = @[@"USD",@"EUR",@"GBP"];
    self.hcLinearChartView.chartLineColor = darkBackground ? [self randomLightColor] : [self randomDarkColor];
    self.hcLinearChartView.chartLineWidth = 1+arc4random_uniform(9);
    self.hcLinearChartView.chartTitle = @"Chart title";
    self.hcLinearChartView.chartSubTitle = @"Chart subtitle";
    self.hcLinearChartView.chartGradient = rand()%2;
    self.hcLinearChartView.chartWithRoundedCorners = rand()%2;
    self.hcLinearChartView.chartTransparentBackground = darkBackground ? NO : arc4random_uniform(9) == 0;
    self.hcLinearChartView.chartLineWithCircles = arc4random_uniform(5) == 0;
    self.hcLinearChartView.chartGradientUnderline = rand()%2 == 0;
    self.hcLinearChartView.chartTitleColor = darkBackground ? [self randomLightColor] : [self randomDarkColor];
    self.hcLinearChartView.chartSubtitleColor = darkBackground ? [self randomLightColor] : [self randomDarkColor];
    self.hcLinearChartView.chartAxisColor = darkBackground ? [self randomLightColor] : [self randomDarkColor];
    self.hcLinearChartView.backgroundGradientTopColor = darkBackground ? [self randomDarkColor] : [self randomLightColor];
    self.hcLinearChartView.backgroundGradientBottomColor = darkBackground ? [self randomDarkColor] : [self randomLightColor];
    self.hcLinearChartView.underLineChartGradientTopColor = darkBackground ? [self randomDarkColor] : [self randomLightColor];
    self.hcLinearChartView.underLineChartGradientBottomColor = darkBackground ? [self randomDarkColor] : [self randomLightColor];
    self.hcLinearChartView.showSubtitle = rand()%2 ;
    self.hcLinearChartView.isValueChartWithRealXAxisDistribution = rand()%2;
    self.hcLinearChartView.underLineChartGradientBottomColorIsTransparent = rand()%2;
    self.hcLinearChartView.showXValueAsCurrency = rand()%2;
    self.hcLinearChartView.xAxisCurrencyCode = currencyCodes[rand()%3];
    self.hcLinearChartView.showYValueAsCurrency = rand()%2;
    self.hcLinearChartView.yAxisCurrencyCode = currencyCodes[rand()%3];
    self.hcLinearChartView.horizontalValuesOnXAxis = rand()%2;
    self.hcLinearChartView.drawHorizontalLinesForYTicks = rand()%2;
    self.hcLinearChartView.fontSizeForTitle = 18+rand()%8;
    self.hcLinearChartView.fontSizeForSubTitle = 12+rand()%6;
    self.hcLinearChartView.fontSizeForAxis = 8+rand()%4;
    [self loadChartSettings];
    [self.hcLinearChartView drawChart];
}

#pragma mark Help methods for chart settings

-(UIColor*)randomDarkColor
{
    return [UIColor colorWithRed:(arc4random_uniform(127))/255.0 green:(arc4random_uniform(127))/255.0 blue:(arc4random_uniform(127))/255.0 alpha:1.0];;
}

-(UIColor*)randomLightColor
{
    return [UIColor colorWithRed:(128.0+arc4random_uniform(127))/255.0 green:(128.0+arc4random_uniform(127))/255.0 blue:(128.0+arc4random_uniform(127))/255.0 alpha:1.0];
}

    
@end

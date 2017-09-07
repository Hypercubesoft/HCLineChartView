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
    [self.hcLineChartView drawChart];
}

-(void)setNavigationBar
{
    [self.navigationController.navigationBar setTranslucent:YES];
    
    UIButton *leftImageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 122, 25)];
    [leftImageButton setBackgroundImage:[UIImage imageNamed:@"hcLineChartLogo"] forState:UIControlStateNormal];
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
    [self.hcLineChartView drawChart];
}

- (IBAction)generateRandomChartDataWithNumbersOnXAxis:(id)sender
{
    [self addRandomDataWithDatesOnXAxis:NO];
    [self.hcLineChartView drawChart];
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
    [self.hcLineChartView.xElements removeAllObjects];
    [self.hcLineChartView.yElements removeAllObjects];
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
            [self.hcLineChartView.xElements addObject:[NSDate dateWithTimeIntervalSince1970:lastXValue + [[NSDate date] timeIntervalSince1970]]];
            lastXValue += 1 + arc4random_uniform(xValueMaxJump);
        }
        else
        {
            [self.hcLineChartView.xElements addObject:@(lastXValue / (xValueIsDecimal ? 1000000000.0 : 1.0))];
            lastXValue += 1 + arc4random_uniform(10 * (xValueIsDecimal ? 100000 : 1));
        }
        [self.hcLineChartView.yElements addObject:@(lastYValue / (yValueIsDecimal ? 1000000.0 : 1.0))];
        int rand = arc4random_uniform(1000);
        lastYValue += rand - 500;
    }
}



#pragma mark Handle chart settings

-(void)loadChartSettings
{
    [HCChartSettings sharedInstance].chartLineColor = self.hcLineChartView.chartLineColor;
    [HCChartSettings sharedInstance].chartLineWidth = self.hcLineChartView.chartLineWidth;
    [HCChartSettings sharedInstance].chartTitle = self.hcLineChartView.chartTitle;
    [HCChartSettings sharedInstance].chartSubTitle = self.hcLineChartView.chartSubTitle;
    [HCChartSettings sharedInstance].chartGradient = self.hcLineChartView.chartGradient;
    [HCChartSettings sharedInstance].chartWithRoundedCorners = self.hcLineChartView.chartWithRoundedCorners;
    [HCChartSettings sharedInstance].chartTransparentBackground = self.hcLineChartView.chartTransparentBackground;
    [HCChartSettings sharedInstance].chartLineWithCircles = self.hcLineChartView.chartLineWithCircles;
    [HCChartSettings sharedInstance].chartGradientUnderline = self.hcLineChartView.chartGradientUnderline;
    [HCChartSettings sharedInstance].chartTitleColor = self.hcLineChartView.chartTitleColor;
    [HCChartSettings sharedInstance].chartSubtitleColor = self.hcLineChartView.chartSubtitleColor;
    [HCChartSettings sharedInstance].chartAxisColor = self.hcLineChartView.chartAxisColor;
    [HCChartSettings sharedInstance].backgroundGradientTopColor = self.hcLineChartView.backgroundGradientTopColor;
    [HCChartSettings sharedInstance].backgroundGradientBottomColor = self.hcLineChartView.backgroundGradientBottomColor;
    [HCChartSettings sharedInstance].underLineChartGradientTopColor = self.hcLineChartView.underLineChartGradientTopColor;
    [HCChartSettings sharedInstance].underLineChartGradientBottomColor = self.hcLineChartView.underLineChartGradientBottomColor;
    [HCChartSettings sharedInstance].showSubtitle = self.hcLineChartView.showSubtitle;
    [HCChartSettings sharedInstance].isValueChartWithRealXAxisDistribution = self.hcLineChartView.isValueChartWithRealXAxisDistribution;
    [HCChartSettings sharedInstance].underLineChartGradientBottomColorIsTransparent = self.hcLineChartView.underLineChartGradientBottomColorIsTransparent;
    [HCChartSettings sharedInstance].showXValueAsCurrency = self.hcLineChartView.showXValueAsCurrency;
    [HCChartSettings sharedInstance].xAxisCurrencyCode = self.hcLineChartView.xAxisCurrencyCode;
    [HCChartSettings sharedInstance].showYValueAsCurrency = self.hcLineChartView.showYValueAsCurrency;
    [HCChartSettings sharedInstance].yAxisCurrencyCode = self.hcLineChartView.yAxisCurrencyCode;
    [HCChartSettings sharedInstance].horizontalValuesOnXAxis = self.hcLineChartView.horizontalValuesOnXAxis;
    [HCChartSettings sharedInstance].drawHorizontalLinesForYTicks = self.hcLineChartView.drawHorizontalLinesForYTicks;
    [HCChartSettings sharedInstance].fontSizeForTitle = self.hcLineChartView.fontSizeForTitle;
    [HCChartSettings sharedInstance].fontSizeForSubTitle = self.hcLineChartView.fontSizeForSubTitle;
    [HCChartSettings sharedInstance].fontSizeForAxis = self.hcLineChartView.fontSizeForAxis;
}

-(void)updateChartWithSettings
{
    self.hcLineChartView.chartLineColor = [HCChartSettings sharedInstance].chartLineColor;
    self.hcLineChartView.chartLineWidth = [HCChartSettings sharedInstance].chartLineWidth;
    self.hcLineChartView.chartTitle = [HCChartSettings sharedInstance].chartTitle;
    self.hcLineChartView.chartSubTitle = [HCChartSettings sharedInstance].chartSubTitle;
    self.hcLineChartView.chartGradient = [HCChartSettings sharedInstance].chartGradient;
    self.hcLineChartView.chartWithRoundedCorners = [HCChartSettings sharedInstance].chartWithRoundedCorners;
    self.hcLineChartView.chartTransparentBackground = [HCChartSettings sharedInstance].chartTransparentBackground;
    self.hcLineChartView.chartLineWithCircles = [HCChartSettings sharedInstance].chartLineWithCircles;
    self.hcLineChartView.chartGradientUnderline = [HCChartSettings sharedInstance].chartGradientUnderline;
    self.hcLineChartView.chartTitleColor = [HCChartSettings sharedInstance].chartTitleColor;
    self.hcLineChartView.chartSubtitleColor = [HCChartSettings sharedInstance].chartSubtitleColor;
    self.hcLineChartView.chartAxisColor = [HCChartSettings sharedInstance].chartAxisColor;
    self.hcLineChartView.backgroundGradientTopColor = [HCChartSettings sharedInstance].backgroundGradientTopColor;
    self.hcLineChartView.backgroundGradientBottomColor = [HCChartSettings sharedInstance].backgroundGradientBottomColor;
    self.hcLineChartView.underLineChartGradientTopColor = [HCChartSettings sharedInstance].underLineChartGradientTopColor;
    self.hcLineChartView.underLineChartGradientBottomColor = [HCChartSettings sharedInstance].underLineChartGradientBottomColor;
    self.hcLineChartView.showSubtitle = [HCChartSettings sharedInstance].showSubtitle;
    self.hcLineChartView.isValueChartWithRealXAxisDistribution = [HCChartSettings sharedInstance].isValueChartWithRealXAxisDistribution;
    self.hcLineChartView.underLineChartGradientBottomColorIsTransparent = [HCChartSettings sharedInstance].underLineChartGradientBottomColorIsTransparent;
    self.hcLineChartView.showXValueAsCurrency = [HCChartSettings sharedInstance].showXValueAsCurrency;
    self.hcLineChartView.xAxisCurrencyCode = [HCChartSettings sharedInstance].xAxisCurrencyCode;
    self.hcLineChartView.showYValueAsCurrency = [HCChartSettings sharedInstance].showYValueAsCurrency;
    self.hcLineChartView.yAxisCurrencyCode = [HCChartSettings sharedInstance].yAxisCurrencyCode;
    self.hcLineChartView.horizontalValuesOnXAxis = [HCChartSettings sharedInstance].horizontalValuesOnXAxis;
    self.hcLineChartView.drawHorizontalLinesForYTicks = [HCChartSettings sharedInstance].drawHorizontalLinesForYTicks;
    self.hcLineChartView.fontSizeForTitle = [HCChartSettings sharedInstance].fontSizeForTitle;
    self.hcLineChartView.fontSizeForSubTitle = [HCChartSettings sharedInstance].fontSizeForSubTitle;
    self.hcLineChartView.fontSizeForAxis = [HCChartSettings sharedInstance].fontSizeForAxis;
    [self.hcLineChartView drawChart];
}

-(void)generateRandomSettingsAndRefresh
{
    BOOL darkBackground = rand()%2;
    NSArray* currencyCodes = @[@"USD",@"EUR",@"GBP"];
    self.hcLineChartView.chartLineColor = darkBackground ? [self randomLightColor] : [self randomDarkColor];
    self.hcLineChartView.chartLineWidth = 1+arc4random_uniform(9);
    self.hcLineChartView.chartTitle = @"Chart title";
    self.hcLineChartView.chartSubTitle = @"Chart subtitle";
    self.hcLineChartView.chartGradient = rand()%2;
    self.hcLineChartView.chartWithRoundedCorners = rand()%2;
    self.hcLineChartView.chartTransparentBackground = darkBackground ? NO : arc4random_uniform(9) == 0;
    self.hcLineChartView.chartLineWithCircles = arc4random_uniform(5) == 0;
    self.hcLineChartView.chartGradientUnderline = rand()%2 == 0;
    self.hcLineChartView.chartTitleColor = darkBackground ? [self randomLightColor] : [self randomDarkColor];
    self.hcLineChartView.chartSubtitleColor = darkBackground ? [self randomLightColor] : [self randomDarkColor];
    self.hcLineChartView.chartAxisColor = darkBackground ? [self randomLightColor] : [self randomDarkColor];
    self.hcLineChartView.backgroundGradientTopColor = darkBackground ? [self randomDarkColor] : [self randomLightColor];
    self.hcLineChartView.backgroundGradientBottomColor = darkBackground ? [self randomDarkColor] : [self randomLightColor];
    self.hcLineChartView.underLineChartGradientTopColor = darkBackground ? [self randomDarkColor] : [self randomLightColor];
    self.hcLineChartView.underLineChartGradientBottomColor = darkBackground ? [self randomDarkColor] : [self randomLightColor];
    self.hcLineChartView.showSubtitle = rand()%2 ;
    self.hcLineChartView.isValueChartWithRealXAxisDistribution = rand()%2;
    self.hcLineChartView.underLineChartGradientBottomColorIsTransparent = rand()%2;
    self.hcLineChartView.showXValueAsCurrency = rand()%2;
    self.hcLineChartView.xAxisCurrencyCode = currencyCodes[rand()%3];
    self.hcLineChartView.showYValueAsCurrency = rand()%2;
    self.hcLineChartView.yAxisCurrencyCode = currencyCodes[rand()%3];
    self.hcLineChartView.horizontalValuesOnXAxis = rand()%2;
    self.hcLineChartView.drawHorizontalLinesForYTicks = rand()%2;
    self.hcLineChartView.fontSizeForTitle = 18+rand()%8;
    self.hcLineChartView.fontSizeForSubTitle = 12+rand()%6;
    self.hcLineChartView.fontSizeForAxis = 8+rand()%4;
    [self loadChartSettings];
    [self.hcLineChartView drawChart];
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

//
//  HCChartSettings.m
//  HCLineChartView
//
//  Created by Hypercube on 5/19/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

#import "HCChartSettings.h"

static HCChartSettings *instance=nil;

@implementation HCChartSettings

+ (HCChartSettings*) sharedInstance
{
    @synchronized(self) {
        if (instance == nil)
        {
            instance = [[HCChartSettings alloc] init];
        }
    }
    return instance;
}

+ (void)setSharedSettings:(HCChartSettings*)settings
{
    instance = settings;
}

-(void)updateWithSettings:(HCChartSettings*)settings
{
    self.chartLineColor = settings.chartLineColor;
    self.chartLineWidth = settings.chartLineWidth;
    self.chartTitle = settings.chartTitle;
    self.chartSubTitle = settings.chartSubTitle;
    self.chartGradient = settings.chartGradient;
    self.chartWithRoundedCorners = settings.chartWithRoundedCorners;
    self.chartTransparentBackground = settings.chartTransparentBackground;
    self.chartLineWithCircles = settings.chartLineWithCircles;
    self.chartGradientUnderline = settings.chartGradientUnderline;
    self.chartTitleColor = settings.chartTitleColor;
    self.chartSubtitleColor = settings.chartSubtitleColor;
    self.chartAxisColor = settings.chartAxisColor;
    self.backgroundGradientTopColor = settings.backgroundGradientTopColor;
    self.backgroundGradientBottomColor = settings.backgroundGradientBottomColor;
    self.underLineChartGradientTopColor = settings.underLineChartGradientTopColor;
    self.underLineChartGradientBottomColor = settings.underLineChartGradientBottomColor;
    self.showSubtitle = settings.showSubtitle;
    self.isValueChartWithRealXAxisDistribution = settings.isValueChartWithRealXAxisDistribution;
    self.underLineChartGradientBottomColorIsTransparent = settings.underLineChartGradientBottomColorIsTransparent;
    self.showXValueAsCurrency = settings.showXValueAsCurrency;
    self.xAxisCurrencyCode = settings.xAxisCurrencyCode;
    self.showYValueAsCurrency = settings.showYValueAsCurrency;
    self.yAxisCurrencyCode = settings.yAxisCurrencyCode;
    self.horizontalValuesOnXAxis = settings.horizontalValuesOnXAxis;
    self.drawHorizontalLinesForYTicks = settings.drawHorizontalLinesForYTicks;
    self.fontSizeForTitle = settings.fontSizeForTitle;
    self.fontSizeForSubTitle = settings.fontSizeForSubTitle;
    self.fontSizeForAxis = settings.fontSizeForAxis;
}

-(id)copy
{
    HCChartSettings* chartSettings = [HCChartSettings new];
    chartSettings.chartLineColor = self.chartLineColor;
    chartSettings.chartLineWidth = self.chartLineWidth;
    chartSettings.chartTitle = self.chartTitle;
    chartSettings.chartSubTitle = self.chartSubTitle;
    chartSettings.chartGradient = self.chartGradient;
    chartSettings.chartWithRoundedCorners = self.chartWithRoundedCorners;
    chartSettings.chartTransparentBackground = self.chartTransparentBackground;
    chartSettings.chartLineWithCircles = self.chartLineWithCircles;
    chartSettings.chartGradientUnderline = self.chartGradientUnderline;
    chartSettings.chartTitleColor = self.chartTitleColor;
    chartSettings.chartSubtitleColor = self.chartSubtitleColor;
    chartSettings.chartAxisColor = self.chartAxisColor;
    chartSettings.backgroundGradientTopColor = self.backgroundGradientTopColor;
    chartSettings.backgroundGradientBottomColor = self.backgroundGradientBottomColor;
    chartSettings.underLineChartGradientTopColor = self.underLineChartGradientTopColor;
    chartSettings.underLineChartGradientBottomColor = self.underLineChartGradientBottomColor;
    chartSettings.showSubtitle = self.showSubtitle;
    chartSettings.isValueChartWithRealXAxisDistribution = self.isValueChartWithRealXAxisDistribution;
    chartSettings.underLineChartGradientBottomColorIsTransparent = self.underLineChartGradientBottomColorIsTransparent;
    chartSettings.showXValueAsCurrency = self.showXValueAsCurrency;
    chartSettings.xAxisCurrencyCode = self.xAxisCurrencyCode;
    chartSettings.showYValueAsCurrency = self.showYValueAsCurrency;
    chartSettings.yAxisCurrencyCode = self.yAxisCurrencyCode;
    chartSettings.horizontalValuesOnXAxis = self.horizontalValuesOnXAxis;
    chartSettings.drawHorizontalLinesForYTicks = self.drawHorizontalLinesForYTicks;
    chartSettings.fontSizeForTitle = self.fontSizeForTitle;
    chartSettings.fontSizeForSubTitle = self.fontSizeForSubTitle;
    chartSettings.fontSizeForAxis = self.fontSizeForAxis;
    return chartSettings;
}

@end

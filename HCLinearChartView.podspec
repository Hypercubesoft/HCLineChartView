Pod::Spec.new do |s|

s.platform = :ios
s.name             = "HCLinearChartView"
s.version          = "1.0.0"
s.summary          = "HCLinearChartView is an iOS library for drawing linear charts."

s.description      = <<-DESC
HCLinearChartView is a beautiful iOS library for drawing linear charts. It is customizable and easy to use.
DESC

s.homepage         = "https://github.com/Hypercubesoft/HCLinearChartView"
s.license          = { :type => "MIT", :file => "LICENSE" }
s.author           = { "Hypercubesoft" => "office@hypercubesoft.com" }
s.source           = { :git => "https://github.com/Hypercubesoft/HCLinearChartView.git", :tag => "#{s.version}"}

s.ios.deployment_target = "8.0"
s.source_files = "HCLinearChartView/HCLinearChartView/Source/HCLinearChartView/*"

end
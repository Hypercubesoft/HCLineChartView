Pod::Spec.new do |s|

s.platform = :ios
s.name             = "HCLineChartView"
s.version          = "1.0.0"
s.summary          = "HCLineChartView is an iOS library for drawing linear charts."

s.description      = <<-DESC
HCLineChartView is a beautiful iOS library for drawing line charts. It is customizable and easy to use.
DESC

s.homepage         = "https://github.com/Hypercubesoft/HCLineChartView"
s.license          = { :type => "MIT", :file => "LICENSE" }
s.author           = { "Hypercubesoft" => "office@hypercubesoft.com" }
s.source           = { :git => "https://github.com/Hypercubesoft/HCLineChartView.git", :tag => "#{s.version}"}

s.ios.deployment_target = "8.0"
s.source_files = "Source/HCLineChartView", "Source/HCLineChartView/**/*"

end
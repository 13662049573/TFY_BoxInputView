
Pod::Spec.new do |spec|

  spec.name         = "TFY_BoxInputITools"

  spec.version      = "2.0.6"

  spec.summary      = "密码输入框"

  spec.description  = <<-DESC
                        密码输入框
                         DESC

  spec.homepage     = "https://github.com/13662049573/TFY_BoxInputView"
  
  spec.license      = "MIT"
  
  spec.platform     = :ios, "10.0"

  spec.author       = { "tfyzxc13662049573" => "420144542@qq.com" }
 
  spec.source       = { :git => "https://github.com/13662049573/TFY_BoxInputView.git", :tag => spec.version }

  spec.source_files  = "TFY_BoxInputView/TFY_BoxInputITools/**/*.{h,m}"

  spec.frameworks    = "Foundation","UIKit"

  spec.xcconfig      = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include" }
  
  spec.requires_arc = true

end

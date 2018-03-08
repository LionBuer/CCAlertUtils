Pod::Spec.new do |s|
  s.name     = 'CCAlertUtils'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'for supconit hcmobile'
  s.homepage = 'https://github.com/LionBuer/CCAlertUtils'
  s.author   = {"徐畅"=>"yb_xuchang@163.com"}
  s.social_media_url = "https://github.com/LionBuer"

  s.source   = { :git => 'https://github.com/LionBuer/CCAlertUtils.git', :tag => "v#{s.version}" }

  s.source_files = '*.{h,m}'

  s.ios.frameworks = 'Foundation', 'UIKit'

  s.ios.deployment_target = '8.0' # minimum SDK with autolayout
  
  s.requires_arc = true

  s.dependency "MBProgressHUD"
  s.dependency "BlocksKit"	
end
~      
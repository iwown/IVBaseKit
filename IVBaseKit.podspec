Pod::Spec.new do |s|

s.name         = 'IVBaseKit'

s.version      = "0.0.8"

s.summary      = 'Base class used in iwown iOS developer team'

s.license      = 'MIT'

s.author       = { "xuezou" => "377949550@qq.com" }

s.homepage     = 'https://github.com/xuezou/IVBaseKit'

s.source       = { :git => "https://github.com/xuezou/IVBaseKit.git", :tag => s.version}

s.platform     = :ios

s.ios.deployment_target = "8.0"

s.frameworks = 'Foundation'

s.vendored_frameworks = 'IVBaseKit/IVBaseKit.framework'

s.requires_arc = true

end

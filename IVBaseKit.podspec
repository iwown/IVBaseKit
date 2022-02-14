Pod::Spec.new do |s|

s.name         = 'IVBaseKit'

s.version      = "1.4.4"

s.summary      = 'Base class used in iwown iOS developer team'

s.license      = 'MIT'

s.author       = { "xuezou" => "377949550@qq.com", "west" => "741415771@qq.com" }

s.homepage     = 'https://github.com/iwown/IVBaseKit'

s.source       = { :git => "https://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@github.com/iwown/IVBaseKit.git", :tag => s.version}

s.source_files = "Products/", "Products/**/*.{h,m}"

s.platform     = :ios

s.ios.deployment_target = "10.0"

s.requires_arc = true

end

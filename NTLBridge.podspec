Pod::Spec.new do |s|

  s.name         = "NTLBridge"
  s.version      = "4.0.0"
  s.summary      = "a fork from dsBridge"

  s.description  = <<-DESC
 An javascript bridge for calling functions synchronously and asynchronously
                   DESC

  s.homepage     = "https://github.com/netless-io/DSBridge-IOS.git"
  s.license      = "MIT"
  s.author             = "lazydu"
  s.platform     = :ios, "10.0"
  s.ios.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/netless-io/DSBridge-IOS.git", :tag => "#{s.version}" }
  s.source_files  =  "dsbridge/*"
  s.public_header_files = "dsbridge/*.h"
  s.frameworks  = "UIKit"
  s.pod_target_xcconfig = {
    'CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF' => 'NO'
  }

end



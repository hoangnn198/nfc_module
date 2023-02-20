Pod::Spec.new do |s|
  s.name         = "NFCModule"
  s.version      = "1.0.2"
  s.summary      = "NFC Module for React Native"
  s.description  = "This module provides an interface for reading NFC tags in React Native apps."
  s.homepage     = "https://github.com/your-username/nfc-module"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Your Name" => "your@email.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/your-username/nfc-module.git", :tag => "#{s.version}" }
  s.source_files  = "ios/*.{h,m,swift}"
  s.preserve_paths = "ios/*.xcframework"
  s.ios.vendored_frameworks = "ios/*.xcframework"
  s.dependency "React"
  s.xcconfig = {
    "HEADER_SEARCH_PATHS" => "$(SRCROOT)/../node_modules/react-native/React",
    "OTHER_LDFLAGS" => "$(inherited) -ObjC"
  }
end

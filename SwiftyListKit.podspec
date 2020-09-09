#
# Be sure to run `pod lib lint ListKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyListKit'
  s.version          = '1.0.23'
  s.summary          = 'Framework for building flexible, reusable and fast lists'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Powerful framework for building flexible, reusable and fast lists with a declarative approach
                       DESC

  s.homepage         = 'https://github.com/aleksandrshoshiashvili/SwiftListKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexander Shoshiashvili' => 'aleksandr.shoshiashvili@gmail.com' }
  s.source           = { :git => 'https://github.com/aleksandrshoshiashvili/SwiftListKit', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'ListKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ListKit' => ['ListKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'DifferenceKit'
end

#
# Be sure to run `pod lib lint Elissa.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Elissa'
  s.version          = '3.0'
  s.summary          = 'Easy notification popup.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Elissa displays a notification on top of a UITabBarItem or any anchor view to reveal additional information.'
  s.homepage         = 'https://github.com/KitchenStories/Elissa'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kersten Broich' => 'kersten.broich@gmail.com' }
  s.source           = { :git => 'https://github.com/KitchenStories/Elissa.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kersten_broich'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Elissa/Classes/**/*'
  s.resources = ["Elissa/Assets/*.xib"]

  # s.resource_bundles = {
  #   'Elissa' => ['Elissa/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

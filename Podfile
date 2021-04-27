platform :ios, '12.0'
inhibit_all_warnings!
use_frameworks!

def pods
  pod 'R.swift'
  pod 'SnapKit', '~> 5.0.0'
  pod 'Moya', '~> 14.0'
  pod 'SwiftyJSON', '~> 4.0'
end

target 'Weather' do
  pods
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
end

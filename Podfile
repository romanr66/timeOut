# Uncomment the next line to define a global platform for your project
 platform :ios, '11.2'

target 'timeOut' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Charts', :git => 'https://github.com/danielgindi/Charts.git', :branch => 'master'
  pod 'RealmSwift', '~> 2.0.2'
  # Pods for timeOut/timeOut

  target 'timeOutTests' do
    inherit! :search_paths
    # Pods for testing
  end
  post_install do |installer|
      installer.pods_project.targets.each do |target|
         target.build_configuration.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
       end
     end
   end
  target 'timeOutUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

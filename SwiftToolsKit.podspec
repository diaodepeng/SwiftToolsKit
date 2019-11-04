Pod::Spec.new do |spec|

	spec.name         = "SwiftToolsKit"
	spec.version      = "0.0.2"
	spec.summary      = "SwiftToolsKit makes code in Swift easy to use."
	spec.homepage     = "https://github.com/diaodepeng/SwiftToolsKit"
	spec.license      = { :type => "MIT" }
	spec.author       = { "depler" => "diaodepeng@foxmail.com" }

	spec.requires_arc = true
	spec.swift_version = "5.0"
	spec.ios.deployment_target = "9.0"

	spec.source        = { :git => "https://github.com/diaodepeng/SwiftToolsKit.git", :tag => spec.version }

	spec.source_files  = "SwiftToolsKit/Source/**/*.swift"

	spec.preserve_paths        = 'SwiftToolsKit/CommonCrypto/**/*'
	spec.pod_target_xcconfig   = {
		'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]'         => '$(PODS_ROOT)/SwiftToolsKit/CommonCrypto/iphoneos',
		'SWIFT_INCLUDE_PATHS[sdk=iphonesimulator*]'  => '$(PODS_ROOT)/SwiftToolsKit/CommonCrypto/iphonesimulator',
		'SWIFT_VERSION' => '5.0'
	}
	
end

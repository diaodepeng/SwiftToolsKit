Pod::Spec.new do |spec|

	spec.name         = "SwiftToolsKit"
	spec.version      = "0.0.3"
	spec.summary      = "SwiftToolsKit makes code in Swift easy to use."
	spec.homepage     = "https://github.com/diaodepeng/SwiftToolsKit"
	spec.license      = { :type => "MIT" }
	spec.author       = { "depler" => "diaodepeng@foxmail.com" }

	spec.requires_arc = true
	spec.swift_version = "5.0"
	spec.ios.deployment_target = "9.0"

	spec.source        = { :git => "https://github.com/diaodepeng/SwiftToolsKit.git", :tag => spec.version }

	spec.source_files  = "SwiftToolsKit/Source/**/*.swift"
	
end

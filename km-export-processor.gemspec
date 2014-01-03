lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "km-export-processor"
  spec.version       = "0.0.1"
  spec.authors       = ["Clay Whitley"]
  spec.email         = ["cwhitley@kissmetrics.com"]
  spec.summary       = %q{A gem for processing KM exports}
  spec.description   = spec.summary
  spec.homepage      = "http://kissmetrics.github.com/km-export-processor"

  spec.files         = Dir["lib/**/*"]
  spec.executables   = Dir["bin/**/*"].map! { |f| f.gsub(/bin\//, '') }
  spec.test_files    = Dir["test/**/*", "spec/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "km", "~> 1.0"
  spec.add_runtime_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "yard", "~> 0.8"
  spec.add_development_dependency "pry", "~> 0.9"
end
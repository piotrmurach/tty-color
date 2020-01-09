lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tty/color/version"

Gem::Specification.new do |spec|
  spec.name          = "tty-color"
  spec.version       = TTY::Color::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["me@piotrmurach.com"]
  spec.summary       = %q{Terminal color capabilities detection}
  spec.description   = %q{Terminal color capabilities detection}
  spec.homepage      = "http://piotrmurach.github.io/tty"
  spec.license       = "MIT"
  if spec.respond_to?(:metadata=)
    spec.metadata = {
      "allowed_push_host" => "https://rubygems.org",
      "bug_tracker_uri"   => "https://github.com/piotrmurach/tty-prompt/issues",
      "changelog_uri"     => "https://github.com/piotrmurach/tty-prompt/blob/master/CHANGELOG.md",
      "documentation_uri" => "https://www.rubydoc.info/gems/tty-prompt",
      "homepage_uri"      => spec.homepage,
      "source_code_uri"   => "https://github.com/piotrmurach/tty-prompt"
    }
  end
  spec.files         = Dir["{lib,spec}/**/*.rb", "tty-color.gemspec"]
  spec.files        += Dir["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.executables   = []
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0.0"

  spec.add_development_dependency "bundler", ">= 1.5.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "rake"
end

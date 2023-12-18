# frozen_string_literal: true

require_relative "lib/tty/color/version"

Gem::Specification.new do |spec|
  spec.name          = "tty-color"
  spec.version       = TTY::Color::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.summary       = %q{Terminal color capabilities detection}
  spec.description   = %q{Terminal color capabilities detection}
  spec.homepage      = "https://ttytoolkit.org"
  spec.license       = "MIT"
  if spec.respond_to?(:metadata=)
    spec.metadata = {
      "allowed_push_host" => "https://rubygems.org",
      "bug_tracker_uri"   => "https://github.com/piotrmurach/tty-color/issues",
      "changelog_uri"     => "https://github.com/piotrmurach/tty-color/blob/master/CHANGELOG.md",
      "documentation_uri" => "https://www.rubydoc.info/gems/tty-color",
      "funding_uri"       => "https://github.com/sponsors/piotrmurach",
      "homepage_uri"      => spec.homepage,
      "source_code_uri"   => "https://github.com/piotrmurach/tty-color"
    }
  end
  spec.files         = Dir["lib/**/*"]
  spec.extra_rdoc_files = ["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0.0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0"
end

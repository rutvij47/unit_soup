# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "unit_soup/version"

Gem::Specification.new do |spec|
  spec.name          = "unit_soup"
  spec.version       = UnitSoup::VERSION
  spec.authors       = ["Rutvij"]
  spec.email         = ["code@rutvijshah.com"]

  spec.summary       = %q{A DRY approach to unit conversion.}
  spec.description   = %q{A DRY approach to unit conversion. Define rules, make soup, convert.}
  spec.homepage      = "http://www.rutvijshah.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", '~> 3.5', '>= 3.5.0'
end

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kono_utils_helpers/version"

Gem::Specification.new do |spec|
  spec.name = "kono_utils_helpers"
  spec.version = KonoUtilsHelpers::VERSION
  spec.authors = ["Marino Bonetti"]
  spec.email = ["marinobonetti@gmail.com"]

  spec.summary = "Gem containing all KonoUtils Helpers external of the core"
  spec.description = %q{Gem containing all KonoUtils Helpers external of the core}
  spec.homepage = "https://github.com/ArchimediaZerogroup/KonoUtilsHelpers"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) {|f| File.basename(f)}
  spec.require_paths = ["lib"]

  spec.add_dependency 'active_type'
  spec.add_dependency 'activesupport', '>= 4.2'
  spec.add_dependency 'actionview'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

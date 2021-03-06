# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'impale/json_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'impale-json-api'
  spec.version       = Impale::JsonApi::VERSION
  spec.authors       = ['Sebyx07']
  spec.email         = ['gore.sebyx@yahoo.com']

  spec.summary       = %q{Gem for serializing objects to the json-api format}
  spec.description   = %q{Easy way to serialize objects to the json api format}
  spec.homepage      = 'https://github.com/impale/impale-json-api'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end

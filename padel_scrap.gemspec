# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'padel_scrap/version'

Gem::Specification.new do |spec|
  spec.name          = 'padel_scrap'
  spec.version       = PadelScrap::VERSION
  spec.authors       = ['Raúl Marcos, César Monteserín']
  spec.email         = ['raulmarcosl@gmail.com']
  spec.summary       = %q{Get available padel courts given a day and an hour}
  spec.description   = ''
  spec.homepage      = ''
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.1'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'byebug', '~> 3.5', '>= 3.5.1'

  spec.add_dependency 'mechanize', '~> 2.7.3'
end

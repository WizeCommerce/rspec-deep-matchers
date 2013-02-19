# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'deep/version'

Gem::Specification.new do |s|
  s.name        = 'rspec-deep-matchers'
  s.version     = Deep::Matchers::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['vitalish']
  s.email       = ['vitalish@4life.com.ua']
  s.homepage    = 'http://github.com/vitalish/rspec-deep-matchers'
  s.summary     = %q{Deep Hash (& some Objects) matcher for rspec}
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'rspec', '>= 2.0.0'
end

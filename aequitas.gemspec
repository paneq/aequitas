# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'aequitas/version'

Gem::Specification.new do |s|
  s.name        = 'aequitas'
  s.version     = Aequitas::VERSION
  s.authors     = ['Emmanuel Gomez']
  s.email       = ['emmanuel.gomez@gmail.com']
  s.homepage    = 'https://github.com/emmanuel/aequitas'
  s.summary     = %q{Library for performing validations on Ruby objects.}
  s.description = %q{Library for validating Ruby objects with rich metadata support.}

  # git ls-files
  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = []
  s.require_paths = ['lib']

  s.add_dependency('backports',           '~> 2.6.4')
  s.add_dependency('anima',               '~> 0.0.1')
  s.add_dependency('adamantium',          '~> 0.0.3')
  s.add_dependency('equalizer',           '~> 0.0.1')
  s.add_dependency('abstract_type',       '~> 0.0.2')
  s.add_dependency('descendants_tracker', '~> 0.0.1')
end

# -*- encoding: utf-8 -*-
require_relative 'lib/better_cli/version'

Gem::Specification.new do |s|
  s.name = 'better_cli'
  s.version = BetterCli::VERSION

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.require_paths = ['lib']
  s.authors = ['Benjamin Smith']
  s.date = '2017-12-26'
  s.email = 'sodalane.ristu@gmail.com'
  s.extra_rdoc_files = [
    'LICENSE.txt',
    'README.adoc'
  ]
  s.files = [
    'Gemfile',
    'Gemfile.lock',
    'LICENSE.txt',
    'README.adoc'
  ].concat(`git ls-files bin lib`.split("\n"))
  s.homepage = 'http://github.com/babelfish/better_cli'
  s.licenses = ['MIT']
  s.rubygems_version = '2.7.3'
  s.summary = 'A better command line interface framework'
  s.description = 'better_cli was created due to dissatisfaction with the existing options for building command line interfaces in Ruby. It aims to provide a fully-featured framework with an easy to use Ruby DSL.'

  s.required_ruby_version = '>= 2.0.0'

  s.add_development_dependency('yard', ['~> 0.9'])
  s.add_development_dependency('rspec', ['~> 3.7'])
  s.add_development_dependency('bundler', ['~> 1.16'])
  s.add_development_dependency('simplecov', ['>= 0'])
end


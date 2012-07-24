#c -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'language/version'

Gem::Specification.new do |s|
  s.name = "language"
  s.version = Language::VERSION
  s.platform    = Gem::Platform::RUBY

  s.authors     = ["Colibri Software"]
  s.email       = "info@colibri-software.com"
  s.homepage    = "http://www.colibri-software.com"
  s.summary     = "Locomotive plugin for detecting language"
  s.description = "This plugin detects the current language which the user accepts"

  s.add_dependency 'locomotive_plugins',    '~> 0.0.1'
  s.add_dependency 'rack-accept'
  s.add_dependency 'iso-639'

  s.required_rubygems_version = ">= 1.3.6"

  s.files           = Dir['Gemfile', '{lib}/**/*']
  s.require_paths   = ["lib"]
end

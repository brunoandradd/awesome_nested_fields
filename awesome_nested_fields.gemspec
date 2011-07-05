# -*- encoding: utf-8 -*-
require File.expand_path('../lib/awesome_nested_fields/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'awesome_nested_fields'
  s.version     = AwesomeNestedFields::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = %q[Bruno Andrade]
  s.email       = %q[bruno77sa@gmail.com.br]
  s.description = 'Awesome dynamic nested fields for Rails and jQuery'
  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency 'bundler', '>= 1.0.0'
  s.add_runtime_dependency 'rails', '>= 3.0.0'
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end

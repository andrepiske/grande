# frozen_string_literal: true
require File.expand_path('./lib/grande/version', __dir__)

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.version     = Grande::VERSION

  s.name        = 'grande'
  s.summary     = 'Superpower your small but grande app'
  s.description = <<-AAA
    Opinionated starting point for creating ruby apps.
    Designed to create APIs or Web apps.
  AAA

  s.author      = 'André D. Piske'
  s.email       = 'andrepiske@gmail.com'
  s.homepage    = 'https://github.com/andrepiske/grande'

  s.license     = 'MIT'

  s.files       = Dir.glob([
    'lib/**/*.rb',
    'README.md',
    'MIT-LICENSE'
  ])
end

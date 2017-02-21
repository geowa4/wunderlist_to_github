# frozen_string_literal: true
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wunderlist_to_github/version'

def spec_basics(spec)
  spec.name          = 'wunderlist_to_github'
  spec.version       = WunderlistToGithub::VERSION
  spec.authors       = ['George Adams IV (geowa4)']
  spec.email         = ['g.w.adams.iv@gmail.com']

  spec.summary       = 'Converts tasks from Wunderlist to GitHub.'
  spec.description   = 'This utility connects to your accounts to transfer ' \
                       'tasks from a given Wunderlist list to ' \
                       'a given repository on GitHub.'
  spec.homepage      = 'https://github.com/geowa4/wunderlist_to_github'
end

def add_dependencies(spec)
  spec.add_runtime_dependency 'thor', '~> 0.19'
  spec.add_runtime_dependency 'wunderlist-api', '~> 1.1'
  spec.add_runtime_dependency 'github_api', '~> 0.14'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.47'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-mocks', '~> 3.5'
  spec.add_development_dependency 'pry', '~> 0.10'
end

Gem::Specification.new do |spec|
  spec_basics(spec)

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  add_dependencies(spec)
end

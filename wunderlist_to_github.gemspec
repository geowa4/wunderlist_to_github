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
  spec.homepage      = 'https://geowa4.software'
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

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host' to allow pushing to a
  # single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  add_dependencies(spec)
end

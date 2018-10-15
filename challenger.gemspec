# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'challenger/version'

Gem::Specification.new do |spec|
  spec.name          = 'challenger'
  spec.version       = Challenger::VERSION
  spec.authors       = ['ryosuke_sato']
  spec.email         = ['r-sato@feedforce.jp']

  spec.summary       = 'Help to run `$ rubocop -a` on your CI'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/ryz310/challenger'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'pr-daikou', '~> 0.2.0'
  spec.add_runtime_dependency 'rubocop'
  spec.add_runtime_dependency 'rubocop-rspec'
  spec.add_runtime_dependency 'thor'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec_junit_formatter'
end

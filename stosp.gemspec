# frozen_string_literal: true

require_relative "lib/stosp/config"

Gem::Specification.new do |spec|
  spec.name = "stosp"
  spec.version = Stosp::VERSION
  spec.authors = ['Keallar']
  spec.email = ['zlysanskiy@gmail.com']

  spec.summary = "Client for 100sp API."
  spec.description = "Client for 100sp API."
  spec.homepage = "https://github.com/Keallar/stosp"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'httparty'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'simplecov'
end

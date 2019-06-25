
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "botspec/version"

Gem::Specification.new do |gem|
  gem.name          = "botspec"
  gem.version       = Botspec::VERSION
  gem.authors       = ["Elliott Murray"]
  gem.email         = ["elliottmurray@gmail.com"]

  gem.summary       = %q{Acceptance tests for bots}
  gem.description   = %q{Acceptance tests for bots}
  gem.homepage      = "https://github.com/elliottmurray/botspec"
  gem.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if gem.respond_to?(:metadata)
    gem.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gem.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  gem.bindir        = "exe"
  #gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }

#  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "rspec", "~> 3.0"
  gem.add_runtime_dependency 'term-ansicolor', '~> 1.0'
  gem.add_runtime_dependency 'aws-sdk', "~> 3.0.1"
  #gem.add_runtime_dependency 'aws-sdk-lex', '~> 1'
  #gem.add_runtime_dependency 'aws-sdk-lexmodelbuildingservice', '~> 1'
  gem.add_runtime_dependency 'thor', "~> 0.20.0"
  gem.add_runtime_dependency 'hashie', "~> 3.6.0"

  gem.add_development_dependency "bundler", "~> 1.16"

  gem.add_development_dependency "guard-rspec", "~> 4.7"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "byebug"

  gem.add_development_dependency 'conventional-changelog', '~> 1.3'
  gem.add_development_dependency 'bump', '~> 0.6.1'
end

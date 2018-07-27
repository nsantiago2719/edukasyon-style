
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "edukasyon/style/version"

Gem::Specification.new do |spec|
  spec.name          = "edukasyon-style"
  spec.version       = Edukasyon::Style::VERSION
  spec.authors       = ["Ace Dimasuhid"]
  spec.email         = ["ace.dimasuhid@gmail.com"]

  spec.summary       = "Style and rubocop guide for Edukasyon"
  spec.description   = %"Style and rubocop guide for Edukasyon"
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rubocop", "~> 0.58.2"
  spec.add_dependency "rubocop-rspec", "~> 1.24"

  spec.add_runtime_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end

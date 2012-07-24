# -*- encoding: utf-8 -*-
require File.expand_path('../lib/amy_admin/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["dongbin li"]
  gem.email         = ["mike.d.1984@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "amy_admin"
  gem.require_paths = ["lib"]
  gem.version       = AmyAdmin::VERSION
end

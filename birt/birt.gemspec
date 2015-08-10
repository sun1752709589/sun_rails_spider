$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "birt/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "birt"
  s.version     = Birt::VERSION
  s.authors = ["saxer"]
  s.email = ["15201280641@qq.com"]
  s.homepage    = "http://www.baidu.com"
  s.summary     = "birt report"
  s.description = "birt report"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,rails}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ["lib","lib/core","lib/core/chart","lib/core/table"]
  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "bundler", "~> 1.9"
  s.add_development_dependency "rake", "~> 10.4"

  s.add_runtime_dependency "core_extend", "~> 0.1.5"
  s.add_runtime_dependency "highcharts-rails", "~> 4.1"
  s.add_runtime_dependency "mysql2","~> 0.3.18"
end

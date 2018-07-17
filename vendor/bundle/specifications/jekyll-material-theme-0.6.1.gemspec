# -*- encoding: utf-8 -*-
# stub: jekyll-material-theme 0.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-material-theme".freeze
  s.version = "0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["James Hamann".freeze]
  s.date = "2018-07-03"
  s.email = ["jameshamann0@gmail.com".freeze]
  s.homepage = "https://github.com/jameshamann/jekyll-material-theme".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.7".freeze
  s.summary = "A Material Theme for Jekyll".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jekyll>.freeze, ["~> 3.5"])
      s.add_runtime_dependency(%q<jekyll-assets>.freeze, ["~> 3.0"])
      s.add_runtime_dependency(%q<jekyll-minifier>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<jekyll-feed>.freeze, ["~> 0.9"])
      s.add_runtime_dependency(%q<kramdown>.freeze, ["~> 1.16"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.12"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<capybara>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_development_dependency(%q<selenium-webdriver>.freeze, ["~> 3.8"])
    else
      s.add_dependency(%q<jekyll>.freeze, ["~> 3.5"])
      s.add_dependency(%q<jekyll-assets>.freeze, ["~> 3.0"])
      s.add_dependency(%q<jekyll-minifier>.freeze, ["~> 0.1"])
      s.add_dependency(%q<jekyll-feed>.freeze, ["~> 0.9"])
      s.add_dependency(%q<kramdown>.freeze, ["~> 1.16"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<capybara>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_dependency(%q<selenium-webdriver>.freeze, ["~> 3.8"])
    end
  else
    s.add_dependency(%q<jekyll>.freeze, ["~> 3.5"])
    s.add_dependency(%q<jekyll-assets>.freeze, ["~> 3.0"])
    s.add_dependency(%q<jekyll-minifier>.freeze, ["~> 0.1"])
    s.add_dependency(%q<jekyll-feed>.freeze, ["~> 0.9"])
    s.add_dependency(%q<kramdown>.freeze, ["~> 1.16"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<capybara>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
    s.add_dependency(%q<selenium-webdriver>.freeze, ["~> 3.8"])
  end
end

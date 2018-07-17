# -*- encoding: utf-8 -*-
# stub: jekyll-minifier 0.1.6 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-minifier".freeze
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["DigitalSparky".freeze]
  s.date = "2018-04-24"
  s.description = "Jekyll Minifier using htmlcompressor for html, uglifier for js and css".freeze
  s.email = ["matthew@spurrier.com.au".freeze]
  s.homepage = "http://github.com/digitalsparky/jekyll-minifier".freeze
  s.licenses = ["GPL-3.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "2.7.7".freeze
  s.summary = "Jekyll Minifier for html, css, and javascript".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jekyll>.freeze, ["~> 3.5"])
      s.add_runtime_dependency(%q<uglifier>.freeze, ["~> 3.2"])
      s.add_runtime_dependency(%q<htmlcompressor>.freeze, ["~> 0.3"])
      s.add_runtime_dependency(%q<cssminify2>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.4"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.7"])
      s.add_development_dependency(%q<jekyll-paginate>.freeze, [">= 0"])
      s.add_development_dependency(%q<redcarpet>.freeze, [">= 0"])
    else
      s.add_dependency(%q<jekyll>.freeze, ["~> 3.5"])
      s.add_dependency(%q<uglifier>.freeze, ["~> 3.2"])
      s.add_dependency(%q<htmlcompressor>.freeze, ["~> 0.3"])
      s.add_dependency(%q<cssminify2>.freeze, ["~> 2.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.4"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.7"])
      s.add_dependency(%q<jekyll-paginate>.freeze, [">= 0"])
      s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<jekyll>.freeze, ["~> 3.5"])
    s.add_dependency(%q<uglifier>.freeze, ["~> 3.2"])
    s.add_dependency(%q<htmlcompressor>.freeze, ["~> 0.3"])
    s.add_dependency(%q<cssminify2>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.4"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.7"])
    s.add_dependency(%q<jekyll-paginate>.freeze, [">= 0"])
    s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
  end
end

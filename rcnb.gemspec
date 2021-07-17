require File.expand_path("../lib/rcnb/version", __FILE__)

Gem::Specification.new do |s|
  s.name = 'rcnb'
  s.version = RCNB::VERSION
  s.summary = 'a ruby implementation of RCNB'
  # s.description = 'a ruby implementation of RCNB'
  s.author = 'liggest'
  s.files = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md", ".yardopts"]
  s.executable = 'rcnb-rb'
  s.homepage = 'https://github.com/liggest/rcnb.rb'
  s.license = 'MIT' 
  s.post_install_message = '流石RC，的确NB'
end
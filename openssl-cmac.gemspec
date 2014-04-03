# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openssl/cmac/version'

Gem::Specification.new do |s|
  s.name                  = 'openssl-cmac'
  s.version               = OpenSSL::CMAC::VERSION
  s.required_ruby_version = '>= 2.0.0'
  s.date                  = '2014-04-02'
  s.authors               = ['Maxim M. Chechel', 'Lars Schmertmann']
  s.email                 = ['maximchick@gmail.com', 'SmallLars@t-online.de']
  s.summary               = 'RFC 4493, 4494, 4615 - CMAC'
  s.description           = 'Ruby Gem for RFC 4493, 4494, 4615 - The AES-CMAC Algorithm'
  s.homepage              = 'https://github.com/smalllars/openssl-cmac'
  s.license               = 'MIT'
  s.post_install_message  = "Thanks for installing!"

  s.files      = Dir.glob('lib/openssl/*.rb') +
                 Dir.glob("lib/openssl/cmac/*.rb") + 
                 ['Gemfile', 'Rakefile', '.rubocop.yml', '.yardopts']
  s.test_files = Dir.glob('test/test_*.rb') + Dir.glob('test/data_*')

  s.add_development_dependency 'rake', '~> 10.2', '>= 10.2.2'
  s.add_development_dependency 'rdoc', '~> 4.1', '>= 4.1.1'
  s.add_development_dependency 'yard', '~> 0.8', '>= 0.8.7.3'
  s.add_development_dependency 'rubocop', '~> 0.18', '>= 0.18.1'
  s.add_development_dependency 'coveralls', '~> 0.7', '>= 0.7.0'

  s.rdoc_options += ['-x', 'test/data_*']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
end

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openssl/cmac/version'

Gem::Specification.new do |s|
  s.name                  = 'openssl-cmac'
  s.version               = OpenSSL::CMAC::VERSION
  s.required_ruby_version = '>= 2.0.0'
  s.authors               = ['Maxim M. Chechel', 'Lars Schmertmann']
  s.email                 = ['maximchick@gmail.com', 'SmallLars@t-online.de']
  s.summary               = 'RFC 4493, 4494, 4615 - CMAC'
  s.description           = 'Ruby Gem for RFC 4493, 4494, 4615 - The AES-CMAC Algorithm'
  s.homepage              = 'https://github.com/smalllars/openssl-cmac'
  s.license               = 'MIT'
  s.post_install_message  = 'Thanks for installing!'

  s.files = Dir.glob('lib/**/*.rb') +
            %w[LICENSE README.md]

  s.rdoc_options += ['-x', 'test/data_*']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.metadata = {
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => 'https://github.com/smalllars/openssl-cmac'
  }
end

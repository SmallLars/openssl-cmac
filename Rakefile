require './lib/openssl/cmac/version'
require 'rake/testtask'
require 'rake/clean'
require 'rubocop/rake_task'

task default: %i[rubocop test doc]

desc 'Run tests'
Rake::TestTask.new do |t|
  t.pattern = 'test/test_*.rb'
  t.verbose = true
end

desc 'Create documentation'
task :doc do
  sh 'gem rdoc --rdoc openssl-cmac'
  sh 'yardoc'
end

CLEAN.include('coverage')
CLEAN.include('doc')
CLEAN.include('.yardoc')
CLEAN.include("openssl-cmac-#{OpenSSL::CMAC::VERSION}.gem")

RuboCop::RakeTask.new

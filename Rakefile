#!/usr/bin/env rake
require 'rake/testtask'
require 'foodcritic'

begin
  require 'emeril/rake'
rescue LoadError
  puts ">>>>> Emeril gem not loaded, omitting tasks" unless ENV['CI']
end

FoodCritic::Rake::LintTask.new do |t|
  t.options = { :fail_tags => ['any'] }
end

Rake::TestTask.new do |t|
  t.name = "unit"
  t.test_files = FileList['test/unit/**/*_spec.rb']
  t.verbose = true
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> test-kitchen gem not loaded, omitting tasks" unless ENV['CI']
end

desc "Run all test suites"
task :test_all => [:default, :kitchen]

task :default => [:foodcritic, :unit]

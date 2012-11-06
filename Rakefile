#!/usr/bin/env rake
require 'rake/testtask'
require 'foodcritic'

FoodCritic::Rake::LintTask.new do |t|
  t.options = { :fail_tags => ['any'] }
end

desc "Run post-convergence/integration tests"
task :integration do
  sh "kitchen test"
end

desc "Run all test suites"
task :test_all => [:default, :integration]

task :default => [:foodcritic]

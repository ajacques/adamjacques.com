#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ResumeWebsite::Application.load_tasks

if Rails.env.test? || Rails.env.development?
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  task default: %i[rubocop]
end

task :optimize do
  # Start the server and kill it after it's had a chance to initialize
  pid = Process.spawn('unicorn --no-default-middleware')
  death = Time.now + 10
  interrupted = false
  trap('INT') do
    interrupted = true
  end
  until interrupted || Time.now > death do
    sleep 1
  end
  Process.kill('TERM', pid)
end

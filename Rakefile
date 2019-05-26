#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('config/application', __dir__)

ResumeWebsite::Application.load_tasks

if Rails.env.test? || Rails.env.development?
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  task default: %i[rubocop]
end

def http_get(url)
  require 'net/http'

  uri = URI.parse(url)
  req = Net::HTTP::Get.new(uri.to_s)
  Net::HTTP.start(uri.host, uri.port) do |http|
    http.request(req)
  end
end

task :optimize do
  # Start the server and kill it after it's had a chance to initialize
  pid = Process.spawn({ 'RAILS_ENV' => 'production', 'SECRET_KEY_BASE' => 'none' }, 'unicorn --no-default-middleware')
  death = Time.now.utc + 10
  interrupted = false
  trap('INT') do
    interrupted = true
  end
  sleep 1 until interrupted || Time.now.utc > death
  Process.kill('TERM', pid)
end

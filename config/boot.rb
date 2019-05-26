# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

if ENV['RAILS_ENV'] == 'production'
  require 'bootsnap'
  Bootsnap.setup(
    cache_dir: 'var/bootsnap',
    development_mode: false,
    load_path_cache: true,
    autoload_paths_cache: true,
    compile_cache_iseq: true,
    compile_cache_yaml: true
  )
end

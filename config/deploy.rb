set :application, "yatay-web"
set :scm, :git
set :repository,  "git@github.com:alejandc/yatay-web.git"
set :branch, "master"

set :rails_env, "production"
set :user, "server"

set :deploy_to, "/var/www/#{application}"
set :deploy_via, :copy
#set :copy_cache, true

role :app, ""
role :web, "localhost"
role :db,  "localhost", :primary => true

# Add RVM's lib directory to the load path.
set :rvm_ruby_string, 'ruby-1.9.3-p392@yatay'
	
# Load RVM's capistrano plugin.
require "rvm/capistrano"
require "bundler/capistrano"
require "capistrano-unicorn"

load "deploy/assets"

set :keep_releases, 3

default_run_options[:pty] = true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :db do
  desc "Populates production database"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end
end

task :symlinks do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  sudo "chown -R www-data:www-data #{current_release}"
end

# if you want to clean up old releases on each deploy uncomment this:
after  "deploy:restart", "deploy:cleanup"
after  "deploy:restart", "resque:restart"
after  "deploy:update", "newrelic:notice_deployment"
after  "deploy", "deploy:migrate"
before "deploy:assets:precompile", "symlinks"
before "deploy:restart", "unicorn:stop"
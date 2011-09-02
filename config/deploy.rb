# RVM bootstrap
$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2@pythoncampus'
set :rvm_type, :user

# bundler bootstrap
require 'bundler/capistrano'

ssh_options[:port] = 110

set :application, "pythoncampus"
set :rails_apps, "/home/rails/apps"
set :deploy_to, "#{rails_apps}/#{application}"

server "200.143.198.44", :app, :web, :db, :primary => true

default_run_options[:pty] = true

set :repository, 'git://github.com/nsi-iff/pythoncampus-iff-site.git'
set :scm, 'git'
set :branch, 'master'
set :deploy_via, :copy

set :user, 'rails'

namespace :deploy do
  desc 'Restart Application'
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

task :copy_configuration_files, :roles => :app do
  run "cp #{rails_apps}/_config/#{application}/database.yml #{deploy_to}/current/config/database.yml"
  run "cp #{rails_apps}/_config/#{application}/mail.yml #{deploy_to}/current/config/mail.yml"
end

before "deploy:restart", :copy_configuration_files


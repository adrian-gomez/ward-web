lock '3.5.0'

set :application, 'ward-server'
set :repo_url, 'git@github.com:adrian-gomez/ward-web.git'

set :deploy_to, "/home/ubuntu/#{fetch(:application)}"

# Default value for :pty is false
set :pty, true

set :linked_files, fetch(:linked_files, []).push('config/mongoid.yml', 'config/secrets.yml')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

set :rvm1_ruby_version, '2.2.3'
set :rvm1_alias_name, 'ward-server-ruby'

set :passenger_in_gemfile, true
set :passenger_restart_with_touch, true
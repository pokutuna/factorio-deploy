# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "factorio-deploy"
set :repo_url, "https://github.com/pokutuna/factorio-deploy.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/apps/factorio-deploy'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "factorio"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 2

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# supervisor
set :supervisor_user, 'deploy'
set :supervisor_server_confd, '/etc/supervisor/conf.d/'
set :supervisor_conf_path, 'config/factorio-deploy.supervisord.conf'
load 'modules/pokloy-recipes/recipes/supervisor.rb'

namespace :deploy do
  task :restart do
    on roles(:app) do
      invoke 'supervisor:restart_app'
    end
  end

  after :publishing, :restart
end

task :setup do
  on roles(:app) do
    invoke 'supervisor:setup'
    execute :sudo, :chown, '-R', "845:845", '/home/pokutuna/apps/factorio-deploy/shared/factorio'
  end
end

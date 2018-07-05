lock "~> 3.10.1"

set :user, 'deploy'
set :group, 'deploy'
set :application, "lovedaddy"
set :repo_url, "git@github.com:horizon-company/lovedaddy.git"

set :deploy_to, "/var/www/vhost/#{fetch(:application)}"
set :format, :pretty
set :log_level, :debug
set :pty, true

set :rbenv_type, :system # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.5.1'

append :linked_files, "config/secrets.yml", ".env"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor/bundle"

set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  Rake::Task["deploy:check:directories"].clear

  namespace :check do
    desc '(overwrite) Check shared and release directories exist'
    task :directories do
      on release_roles :all do
        execute :sudo, :mkdir, '-pv', shared_path, releases_path
        execute :sudo, :chown, '-R', "#{fetch(:user)}:#{fetch(:group)}", deploy_to
      end
    end
  end

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end

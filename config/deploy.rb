lock '3.6.1'

set :application, :tender_ruda
set :repo_url, 'git@bitbucket.org:lutsko86/tender_ruda.git'
set :rvm_type, :system
set :rvm_ruby_version, '2.0.0-p247'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

#set :sidekiq_monit_use_sudo, false

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# Default value for default_env is {}
# set :default_env, { path: "/opt/deploy/bin:$PATH" }

#параметры для неймспейса в файле крона в зависимости от названия и рабочей среды приложения.
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
      #execute :curl, 'http://localhost:81 -ks > /dev/null'
      #execute :start, 'workers'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :rake do
  desc 'Run a task on a remote server.'
  # run like: cap staging rake:invoke task=a_certain_task
  task :invoke do
    run("cd #{deploy_to}/current; bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}")
  end
end

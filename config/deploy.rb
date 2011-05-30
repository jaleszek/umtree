set :stages, %w{staging production}
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :scm, :git
set :user, "dasdsad2"
set :deploy_via, :remote_cache
set :scm_verbose, true
set :user_sudo, false

set :rails_env, "production"

role :web, "77.79.227.20"
role :app, "77.79.227.20"
role :db, "77.79.227.20", :primary => true

namespace :deploy do 
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "restart-app #{application}"
  end
end
# compile sass
# jammit things

namespace :bundler do
  task: :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    released_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{released_dir}")
  end  
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
  end
end

namespace :copy do
  task :config do
    run "cp #{current_path}/config/database.yml #{release_path}/config"
    run "cp #{current_path}/config/application.rb #{release_path}/config/"
  end
end


after 'deploy:update_code', 'bundler:bundle_new_release'
after 'deploy:update_code', 'copy:config'
after 'deploy:update_code', 'deploy:migrate'



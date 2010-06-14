set :application, "master"
#set :repository,  "http://github.com/dashnotes/master.git"
set :repository,  "."
set :deploy_to,     "/var/www/#{application}"
set :deploy_via,    :remote_cache
set :scm, :git

role :web, 'keeper'
role :app, 'keeper'                          # This may be the same as your `Web` server
role :db,  'keeper', :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end

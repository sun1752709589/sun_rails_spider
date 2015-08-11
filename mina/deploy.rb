require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv' # for rbenv support. (http://rbenv.org)
require 'mina/rvm' # for rvm support. (http://rvm.io)
require 'mina_notify'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, '121.40.117.95'
set :deploy_to, '/var/www/statistics_on_birt'
set :repository, 'git@bitbucket.org:Xiaopuzhu/statistics_on_birt.git'
set :branch, 'develop'

# Optional settings:
set :user, 'root' # Username in the server to SSH to.
set :port, '19009' # SSH port number.

# For system-wide RVM install.
#   set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/puma.rb', 'log', 'tmp']

# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

set :rvm_path, '/usr/local/rvm/scripts/rvm'
set :app_path, lambda { "#{deploy_to}/#{current_path}" }

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  #invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use[2.1.5]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  MinaNotify.trigger_event(self, :setup)
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]
  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/puma.rb"]
  queue %[echo "-----> Be sure to edit 'shared/config/puma.rb'."]

end

desc "Deploys the current version to the server."
task :deploy => :environment do
  MinaNotify.trigger_event(self, :deploy)
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue "cd #{app_path} ; bundle install --without nothing"
      invoke :restart
    end
  end
end

desc 'Starts the application'
task :start => :environment do
  MinaNotify.trigger_event(self, :start)
  queue "cd #{app_path} ; bundle exec puma -C config/puma.rb -e production -d"
  # queue "cd #{app_path} ; bundle exec puma"
  # queue "cd #{app_path} ; bundle exec pumactl -F config/puma.rb start"
end

desc 'Stop the application'
task :stop => :environment do
  MinaNotify.trigger_event(self, :stop)
  queue "cd #{app_path} ; bundle exec pumactl -P #{app_path}/tmp/pids/puma.pid stop"
end

desc 'Restart the application'
task :restart => :environment do
  MinaNotify.trigger_event(self, :restart)
  # queue "cd #{app_path} ; bundle exec pumactl -P #{app_path}/tmp/pids/puma.pid restart"
  invoke :stop
  invoke :start
end
desc 'force_unlock mina deploy'
task :force_unlock do
  MinaNotify.trigger_event(self, :force_unlock)
  queue! %[rm -rf "#{deploy_to}/deploy.lock"]
  queue %[echo "-----> rm -rf #{deploy_to}/deploy.lock"]
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

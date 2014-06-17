require 'sinatra/activerecord/rake'

task :environment do
  require './objspace_viewer'
end


task "db:migrate" => :environment
task "db:rollback" => :environment


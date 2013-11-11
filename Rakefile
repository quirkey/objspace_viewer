require 'sinatra/activerecord/rake'

task :environment do
  require './objspace_viewer'
end

namespace :objspace_viewer  do
  task :import => :environment do 
    HeapEntry.import_file(ENV['FILE'])
  end
end

task "db:migrate" => :environment
task "db:rollback" => :environment


require 'sinatra/activerecord/rake'

task :environment do
  require './objspace_viewer'
end

namespace :objspace_viewer  do
  task :import => :environment do 
    dump = File.open(ENV['FILE'], 'r')
    keys ||= []
    total = 0
    errors = 0
    heap = Heap.new
    heap.name = ENV['FILE']
    heap.save
    dump.each_line do |line|
      entry = HeapEntry.import(heap, line)
      if entry
        total += 1
        print '.'
      else
        errors += 1
        print 'E'
      end
    end
    puts 
    puts "Total #{total} Errors #{errors}"
  end
end

task "db:migrate" => :environment
task "db:rollback" => :environment


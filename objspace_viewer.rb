require 'bundler'
Bundler.require

# require 'compass'

# MultiJson.engine = :yajl
Dir.glob('./models/*.rb') do |model|
  require model
end


class ObjspaceViewer < Sinatra::Application

  configure do
    set :database, ENV['DATABASE_URL'] || 'postgres://localhost/objspace_development'
    set :root, File.dirname(__FILE__)
    # Compass.add_project_configuration(File.join(root, 'config', 'compass.rb'))
    set :haml, { :format => :html5 }
    # set :scss, Compass.sass_engine_options
    ActiveRecord::Base.logger = Logger.new("./log/#{environment}.log")
  end

end

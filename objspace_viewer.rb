require 'bundler'
Bundler.require

# require 'compass'

MultiJson.engine = :yajl

class ObjspaceViewer < Sinatra::Application

  configure do
    set :database, ENV['DATABASE_URL'] || 'postgres://localhost/objspace_development'
    set :root, File.dirname(__FILE__)
    # Compass.add_project_configuration(File.join(root, 'config', 'compass.rb'))
    set :haml, { :format => :html5 }
    # set :scss, Compass.sass_engine_options
  end

end

require 'bundler'
Bundler.require

# require 'compass'

Dir.glob('./models/*.rb') do |model|
  require model
end

class ObjspaceViewer < Sinatra::Application

  configure do
    set :database, ENV['DATABASE_URL'] || 'postgres://localhost/objspace_development'
    set :root, File.dirname(__FILE__)
    # Compass.add_project_configuration(File.join(root, 'config', 'compass.rb'))
    set :haml, { :format => :html5, :escape_html => true }
    # set :scss, Compass.sass_engine_options
    ActiveRecord::Base.logger = Logger.new("./log/#{environment}.log")
  end

  get "/heaps/:id" do
    @heap = Heap.find params[:id]
    haml :heap
  end

  get "/heaps/:id/entry/:address" do
    @heap = Heap.find params[:id]
    @entry = @heap.heap_entries.find_by_heap_address(params[:address])
    haml :heap_entry
  end

  helpers do
    def address_link(heap, address)
      "<a href='/heaps/#{heap.id}/entry/#{address}'>#{address}</a>"
    end
  end

end

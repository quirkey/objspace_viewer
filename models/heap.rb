class Heap < ActiveRecord::Base
  has_many :heap_entries

  def largest_objects
    heap_entries.where('memsize > 0').order('memsize DESC').limit(15)
  end

end

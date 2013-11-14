class Heap < ActiveRecord::Base
  has_many :heap_entries

  def largest_by(field)
    heap_entries.where("#{field} > 0").order(field => :desc).limit(15)
  end

end

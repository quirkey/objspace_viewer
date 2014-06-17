class Heap < ActiveRecord::Base
  has_many :heap_entries

  def largest_by(field)
    heap_entries.where("#{field} > 0").order(field => :desc).limit(30)
  end

  def most_references
    HeapEntry.find_by_sql [%{
      SELECT heap_entries.*,
      COUNT(1) AS num_references
      FROM heap_entries
      INNER JOIN heap_references ON
      heap_references.heap_id = heap_entries.heap_id AND
      heap_references.from_address = heap_entries.heap_address
      GROUP BY heap_entries.id
      ORDER by num_references DESC
      LIMIT 10
    }]
  end

end

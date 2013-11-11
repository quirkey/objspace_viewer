class HeapEntry < ActiveRecord::Base
  #belongs_to :heap

  def self.import(heap, j)
    begin
      json = MultiJson.load(j)
    rescue => e
      warn e
      return false
    end
    doc = HeapEntry.new
    doc.heap_id = heap.id
    doc.heap_address = json['address']
    doc.entry_type = json['type']
    doc.class_address = json['class']
    doc.encoding = json['encoding']
    doc.is_embedded = json['embedded']
    doc.is_shared = json['shared']
    doc.is_frozen = json['frozen']
    doc.is_associated = json['associated']
    doc.value = json['value']
    doc.bytesize = json['bytesize']
    doc.size = json['size']
    doc.memsize = json['memsize']
    doc.capacity = json['capacity']
    doc.length = json['length']
    doc.fd = json['fd']
    doc.node_type = json['node_type']
    doc.name = json['name']
    doc.root = json['root']
    doc.save!
    if json['references']
      json['references'].each do |ref|
        reference = HeapReference.new
        reference.heap_id = heap.id
        reference.from_address = ref
        reference.to_address = json['address'] || json['root']
        reference.save!
      end
    end
    doc
  end

end

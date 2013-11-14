class HeapEntry < ActiveRecord::Base
  belongs_to :heap

  def self.import_file(filename, batch_size = 100)
    dump = File.open(filename, 'r')
    pbar = ProgressBar.create(:format => '%a |%b>>%i| %p%% %t', :total => dump.size)
    keys ||= []
    total = 0
    errors = 0
    heap = Heap.new
    heap.name = filename
    heap.save
    entries = []
    dump.each_line do |line|
      entry = HeapEntry.import_entry(heap, line)
      pbar.progress += line.length
      if entry
        total += 1
        entries << entry
        if total % batch_size == 0
          HeapEntry.import entries
          entries = []
        end
      else
        errors += 1
      end
    end
    HeapEntry.import entries
    dump.close
    puts
    puts "Total #{total} Errors #{errors}"
  end

  def self.import_entry(heap, j)
    begin
      json = MultiJson.load(j)
    rescue => e
      warn e
      return false
    end
    doc               = HeapEntry.new
    doc.heap_id       = heap.id
    doc.heap_address  = json['address']
    doc.entry_type    = json['type']
    doc.class_address = json['class']
    doc.encoding      = json['encoding']
    doc.is_embedded   = json['embedded']
    doc.is_shared     = json['shared']
    doc.is_frozen     = json['frozen']
    doc.is_associated = json['associated']
    doc.value         = json['value']
    doc.bytesize      = json['bytesize']
    doc.size          = json['size']
    doc.memsize       = json['memsize']
    doc.capacity      = json['capacity']
    doc.length        = json['length']
    doc.fd            = json['fd']
    doc.node_type     = json['node_type']
    doc.name          = json['name']
    doc.root          = json['root']
    references = []
    if json['references']
      json['references'].each do |ref|
        reference = HeapReference.new
        reference.heap_id      = heap.id
        reference.from_address = ref
        reference.to_address   = json['address'] || json['root']
        references << reference
      end
    end
    HeapReference.import references
    doc
  end

  def truncated_value(length = 30)
    value ? value.to_s[0..length] : ""
  end

  def escaped_value
    EscapeUtils.escape_html(value || '')
  end

  def referencing_entries
    HeapEntry.find_by_sql([%{
      SELECT *
      FROM heap_entries
      WHERE heap_address IN(
        SELECT from_address
        FROM heap_references
        WHERE heap_id = ?
        AND to_address = ?
      )
      AND heap_id = ?
    }, heap_id, heap_address, heap_id])
  end

  def referenced_entries
    HeapEntry.find_by_sql([%{
      SELECT *
      FROM heap_entries
      WHERE heap_address IN(
        SELECT to_address
        FROM heap_references
        WHERE heap_id = ?
        AND from_address = ?
      )
      AND heap_id = ?
    }, heap_id, heap_address, heap_id])
  end

end

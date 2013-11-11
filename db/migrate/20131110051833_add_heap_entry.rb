class AddHeapEntry < ActiveRecord::Migration
  def up
    create_table :heaps do |t|
      t.string :name
      t.integer :size
      t.timestamps
    end

    create_table :heap_entries do |t|
      t.integer :heap_id
      t.string :heap_address, :limit => 20
      t.string :entry_type, :limit => 10
      t.string :class_address, :limit => 20
      t.string :encoding, :limit => 20
      t.boolean :is_embedded, :is_shared, :is_frozen, :is_associated
      t.text :value
      t.integer :bytesize, :size, :memsize, :capacity, :length
      t.integer :fd
      t.string :node_type, :name, :root
    end

    add_index :heap_entries, [:heap_id, :heap_address], :unique => true
    add_index :heap_entries, [:heap_id, :entry_type]
    add_index :heap_entries, [:heap_id, :class_address]

    create_table :heap_references do |t|
      t.integer :heap_id
      t.string :from_address
      t.string :to_address
    end

    add_index :heap_references, [:heap_id, :from_address]
    add_index :heap_references, [:heap_id, :to_address]
  end

  def down
    drop_table :heap_references
    drop_table :heaps
    drop_table :heap_entries
  end
end

class CreateTalks < ActiveRecord::Migration
  def self.up
    create_table :talks do |t|
      t.string :title
      t.string :description
      t.integer :slot_id

      t.timestamps
    end
  end

  def self.down
    drop_table :talks
  end
end

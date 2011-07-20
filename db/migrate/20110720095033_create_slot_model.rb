class CreateSlotModel < ActiveRecord::Migration
  def self.up
    create_table :slots, :force => true do |t|
      t.integer :room_id
      t.integer :timeslot_id
      t.timestamps
    end
  end

  def self.down
    drop_table :slots
  end
end

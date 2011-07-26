class AddSpeakerFieldToTalk < ActiveRecord::Migration
  def self.up
    add_column :talks, :speaker, :string
  end

  def self.down
    remove_column :talks, :speaker, :string
  end

end

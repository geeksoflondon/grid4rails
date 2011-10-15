class MakingTalkDescText < ActiveRecord::Migration
  def self.up
    remove_column :talks, :description
    add_column :talks, :description, :text
  end

  def self.down
    remove_column :talks, :description
    add_column :talks, :description, :string
  end
end

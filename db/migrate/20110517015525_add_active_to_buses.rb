class AddActiveToBuses < ActiveRecord::Migration
  def self.up
    add_column :buses, :active, :boolean
  end

  def self.down
    remove_column :buses, :active
  end
end

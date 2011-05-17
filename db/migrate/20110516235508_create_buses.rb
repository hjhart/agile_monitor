class CreateBuses < ActiveRecord::Migration
  def self.up
    create_table :buses do |t|
      t.string :name
      t.integer :stop_id
      t.integer :route_id
      t.string :direction_id

      t.timestamps
    end
  end

  def self.down
    drop_table :buses
  end
end

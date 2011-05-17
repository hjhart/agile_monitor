class CreateBusTimes < ActiveRecord::Migration
  def self.up
    create_table :bus_times do |t|
      t.integer :bus_id
      t.integer :minutes

      t.timestamps
    end
  end

  def self.down
    drop_table :bus_times
  end
end

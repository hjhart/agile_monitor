class AddLabelToBuild < ActiveRecord::Migration
  def self.up
    add_column :builds, :label, :string
    add_column :builds, :build_time, :datetime
    add_column :builds, :last_build_status, :string
  end

  def self.down
    remove_column :builds, :label
    remove_column :builds, :build_time
    remove_column :builds, :last_build_status
  end
end

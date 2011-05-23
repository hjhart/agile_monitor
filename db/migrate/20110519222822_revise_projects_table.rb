class ReviseProjectsTable < ActiveRecord::Migration
  def self.up
    remove_column :projects, :tracker_api_key
    remove_column :projects, :tracker_url
    add_column :projects, :label, :string
  end

  def self.down
    remove_column :projects, :label
    add_column :projects, :tracker_api_key, :string
    add_column :projects, :tracker_url, :string
  end
end

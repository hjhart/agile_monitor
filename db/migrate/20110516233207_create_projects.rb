class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :feed_url
      t.string :tracker_url
      t.string :tracker_api_key
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end

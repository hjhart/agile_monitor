class CreateBuilds < ActiveRecord::Migration
  def self.up
    create_table :builds do |t|
      t.integer :project_id
      t.string :status
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :builds
  end
end

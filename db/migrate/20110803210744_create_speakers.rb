class CreateSpeakers < ActiveRecord::Migration
  def self.up
    create_table :speakers do |t|
      t.string :name
      t.text :summary
      t.string :organization
      t.string :twitter
      t.string :github
      t.string :site

      t.timestamps
    end
  end

  def self.down
    drop_table :speakers
  end
end


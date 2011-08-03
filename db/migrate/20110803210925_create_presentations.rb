class CreatePresentations < ActiveRecord::Migration
  def self.up
    create_table :presentations do |t|
      t.string :kind
      t.string :title
      t.string :time
      t.string :room
      t.references :speaker
      t.text :summary

      t.timestamps
    end
  end

  def self.down
    drop_table :presentations
  end
end


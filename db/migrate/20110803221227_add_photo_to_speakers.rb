class AddPhotoToSpeakers < ActiveRecord::Migration
  def self.up
    change_table :speakers do |t|
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
    end
  end

  def self.down
    change_table :speakers do |t|
      t.remove :photo_file_name
      t.remove :photo_content_type
      t.remove :photo_file_size
      t.remove :photo_updated_at
    end
  end
end


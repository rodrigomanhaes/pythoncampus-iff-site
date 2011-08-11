class CreatePresentationsSpeakers < ActiveRecord::Migration
  def self.up
    create_table :presentations_speakers, :id => false do |t|
      t.references :presentation
      t.references :speaker
    end
  end

  def self.down
    drop_table :presentations_speakers
  end
end


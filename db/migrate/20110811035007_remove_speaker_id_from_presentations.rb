class RemoveSpeakerIdFromPresentations < ActiveRecord::Migration
  def self.up
    change_table(:presentations) {|t| t.remove :speaker_id }
  end

  def self.down
    change_table(:presentations) {|t| t.references :speaker }
  end
end


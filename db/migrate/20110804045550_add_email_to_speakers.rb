class AddEmailToSpeakers < ActiveRecord::Migration
  def self.up
    change_table(:speakers) {|t| t.string :email }
  end

  def self.down
    change_table(:speakers) {|t| t.remove :email }
  end
end


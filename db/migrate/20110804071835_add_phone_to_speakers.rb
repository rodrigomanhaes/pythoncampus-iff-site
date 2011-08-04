class AddPhoneToSpeakers < ActiveRecord::Migration
  def self.up
    change_table(:speakers) {|t| t.string :phone }
  end

  def self.down
    change_table(:speakers) {|t| t.remove :phone }
  end
end


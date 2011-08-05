class AddEmailToAttendees < ActiveRecord::Migration
  def self.up
    change_table(:attendees) {|t| t.string :email }
  end

  def self.down
    change_table(:attendees) {|t| t.remove :email }
  end
end


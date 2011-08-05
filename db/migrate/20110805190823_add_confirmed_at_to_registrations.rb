class AddConfirmedAtToRegistrations < ActiveRecord::Migration
  def self.up
    change_table(:registrations) {|t| t.datetime :confirmed_at }
  end

  def self.down
    change_table(:registrations) {|t| t.remove :confirmed_at }
  end
end


class AddCompleteTimeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :complete_time, :datetime
  end
end

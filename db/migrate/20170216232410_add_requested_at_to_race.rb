class AddRequestedAtToRace < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :requested_at, :datetime
  end
end

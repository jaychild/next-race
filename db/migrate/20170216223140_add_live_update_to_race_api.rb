class AddLiveUpdateToRaceApi < ActiveRecord::Migration[5.0]
  def change
    add_column :race_apis, :live_update, :boolean, default: false
  end
end

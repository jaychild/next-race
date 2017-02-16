class CreateRaceRunners < ActiveRecord::Migration[5.0]
  def change
    create_table :race_runners do |t|
      t.integer :race_id
      t.integer :runner_id
      t.datetime :requested_at

      t.timestamps
    end
  end
end

class CreateNextRaceLoggers < ActiveRecord::Migration[5.0]
  def change
    create_table :next_race_loggers do |t|
      t.string :error
      t.datetime :logged_at

      t.timestamps
    end
  end
end

class CreateRaceApis < ActiveRecord::Migration[5.0]
  def change
    create_table :race_apis do |t|
      t.string :key
      t.string :url

      t.timestamps
    end
  end
end

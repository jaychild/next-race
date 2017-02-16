class CreateRaces < ActiveRecord::Migration[5.0]
  def change
    create_table :races do |t|
      t.integer :distance
      t.datetime :time

      t.timestamps
    end
  end
end

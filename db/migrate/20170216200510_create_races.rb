class CreateRaces < ActiveRecord::Migration[5.0]
  def change
    create_table :races do |t|
      t.decimal :distance, precision: 5, scale: 2
      t.datetime :time

      t.timestamps
    end
  end
end

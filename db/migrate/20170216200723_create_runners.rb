class CreateRunners < ActiveRecord::Migration[5.0]
  def change
    create_table :runners do |t|
      t.integer :number
      t.string :horse_name
      t.string :jockey_name
      t.string :form
      t.decimal :odds, precision: 5, scale: 2

      t.timestamps
    end
  end
end

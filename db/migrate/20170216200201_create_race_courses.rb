class CreateRaceCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :race_courses do |t|
      t.string :name

      t.timestamps
    end
  end
end

class AddRaceCourseIdToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :race_course_id, :integer
  end
end

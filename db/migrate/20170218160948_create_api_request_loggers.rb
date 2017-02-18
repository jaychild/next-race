class CreateApiRequestLoggers < ActiveRecord::Migration[5.0]
  def change
    create_table :api_request_loggers do |t|
      t.string :api_request
      t.string :api_response
      t.integer :api_id
      t.string :api_errors

      t.timestamps
    end
  end
end

class AddCodeToApiRequestLogger < ActiveRecord::Migration[5.0]
  def change
    add_column :api_request_loggers, :code, :integer
  end
end

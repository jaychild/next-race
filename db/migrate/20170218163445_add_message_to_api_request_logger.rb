class AddMessageToApiRequestLogger < ActiveRecord::Migration[5.0]
  def change
    add_column :api_request_loggers, :message, :string
  end
end

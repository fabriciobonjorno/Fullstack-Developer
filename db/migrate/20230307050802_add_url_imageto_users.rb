class AddUrlImagetoUsers < ActiveRecord::Migration[7.0]
  if table_exists? 'users'
    def change
      add_column :users, :url_image, :string, index: true unless column_exists? 'users', :url_image
    end
  end
end

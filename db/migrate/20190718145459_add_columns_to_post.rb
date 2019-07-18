class AddColumnsToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :title, :string
    add_column :posts, :body, :text
    add_column :posts, :is_featured, :integer
    add_column :posts, :is_hidden, :integer
  end
end

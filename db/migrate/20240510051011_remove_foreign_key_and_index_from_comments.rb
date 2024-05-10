class RemoveForeignKeyAndIndexFromComments < ActiveRecord::Migration[7.0]
  def change
    # Remove the foreign key constraint
    remove_foreign_key :comments, :posts

    # Remove the index on post_id
    remove_index :comments, :post_id

    # Remove the post_id column
    remove_column :comments, :post_id
  end
end

class AddOperatorToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :created_by, :integer
    add_column :posts, :updated_by, :integer
    add_column :posts, :deleted_by, :integer
    add_column :posts, :deleted, :boolean
  end
end

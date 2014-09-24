class AddOperatorToComments < ActiveRecord::Migration
  def change
    add_column :comments, :created_by, :integer
    add_column :comments, :updated_by, :integer
    add_column :comments, :deleted_by, :integer
    add_column :comments, :deleted, :boolean
  end
end

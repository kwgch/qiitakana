class AddPrivateToPost < ActiveRecord::Migration
  def change
    add_column :posts, :private, :boolean
  end
end

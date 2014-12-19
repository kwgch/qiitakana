class RemovePrivateFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :private, :boolean
  end
end

class RemoveTemporaryFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :temporary, :boolean
  end
end

class AddTemoraryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :temporary, :boolean, default: false
  end
end

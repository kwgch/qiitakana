class AddPostedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :posted_at, :timestamp
  end
end

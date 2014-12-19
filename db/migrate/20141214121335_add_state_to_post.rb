class AddStateToPost < ActiveRecord::Migration
  def change
    add_column :posts, :state, :integer
  end
end

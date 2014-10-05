class Profile < ActiveRecord::Migration
  def change
    add_column :profiles, :organization, :string
  end
end

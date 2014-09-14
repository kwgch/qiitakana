class CreateUserAuths < ActiveRecord::Migration
  def change
    create_table :user_auths do |t|
      t.references :user, index: true, null: false
      t.string :uid, null: false
      t.string :provider, null: false

      t.timestamps
    end
    add_index :user_auths, [:uid, :provider], unique: true
  end
end

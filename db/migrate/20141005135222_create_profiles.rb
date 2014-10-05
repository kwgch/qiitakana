class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.string :first_name
      t.string :last_name
      t.string :website_url
      t.string :location
      t.text :description
      t.string :facebook_id
      t.string :linkedin_id
      t.string :google_plus_id

      t.timestamps
    end
  end
end

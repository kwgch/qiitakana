class CreateTagFollows < ActiveRecord::Migration
  def change
    create_table :tag_follows do |t|
      t.references :user, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end

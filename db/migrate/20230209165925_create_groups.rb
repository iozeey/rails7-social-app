class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string   :title
      t.references :user, null: false, foreign_key: true

      t.datetime :last_activity
      t.timestamps
    end
  end
end

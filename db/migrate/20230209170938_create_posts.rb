class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string   :title
      t.text   :content

      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
     
      t.datetime :last_activity
      t.timestamps
    end
  end
end

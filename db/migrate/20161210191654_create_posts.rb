class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.references :address, foreign_key: true, null: false
      t.float :rating, null: false, default: 0

      t.timestamps
    end
  end
end

class AddIndexToPostsRating < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, :rating
  end
end

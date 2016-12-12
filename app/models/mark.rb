class Mark < ApplicationRecord
  belongs_to :post
  after_create :update_rating

  private

    def update_rating
      post = self.post
      mark = self.value
      if (quantity = post.marks.count) > 1
        new_rating = (post.rating * (quantity - 1) + mark) / quantity
        post.update_attributes(rating: new_rating)
      else
        post.update_attributes(rating: mark)
      end
    end
end

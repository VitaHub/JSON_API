require 'rails_helper'

RSpec.describe Mark, type: :model do

  describe "creation" do
    let(:post) {create(:post)}

    it "can create new mark" do
      expect(post.marks.count).to eq(0)
      create(:mark, post: post)
      expect(post.marks.count).to eq(1)
      expect(Mark.count).to eq(1)
    end

    it "can't create new mark unless (1..5) === value" do
      expect { 
        create(:mark, value: 10, post: post) 
      }.to raise_error(ActiveRecord::StatementInvalid)
      expect(Mark.count).to eq(0)
    end

    it "can'n create new mark with empty value" do
      expect {
        create(:mark, value: nil, post: post)
      }.to raise_error(ActiveRecord::StatementInvalid)
      expect(Mark.count).to eq(0)
    end

    it "can'n create new mark with not existing post" do
      expect {
        create(:mark, value: 5, post: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
      expect(Mark.count).to eq(0)
    end 

    it "can update posts rating" do
      expect(post.rating).to eq(0.0)
      create(:mark, post: post, value: 5)
      expect(post.rating).to eq(5.0)
      create(:mark, post: post, value: 4)
      expect(post.rating).to eq(4.5)
    end
  end

end

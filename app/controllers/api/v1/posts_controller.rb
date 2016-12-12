module Api::V1
  class PostsController < ApiController

    def index
      limit = params[:limit] ? params[:limit] : 100
      render json: Post.order(rating: :desc).limit(limit)
    end

  end
end
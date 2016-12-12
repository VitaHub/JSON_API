module Api::V1
  class MarksController < ApiController
    @@mutex = Mutex.new

    def create
      @@mutex.synchronize do
        begin
          new_mark = Mark.new(mark_params)
          if new_mark.save
            post = Post.find(mark_params[:post_id])
            render json: post, serializer: PostRatingSerializer
          end
        rescue Exception => e
          render :json => e.message.to_json, :status => 500
        end
      end
    end

    private

      def mark_params
        params.permit(:post_id, :value)
      end

  end
end
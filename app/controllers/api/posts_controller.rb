module Api
  class PostsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    respond_to :json

    # GET /api/posts
    def index
      respond_with(Post.all.order('id DESC'))
    end

    # GET /api/posts/1
    def show
      respond_with(Post.find(params[:id]))
    end

    # POST /api/posts
    def create
      @post = Post.new(post_params)

      respond_to do |format|
        status = @post.save ? 200 : 422
        format.json { render json: @post, status: status }
      end
    end

    # PATCH/PUT /api/posts/1
    def update
      @post = Post.find(params[:id])

      respond_to do |format|
        status = @post.update(post_params) ? 200 : 422
        format.json { render json: @post, status: status }
      end
    end

    # DELETE /api/posts/1
    def destroy
      @post = Post.find(params[:id])
      @post.destroy

      respond_to do |format|
        status = @post.destroyed? ? 200 : 422        
        format.json { render json: @post, status: status }
      end
    end

    private
    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
  end
end

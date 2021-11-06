class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :destroy] 

  # def index
  #   @posts = Post.all
  #   @post = Post.new
  # end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(content: params[:post][:content],
    #                 title: params[:post][:title]
    # )
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save!
        format.js { render nothing: true, notice: 'Post saved!' }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update!(post_params)
        format.js { render layout: false, notice: 'Updated post' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy!
        format.js { render layout: false, notice: 'Post deleted!' }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :title)
  end
end

class HomeController < ApplicationController
  def index
    # @posts = Post.order(:created_at).reverse_order
    @post = Post.new

    # First way: search with AJAX
    # if params[:q]
    #   @posts = Post.where('content LIKE ? or title LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%") 
    # else
    #   @posts = Post.order(:created_at).reverse_order
    # end

    # Second way: search with AJAX
    @posts = "COALESCE(title, '') LIKE '%'"
    unless params[:q].nil?
      posts = "COALESCE(title, '') LIKE '%" + params[:q] + "%' OR COALESCE(content, '') LIKE '%" + params[:q] + "%'"
    end
    @posts = Post.where(posts)
  end
end

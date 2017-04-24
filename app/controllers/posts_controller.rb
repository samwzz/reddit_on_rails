class PostsController < ApplicationController
  before_action :require_signed_in, except: [:show]
  before_action :require_user_owns_post, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content,
                                 :sub_id, :user_id )
  end

  def require_user_owns_post
    return if current_user.posts.find_by(id: params[:id])
    render json: "Forbidden", status: :forbidden
  end
end

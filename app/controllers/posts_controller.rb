class PostsController < ApplicationController
  before_action :set_and_authorize_post, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, only: [:new,
                                          :create,
                                          :destroy,
                                          :update,
                                          :edit]

  def index
    @posts = Post.latest
                 .includes(:user)
                 .with_tag(params[:tag_id])
                 .order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 15)
                 .decorate
    @tags = Tag.all
  end

  def show
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    authorize @post

    if @post.save
      redirect_to post_path(@post), notice: 'Post successfully created'
    else
      redirect_to new_post_path, alert: @post.errors.values.join(', ')
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path, notice: 'Post successfully updated'
    else
      redirect_back_or_to(post_path(@post), alert: 'Can not update the post')
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: 'Post successfully deleted'
    else
      redirect_to post_path(@post), alert: 'Can not delete the post'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title,
                                 :body,
                                 picture_attributes: picture_attributes
    ).merge(user_id: current_user.id)
  end

  def picture_attributes
    [:picture, :id]
  end

  def set_and_authorize_post
    @post = Post.find(params[:id]).decorate
    authorize @post
  end
end
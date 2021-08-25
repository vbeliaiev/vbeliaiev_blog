class PostsController < ApplicationController
  before_action :set_and_authorize_post, only: %i[show edit update destroy]
  after_action :verify_authorized, only: %i[new create destroy update edit]

  before_action :set_categories, only: %i[index show]
  def index
    @posts = Post.includes(:user, :picture, :tags)
                 .with_tag_id(params[:tag_id])
                 .with_category_id(params[:category_id])
                 .latest
                 .paginate(page: params[:page], per_page: 10)

    @tags = Tag.select(:id, :name).latest
    @current_tag = Tag.find_by(id: params[:tag_id])

  end

  def show; end

  def edit; end

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

  def set_categories
    @current_category = Category.find_by(id: params[:category_id])
    @categories = Category.select(:id, :name).order(name: :asc)
  end

  def post_params
    params.require(:post).permit(:title,
                                 :body,
                                 picture_attributes: picture_attributes)
          .merge(user_id: current_user.id)
  end

  def picture_attributes
    %i[picture id]
  end

  def set_and_authorize_post
    @post = Post.find(params[:id])
    authorize @post
  end
end
